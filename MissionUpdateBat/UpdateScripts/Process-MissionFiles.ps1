param(
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
Set-Location $MissionDir

function Log-Message {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

# === Files to process ===
$missionSqmPath = Join-Path $MissionDir "mission.sqm"
$descExtPath = Join-Path $MissionDir "Description.ext"
$extraFiles = @("spawnlist.sqf") # Add more .sqf files here if needed

# === Load files ===
if (-not (Test-Path $missionSqmPath)) {
    Log-Message "Error: mission.sqm not found. Aborting."
    exit 1
}
$missionContent = Get-Content $missionSqmPath -Raw

$descContent = ""
if (Test-Path $descExtPath) {
    $descContent = Get-Content $descExtPath -Raw
} else {
    Log-Message "Warning: Description.ext not found."
}

$extraFileContents = @{}
foreach ($file in $extraFiles) {
    $path = Join-Path $MissionDir $file
    if (Test-Path $path) {
        $extraFileContents[$file] = Get-Content $path -Raw
    } else {
        Log-Message "Warning: $file not found."
    }
}

# === Extract briefingName and author from mission.sqm ===
$briefingName = ""
$author = ""

if ($missionContent -match 'briefingName\s*=\s*"([^"]+)"') {
    $briefingName = $matches[1]
    Log-Message "Extracted briefingName: $briefingName"
} else {
    Log-Message "Warning: briefingName not found in mission.sqm"
}

if ($missionContent -match 'class\s+ScenarioData\s*\{([^}]*)\}') {
    $scenarioBlock = $matches[1]
    if ($scenarioBlock -match 'author\s*=\s*"([^"]+)"') {
        $author = $matches[1]
        Log-Message "Extracted author: $author"
    } else {
        Log-Message "Warning: author not found in ScenarioData"
    }
} else {
    Log-Message "Warning: ScenarioData not found in mission.sqm"
}

# === Replacements to perform (case-insensitive, both single and double quotes) ===
$replacements = @(
    @{ From = 'execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf"'; To = 'spawn OKS_fnc_Mechanized' },
    @{ From = 'execVM ""Scripts\OKS_Vehicles\OKS_Mechanized.sqf""'; To = 'spawn OKS_fnc_Mechanized' },
    @{ From = 'execVM "Scripts\OKS_Vehicles\OKS_Helicopter.sqf"'; To = 'spawn OKS_fnc_Helicopter' },
    @{ From = 'execVM ""Scripts\OKS_Vehicles\OKS_Helicopter.sqf""'; To = 'spawn OKS_fnc_Helicopter' },
    @{ From = 'execVM "Scripts\NEKY_ServiceStation\MobileSS.sqf"'; To = 'spawn OKS_fnc_MobileSS' },
    @{ From = 'execVM ""Scripts\NEKY_ServiceStation\MobileSS.sqf""'; To = 'spawn OKS_fnc_MobileSS' },
    @{ From = 'execVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf"'; To = 'spawn OKS_fnc_ServiceStation' },
    @{ From = 'execVM ""Scripts\NEKY_ServiceStation\ServiceStation.sqf""'; To = 'spawn OKS_fnc_ServiceStation' },
    @{ From = 'execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf"'; To = 'spawn OKS_fnc_Mortars' },
    @{ From = 'execVM ""Scripts\NEKY_Mortars\NEKY_Mortars.sqf""'; To = 'spawn OKS_fnc_Mortars' },
    @{ From = 'execVM "Scripts\OKS_Task\OKS_Evacuate_HVT.sqf"'; To = 'spawn OKS_fnc_Evacuate_HVT' },
    @{ From = 'execVM ""Scripts\OKS_Task\OKS_Evacuate_HVT.sqf""'; To = 'spawn OKS_fnc_Evacuate_HVT' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_ArtySuppression.sqf";'; To = 'spawn OKS_fnc_ArtySuppression;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_ArtySuppression.sqf"";'; To = 'spawn OKS_fnc_ArtySuppression;' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf"'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sq""'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_ArtyFire.sqf"'; To = 'spawn OKS_fnc_ArtyFire;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_ArtyFire.sqf"";'; To = 'spawn OKS_fnc_ArtyFire;' },
    @{ From = 'execVM "Scripts\OKS_Task\OKS_Defuse_Explosive.sqf"'; To = 'spawn OKS_fnc_Defuse_Explosive;' },
    @{ From = 'execVM ""Scripts\OKS_Task\OKS_Defuse_Explosive.sqf"";'; To = 'spawn OKS_fnc_Defuse_Explosive;' },	
    @{ From = 'execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf"'; To = 'spawn OKS_fnc_Destroy_Task;' },
    @{ From = 'execVM ""Scripts\OKS_Task\OKS_Destroy_Task.sqf"";'; To = 'spawn OKS_fnc_Destroy_Task;' },		
    @{ From = 'OKS_Evacuate_HVT'; To = 'OKS_fnc_Evacuate_HVT' },
    @{ From = 'OKS_ArtyFire'; To = 'OKS_fnc_ArtyFire' },
    @{ From = 'OKS_IR_AA'; To = 'OKS_fnc_IR_AA' },
    @{ From = 'OKS_Scout'; To = 'OKS_fnc_Scout' },
    @{ From = 'NEKY_Hunt_HuntBase'; To = 'OKS_fnc_Huntbase' },
    @{ From = 'OKS_Populate_StaticWeapons'; To = 'OKS_fnc_Populate_StaticWeapons' },
    @{ From = '["OKS_Chat",0]'; To = '["OKS_fnc_Chat",0]' },
    @{ From = 'OKS_Lambs_SpawnGroup'; To = 'OKS_fnc_Lambs_SpawnGroup' },
    @{ From = 'OKS_fnc_Lambs_SpawnGroup'; To = 'OKS_fnc_Lambs_SpawnGroup' },
    @{ From = 'OKS_Mechanized_Spawn'; To = 'OKS_fnc_Mechanized_Spawn' },
    @{ From = 'OKS_Radar'; To = 'OKS_fnc_Radar' },
    @{ From = 'OKS_Destroy_Barricade'; To = 'OKS_fnc_Destroy_Barricade' },
    @{ From = '"OKS_PowerGenerator"'; To = '"OKS_fnc_PowerGenerator"' },
    @{ From = 'OKS_PowerGenerator'; To = 'OKS_fnc_PowerGenerator' },
    @{ From = 'GW_Ambient_AAA'; To = 'OKS_fnc_Ambient_AAA' },
    @{ From = 'OKS_Destroy_Task'; To = 'OKS_fnc_Destroy_Task' },
    @{ From = 'OKS_Lambs_Spawner'; To = 'OKS_fnc_Lambs_Spawner' },
    @{ From = 'OKS_ArtySupression'; To = 'OKS_fnc_ArtySuppression' },
    @{ From = 'OKS_CreateZone'; To = 'OKS_fnc_CreateZone' },
    @{ From = 'OKS_Patrol_Spawn'; To = 'OKS_fnc_Patrol_Spawn' },
    @{ From = 'OKS_ClearImmediateArea'; To = 'OKS_fnc_ClearImmediateArea' },
    @{ From = 'OKS_Rush_SpawnGroup'; To = 'OKS_fnc_Rush_SpawnGroup' },
    @{ From = 'OKS_AddVehicleCrew'; To = 'OKS_fnc_AddVehicleCrew' },
    @{ From = 'OKS_Defuse_Explosive'; To = 'OKS_fnc_Defuse_Explosive' },
    @{ From = 'OKS_Convoy_Spawn'; To = 'OKS_fnc_Convoy_Spawn' },
    @{ From = 'NEKY_Airbase'; To = 'OKS_fnc_Airbase' },
    @{ From = '#include "script_Component.hpp"'; To = '#include "\OKS_GOL_MISC\script_Component.hpp"' }	
    @{ From = 'OKS_SAM'; To = 'OKS_fnc_SAM' }	
    @{ From = 'OKS_CreateObjectives'; To = 'OKS_fnc_CreateObjectives' }	
    @{ From = 'OKS_Rescue_Friendly'; To = 'OKS_fnc_Rescue_Friendly' }	
    @{ From = 'OKS_Convoy_Reinforce'; To = 'OKS_fnc_Convoy_Reinforce' }	
    @{ From = 'OKS_Surrender'; To = 'OKS_fnc_Surrender' }	
    @{ From = 'OKS_Retexture'; To = 'OKS_fnc_Retexture' }	
    @{ From = 'OKS_Rush_Spawner'; To = 'OKS_fnc_Lambs_Spawner' }	
)

function Replace-AllStringsCaseInsensitive($content, $replacements) {
    foreach ($rep in $replacements) {
        $content = [regex]::Replace($content, [regex]::Escape($rep.From), [System.Text.RegularExpressions.MatchEvaluator]{ $rep.To }, "IgnoreCase")
    }
    return $content
}

function Replace-ImagePaths($content) {
    $pattern = '(?i)(["'']?)images\\([^""''\s]+)(["'']?)'
    $content = [regex]::Replace($content, $pattern, {'$1\OKS_GOL_Misc\data\images\' + $args[0].Groups[2].Value + '$3'})
    $flagPattern = '(?i)(setFlagTexture\s*)(["'']{1,2})\s*images\\([^""'']+)(["'']{1,2})'
    $content = [regex]::Replace($content, $flagPattern, {'$1""\OKS_GOL_Misc\data\images\' + $args[0].Groups[3].Value + '""'})
    $content = [regex]::Replace($content, '(init\s*=\s*["'']{1,2})(.*?)(["'']{1,2};)', {
        param($m)
        $initPrefix = $m.Groups[1].Value
        $initCode = $m.Groups[2].Value
        $initSuffix = $m.Groups[3].Value
        $initCode = $initCode -replace '\\\$1', '' -replace '\$1', ''
        $initCode = $initCode -replace '\\\$3', '' -replace '\$3', ''
        $initCode = [regex]::Replace($initCode, '(setFlagTexture\s*)["''](\\OKS_GOL_Misc\\data\\images\\[^""'']+)["'']', 'setFlagTexture ""$2""')
        $initCode = Replace-AllStringsCaseInsensitive $initCode $replacements
        return $initPrefix + $initCode + $initSuffix
    }, 'Singleline')
    $content = [regex]::Replace($content, '(setFlagTexture\s*)"(\\OKS_GOL_Misc\\data\\images\\[^""]+)"', 'setFlagTexture ""$2""')
	$content = $content -replace 'setObjectTexture\s*\[\s*0\s*,\s*""PlatoonRoster\.jpg""\s*\]\s*;\s*', ''
    return $content
}

# === Apply replacements and image path fixes to all files ===
$missionContent = Replace-AllStringsCaseInsensitive $missionContent $replacements
$missionContent = Replace-ImagePaths $missionContent

foreach ($file in $extraFileContents.Keys) {
    $content = $extraFileContents[$file]
    $content = Replace-AllStringsCaseInsensitive $content $replacements
    $content = Replace-ImagePaths $content
    $filePath = Join-Path $MissionDir $file
    $content | Set-Content -Path $filePath -Encoding UTF8
    Log-Message "$file updated successfully"
}

# === Clean up ScenarioData: Remove ALL duplicate image/config lines, insert correct ones at top ===
$missionContent = [regex]::Replace($missionContent,
    '(class\s+ScenarioData\s*\{)(.*?)(\};)',
    {
        param($m)
        $block = $m.Groups[2].Value
        # Remove any overviewText, overViewPicture, overViewPictureLocked, loadScreen (anywhere in block, any path, any quote style)
        $block = [regex]::Replace(
            $block,
            '(?im)^\s*(overviewText|overViewPicture|overViewPictureLocked|loadScreen)\s*=\s*["'']{1,2}.*?["'']{1,2};\s*',
            '',
            'Multiline'
        )
        # Insert correct lines at the start
        $insert = @"
    overviewText="Framework Version 2.7";
    overViewPicture="\OKS_GOL_Misc\data\images\loadImage.jpg";
    overViewPictureLocked="\OKS_GOL_Misc\data\images\loadImage.jpg";
    loadScreen="\OKS_GOL_Misc\data\images\loadImage.jpg";
"@
        return $m.Groups[1].Value + "`n" + $insert + $block + $m.Groups[3].Value
    },
    'Singleline'
)
Log-Message "ScenarioData block cleaned and updated."

# === HARD CLEANUP: Remove any legacy/incorrect overViewPicture lines globally ===
$missionContent = [regex]::Replace(
    $missionContent,
    '^\s*overViewPicture\s*=\s*["''](?!\\OKS_GOL_Misc\\data\\images\\loadImage\.jpg["''];).+["''];\s*$',
    '',
    [System.Text.RegularExpressions.RegexOptions]::Multiline
)

# === HARD CLEANUP: Remove any legacy/incorrect loadScreen lines globally ===
$missionContent = [regex]::Replace(
    $missionContent,
    '^\s*loadScreen\s*=\s*["''](?!\\OKS_GOL_Misc\\data\\images\\loadImage\.jpg["''];).+["''];\s*$',
    '',
    [System.Text.RegularExpressions.RegexOptions]::Multiline
)

# === Update overviewText in class Intel (Mission) block ===
$missionContent = [regex]::Replace($missionContent,
    '(class\s+Intel\s*\{)(.*?)(\};)',
    {
        param($m)
        $block = $m.Groups[2].Value
        # Remove any existing overviewText (single or double quotes)
        $block = [regex]::Replace($block, '(?im)^\s*overviewText\s*=\s*["'']{1,2}.*?["'']{1,2};\s*', '')
        # Insert correct overviewText at the start (single quotes only)
        $insert = '    overviewText="Framework Version 2.7";' + "`n"
        return $m.Groups[1].Value + "`n" + $insert + $block + $m.Groups[3].Value
    },
    'Singleline'
)
Log-Message "Intel block cleaned and updated."

# === Description.ext updates ===
if ($descContent) {
    # Update BRIEFING_NAME with extracted briefingName
    if ($briefingName -and ($descContent -match '#define\s+BRIEFING_NAME\s+"[^"]+"')) {
        $descContent = $descContent -replace '(#define\s+BRIEFING_NAME\s+")[^"]+(")' , "`$1$briefingName`$2"
        Log-Message "Updated BRIEFING_NAME to '$briefingName' in Description.ext"
    }
    # Update Author with extracted author
    if ($author -and ($descContent -match 'Author\s*=\s*"[^"]*"')) {
        $descContent = $descContent -replace '(Author\s*=\s*")[^"]*(")' , "`$1$author`$2"
        Log-Message "Updated Author to '$author' in Description.ext"
    }
    $descReplacements = @{
        "NEKY_Hunt_HuntBase" = "OKS_fnc_Huntbase"
    }
    foreach ($key in $descReplacements.Keys) {
        if ($descContent -match [regex]::Escape($key)) {
            $descContent = $descContent -replace [regex]::Escape($key), $descReplacements[$key]
            Log-Message "Replaced '$key' with '$($descReplacements[$key])' in Description.ext"
        }
    }
    $descContent | Set-Content -Path $descExtPath -Encoding UTF8
    Log-Message "Description.ext updated"
}

# === Save mission.sqm ===
try {
    $missionContent | Set-Content -Path $missionSqmPath -Encoding UTF8
    Log-Message "mission.sqm updated successfully"
} catch {
    Log-Message "Failed to save mission.sqm: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "mission.sqm, Description.ext, and extra files updated successfully!"
Write-Host "Check undo_log.txt for details."
