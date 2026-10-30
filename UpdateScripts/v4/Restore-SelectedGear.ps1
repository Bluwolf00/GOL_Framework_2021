# Restore-SelectedGear.ps1  (Framework 3.1 -> Framework 4)
# Restores the staged legacy faction kits over the FW4 CUSTOM faction files.
param(
    [string]$MissionDir,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = if ($MissionDir) { (Resolve-Path -LiteralPath $MissionDir).Path } else { Split-Path -Parent (Split-Path -Parent $ScriptDir) }
$stagingDirectory = Join-Path $ScriptDir "SelectedGearBackups"
$customGearDirectory = Join-Path $MissionDir "CustomGear"

# Keep custom-kit class migrations isolated from the restore flow. Add future
# known-safe mappings here; set false only when preserving legacy classes.
$EnableCustomGearClassnameCleaner = $true

function Log-Message {
    param([string]$Message)

    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    Write-Host $line
    if ($LogFile) {
        Add-Content -LiteralPath $LogFile -Value $line -Encoding UTF8
    }
}

function Set-GearFactionSetting {
    param(
        [string]$MissionContent,
        [string]$SettingName,
        [string]$FactionName
    )

    # CBA stores setting names and values in parallel ItemN arrays. Locate the
    # ItemN for the setting name, then update Item0 in its corresponding value.
    $settingPattern = '(?is)class\s+Item(?<Index>\d+)\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"STRING"\s*;\s*value\s*=\s*"' + [regex]::Escape($SettingName) + '"\s*;\s*\}\s*;\s*\}'
    $settingMatch = [regex]::Match($MissionContent, $settingPattern)
    if (-not $settingMatch.Success) {
        return @{ Content = $MissionContent; Updated = $false }
    }

    $itemIndex = $settingMatch.Groups['Index'].Value
    $valuePattern = '(?is)(class\s+Item' + $itemIndex + '\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"ARRAY"\s*;\s*class\s+value\s*\{\s*items\s*=\s*2\s*;\s*class\s+Item0\s*\{\s*class\s+data\s*\{\s*singleType\s*=\s*"STRING"\s*;\s*value\s*=\s*")[^"]+(")'
    $valueMatch = [regex]::Match($MissionContent, $valuePattern)
    if (-not $valueMatch.Success) {
        return @{ Content = $MissionContent; Updated = $false }
    }

    return @{
        Content = [regex]::Replace($MissionContent, $valuePattern, ('${1}' + $FactionName + '${2}'), 1)
        Updated = $true
    }
}

function Convert-LegacyTfarRadioGuards {
    param([string]$Content)

    # FW3 kits use GVARMAIN(mod_TFAR), which is not defined by FW4's Gear
    # runtime. The selected kit is only restored when it is intentionally used,
    # so retain its configured radio assignment without the obsolete guard.
    return [regex]::Replace(
        $Content,
        '(?ms)^\s*if\s*\(\s*GVARMAIN\(mod_TFAR\)\s*\)\s*then\s*\{\s*\r?\n(?<assignment>\s*_backpackRadio\s*=\s*.+?;\s*)\r?\n\s*\};',
        '${assignment}'
    )
}

function Convert-LegacyCustomGearClassnames {
    param([string]$Content)

    # Exact, known-safe legacy-to-supported replacements for restored custom kits.
    # Do not use prefix stripping: each entry is a complete classname mapping.
    $classnameReplacements = [ordered]@{
        "hlc_rifle_M4" = "JCA_arifle_M4A1_black_F"
        "hlc_rifle_CQBR" = "JCA_arifle_M4A1_short_black_F"
        "hlc_rifle_m4m203" = "JCA_arifle_M4A1_GL_black_F"
        "hlc_30rnd_556x45_SOST" = "GOL_30Rnd_556x45_AP45_Mixed_Red"
        "hlc_30rnd_556x45_t" = "GOL_30Rnd_556x45_AP45_Tracer_Red"
        "hlc_lmg_mk48mod1" = "GOL_weap_m249_pip"
        "hlc_200Rnd_762x51_T_M60E4" = "GOL_rhsusf_200rnd_556x45_AP45_tracer_red"
        "hlc_20Rnd_762x51_B_M14" = "ACE_20Rnd_762x51_Mk319_Mod_0_Mag"
        "hlc_20Rnd_762x51_T_M14" = "ACE_20Rnd_762x51_Mag_Tracer"
        "hlc_grip_pmvfg_black" = ""
        "hlc_rifle_M1903A1_unertl" = "rhs_weap_t5000"
        "hlc_5rnd_3006_1903" = "rhs_5Rnd_338lapua_t5000"
    }

    foreach ($legacyClassname in $classnameReplacements.Keys) {
        $Content = $Content.Replace($legacyClassname, $classnameReplacements[$legacyClassname])
    }

    return $Content
}

if (-not (Test-Path -LiteralPath $stagingDirectory -PathType Container)) {
    Log-Message "Selected-kit restore skipped: no staged legacy kits were found."
    return
}

if (-not (Test-Path -LiteralPath $customGearDirectory -PathType Container)) {
    Log-Message "Selected-kit restore failed: CustomGear directory was not copied from the FW4 template."
    return
}

$missionSqmPath = Join-Path $MissionDir "mission.sqm"
$missionContent = if (Test-Path -LiteralPath $missionSqmPath -PathType Leaf) { Get-Content -LiteralPath $missionSqmPath -Raw } else { $null }
$missionSqmChanged = $false
$restores = @(
    @{ File = "CUSTOM-W.sqf"; Setting = "gw_gear_blufor"; Faction = "CUSTOM-W" },
    @{ File = "CUSTOM-E.sqf"; Setting = "gw_gear_opfor"; Faction = "CUSTOM-E" },
    @{ File = "CUSTOM-I.sqf"; Setting = "gw_gear_independent"; Faction = "CUSTOM-I" }
)

foreach ($restore in $restores) {
    $fileName = $restore.File
    $sourcePath = Join-Path $stagingDirectory $fileName
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        continue
    }

    try {
        $destinationPath = Join-Path $customGearDirectory $fileName
        Copy-Item -LiteralPath $sourcePath -Destination $destinationPath -Force -ErrorAction Stop
        $gearContent = Get-Content -LiteralPath $destinationPath -Raw
        $normalizedGearContent = Convert-LegacyTfarRadioGuards $gearContent
        if ($EnableCustomGearClassnameCleaner) {
            $normalizedGearContent = Convert-LegacyCustomGearClassnames $normalizedGearContent
        }
        if ($normalizedGearContent -ne $gearContent) {
            Set-Content -LiteralPath $destinationPath -Value $normalizedGearContent -Encoding UTF8 -ErrorAction Stop
            Log-Message "Applied custom-kit compatibility cleanup to CustomGear\$fileName."
        }
        Log-Message "Restored selected legacy kit as CustomGear\$fileName."

        if ($null -eq $missionContent) {
            Log-Message "Gear addon option was not updated: mission.sqm was not found."
            continue
        }

        $result = Set-GearFactionSetting -MissionContent $missionContent -SettingName $restore.Setting -FactionName $restore.Faction
        $missionContent = $result.Content
        if ($result.Updated) {
            $missionSqmChanged = $true
            Log-Message "Updated $($restore.Setting) to $($restore.Faction) in mission.sqm."
        } else {
            Log-Message "Gear addon option warning: could not update $($restore.Setting) in mission.sqm."
        }
    } catch {
        Log-Message "Selected-kit restore failed for CustomGear\${fileName}: $($_.Exception.Message)"
    }
}

# HLC is no longer part of the supported modset. Leave complete classnames in
# restored kits; the Gear runtime sanitizer removes them as whole entries.
# Stripping only HLC_ creates a different, invalid classname.

if ($missionSqmChanged) {
    try {
        Set-Content -LiteralPath $missionSqmPath -Value $missionContent -Encoding UTF8 -ErrorAction Stop
        Log-Message "Saved updated GW Gear addon options to mission.sqm."
    } catch {
        Log-Message "Failed to save updated GW Gear addon options: $($_.Exception.Message)"
    }
}

Remove-Item -LiteralPath $stagingDirectory -Recurse -Force
Log-Message "Removed temporary selected-kit backup directory."