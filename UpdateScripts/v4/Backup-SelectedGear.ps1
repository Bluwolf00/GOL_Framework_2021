# Backup-SelectedGear.ps1  (Framework 3.1 -> Framework 4)
#
# Reads the old mission's CBA gear selections from mission.sqm and stages
# the selected faction source files before Master-Update deletes Modules\.
param(
    [string]$MissionDir,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = if ($MissionDir) { (Resolve-Path -LiteralPath $MissionDir).Path } else { Split-Path -Parent (Split-Path -Parent $ScriptDir) }

if (-not $LogFile) {
    $LogFile = Join-Path $ScriptDir "undo_log.txt"
} elseif (-not [System.IO.Path]::IsPathRooted($LogFile)) {
    $LogFile = Join-Path $MissionDir $LogFile
}

function Log-Message {
    param([string]$Message)

    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    Write-Host $line
    if ($LogFile) {
        Add-Content -LiteralPath $LogFile -Value $line -Encoding UTF8
    }
}

function Get-SelectedGearKit {
    param(
        [string]$MissionContent,
        [string]$SettingName
    )

    # CBA serializes setting names and values as parallel ItemN arrays in
    # mission.sqm. Find the ItemN that names the setting, then read Item0 in
    # the matching value array. This avoids relying on a fixed Item number.
    $settingPattern = '(?is)class\s+Item(?<Index>\d+)\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"STRING"\s*;\s*value\s*=\s*"' + [regex]::Escape($SettingName) + '"\s*;\s*\}\s*;\s*\}'
    $settingMatch = [regex]::Match($MissionContent, $settingPattern)
    if (-not $settingMatch.Success) {
        return $null
    }

    $itemIndex = $settingMatch.Groups['Index'].Value
    $valuePattern = '(?is)class\s+Item' + $itemIndex + '\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"ARRAY"\s*;\s*class\s+value\s*\{\s*items\s*=\s*2\s*;\s*class\s+Item0\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"STRING"\s*;\s*value\s*=\s*"(?<Kit>[^"]+)"\s*;'
    $valueMatch = [regex]::Match($MissionContent, $valuePattern)
    if (-not $valueMatch.Success) {
        return $null
    }

    return $valueMatch.Groups['Kit'].Value
}

$missionSqmPath = Join-Path $MissionDir "mission.sqm"
if (-not (Test-Path -LiteralPath $missionSqmPath -PathType Leaf)) {
    Log-Message "Gear backup skipped: mission.sqm was not found."
    return
}

$sourceDirectory = Join-Path $MissionDir "Modules\Gear\Scripts\Classes"
if (-not (Test-Path -LiteralPath $sourceDirectory -PathType Container)) {
    Log-Message "Gear backup skipped: legacy faction directory was not found: Modules\Gear\Scripts\Classes"
    return
}

$missionContent = Get-Content -LiteralPath $missionSqmPath -Raw
$stagingDirectory = Join-Path $ScriptDir "SelectedGearBackups"
$selections = @(
    @{ Setting = "gw_gear_blufor"; Destination = "CUSTOM-W.sqf" },
    @{ Setting = "gw_gear_opfor"; Destination = "CUSTOM-E.sqf" },
    @{ Setting = "gw_gear_independent"; Destination = "CUSTOM-I.sqf" }
)

foreach ($selection in $selections) {
    $kit = Get-SelectedGearKit -MissionContent $missionContent -SettingName $selection.Setting
    if ([string]::IsNullOrWhiteSpace($kit)) {
        Log-Message "Gear backup warning: could not determine $($selection.Setting) from mission.sqm."
        continue
    }

    $sourcePath = Join-Path $sourceDirectory ("{0}.sqf" -f $kit)
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        Log-Message "Gear backup warning: $($selection.Setting) selects '$kit', but Modules\Gear\Scripts\Classes\$kit.sqf was not found."
        continue
    }

    if (-not (Test-Path -LiteralPath $stagingDirectory -PathType Container)) {
        New-Item -ItemType Directory -Path $stagingDirectory -Force | Out-Null
        Log-Message "Created temporary selected-kit backup directory."
    }

    $destinationPath = Join-Path $stagingDirectory $selection.Destination

    try {
        Copy-Item -LiteralPath $sourcePath -Destination $destinationPath -Force -ErrorAction Stop
        Log-Message "Staged $($selection.Setting) kit '$kit' for CustomGear\$($selection.Destination)."
    } catch {
        Log-Message "Gear backup failed for $($selection.Setting) kit '$kit': $($_.Exception.Message)"
    }
}