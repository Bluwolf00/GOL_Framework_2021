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

# === Extract mission name from parent folder name ===
$folderName = Split-Path -Leaf $MissionDir
$briefingName = ""

# Regex: Matches CO@38_Mission_Name.map or COOP-10 Mission%20Name.map etc.
if ($folderName -match '^(CO|COOP|TVT|PVP|ATG)[@-](\d+)[\s_](.+?)\.([^.]+)$') {
    $gameMode = $matches[1]
    $playerCount = $matches[2]
    $missionName = $matches[3]
    $mapName = $matches[4]
    
    # Decode URL-encoded spaces and normalize delimiters
    $missionName = $missionName -replace '%2520', ' '  # Double-encoded space
    $missionName = $missionName -replace '%20', ' '    # URL-encoded space
    $missionName = $missionName -replace '_', ' '      # Underscore to space
    $missionName = $missionName -replace '\s+', ' '    # Normalize multiple spaces
    $missionName = $missionName.Trim()
    
    # Use only the mission name for briefingName
    $briefingName = "$missionName"
    Log-Message "Parsed folder name: $folderName"
    Log-Message "Extracted briefingName: $briefingName"
    Log-Message "Map: $mapName"
} else {
    Log-Message "Warning: Could not parse mission folder name: $folderName"
    Log-Message "Expected format: GAMEMODE@NN_Mission_Name.mapname"
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
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_ArtySuppression.sqf"'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_ArtySuppression.sqf";'; To = 'spawn OKS_fnc_ArtySuppression;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_ArtySuppression.sqf""'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_ArtySuppression.sqf"";'; To = 'spawn OKS_fnc_ArtySuppression;' },

    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf"'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf";'; To = 'spawn OKS_fnc_CreateZone;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf""'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf"";'; To = 'spawn OKS_fnc_CreateZone;' },

    # ArtyFire: legacy missions often use the function-file name via execVM
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_fnc_ArtyFire.sqf"'; To = 'spawn OKS_fnc_ArtyFire' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_fnc_ArtyFire.sqf";'; To = 'spawn OKS_fnc_ArtyFire;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_fnc_ArtyFire.sqf""'; To = 'spawn OKS_fnc_ArtyFire' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_fnc_ArtyFire.sqf"";'; To = 'spawn OKS_fnc_ArtyFire;' },

    # AirSpawn/AirStrike/AirCargoDrop/Helicopter_Attack: legacy script paths
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirSpawn.sqf"'; To = 'spawn OKS_fnc_AirSpawn' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirSpawn.sqf";'; To = 'spawn OKS_fnc_AirSpawn;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirSpawn.sqf""'; To = 'spawn OKS_fnc_AirSpawn' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirSpawn.sqf"";'; To = 'spawn OKS_fnc_AirSpawn;' },

    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirStrike.sqf"'; To = 'spawn OKS_fnc_AirStrike' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirStrike.sqf";'; To = 'spawn OKS_fnc_AirStrike;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirStrike.sqf""'; To = 'spawn OKS_fnc_AirStrike' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirStrike.sqf"";'; To = 'spawn OKS_fnc_AirStrike;' },

    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf"'; To = 'spawn OKS_fnc_AirCargoDrop' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf";'; To = 'spawn OKS_fnc_AirCargoDrop;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf""'; To = 'spawn OKS_fnc_AirCargoDrop' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf"";'; To = 'spawn OKS_fnc_AirCargoDrop;' },

    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf"'; To = 'spawn OKS_fnc_Helicopter_Attack' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf";'; To = 'spawn OKS_fnc_Helicopter_Attack;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf""'; To = 'spawn OKS_fnc_Helicopter_Attack' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf"";'; To = 'spawn OKS_fnc_Helicopter_Attack;' },

    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_AlarmSound.sqf"'; To = 'spawn OKS_fnc_AlarmSound' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_AlarmSound.sqf";'; To = 'spawn OKS_fnc_AlarmSound;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_AlarmSound.sqf""'; To = 'spawn OKS_fnc_AlarmSound' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_AlarmSound.sqf"";'; To = 'spawn OKS_fnc_AlarmSound;' },
    @{ From = 'execVM "Scripts\OKS_Task\OKS_Defuse_Explosive.sqf"'; To = 'spawn OKS_fnc_Defuse_Explosive;' },
    @{ From = 'execVM ""Scripts\OKS_Task\OKS_Defuse_Explosive.sqf"";'; To = 'spawn OKS_fnc_Defuse_Explosive;' },	
    @{ From = 'execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf"'; To = 'spawn OKS_fnc_Destroy_Task;' },
    @{ From = 'execVM ""Scripts\OKS_Task\OKS_Destroy_Task.sqf"";'; To = 'spawn OKS_fnc_Destroy_Task;' },		
	@{ From = 'execVM "Scripts\OKS_Task\OKS_Deliver_Supplies\OKS_Deliver_Supplies.sqf"'; To = 'spawn OKS_fnc_Deliver_Supplies' },
	@{ From = 'execVM ""Scripts\OKS_Task\OKS_Deliver_Supplies\OKS_Deliver_Supplies.sqf""'; To = 'spawn OKS_fnc_Deliver_Supplies' },
        @{ From = 'execVM "Scripts\OKS_Task\OKS_Request_Intel\OKS_Request_Intel.sqf"'; To = 'spawn OKS_fnc_Request_Intel' },
        @{ From = 'execVM "Scripts\OKS_Task\OKS_Request_Intel\OKS_Request_Intel.sqf";'; To = 'spawn OKS_fnc_Request_Intel;' },
        @{ From = 'execVM ""Scripts\OKS_Task\OKS_Request_Intel\OKS_Request_Intel.sqf""'; To = 'spawn OKS_fnc_Request_Intel' },
        @{ From = 'execVM ""Scripts\OKS_Task\OKS_Request_Intel\OKS_Request_Intel.sqf"";'; To = 'spawn OKS_fnc_Request_Intel;' },
    @{ From = 'OKS_Evacuate_HVT'; To = 'OKS_fnc_Evacuate_HVT' },
    @{ From = 'OKS_ArtyFire'; To = 'OKS_fnc_ArtyFire' },
    @{ From = 'OKS_AI_Battle'; To = 'OKS_fnc_AI_Battle' },
    @{ From = 'OKS_AirSpawn'; To = 'OKS_fnc_AirSpawn' },
    @{ From = 'OKS_AirStrike'; To = 'OKS_fnc_AirStrike' },
    @{ From = 'OKS_AirCargoDrop'; To = 'OKS_fnc_AirCargoDrop' },
    @{ From = 'OKS_Helicopter_Attack'; To = 'OKS_fnc_Helicopter_Attack' },
    @{ From = 'OKS_Scout'; To = 'OKS_fnc_AirScout' },
    @{ From = 'OKS_fnc_Scout'; To = 'OKS_fnc_AirScout' },
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
    @{ From = 'OKS_IR_AA'; To = 'OKS_fnc_IR_AA' },
    @{ From = 'OKS_DeleteDeadAndObjects'; To = 'OKS_fnc_DeleteDeadAndObjects' },
    @{ From = 'OKS_Destroy_Task'; To = 'OKS_fnc_Destroy_Task' },
	@{ From = 'OKS_Deliver_Supplies'; To = 'OKS_fnc_Deliver_Supplies' },
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
    @{ From = '#include "script_Component.hpp"'; To = '#include "\OKS_GOL_MISC\script_Component.hpp"' },
    @{ From = 'OKS_SAM'; To = 'OKS_fnc_SAM' },
    @{ From = 'OKS_CreateObjectives'; To = 'OKS_fnc_CreateObjectives' },
    @{ From = 'OKS_Rescue_Friendly'; To = 'OKS_fnc_Rescue_Friendly' },
    @{ From = 'OKS_Convoy_Reinforce'; To = 'OKS_fnc_Convoy_Reinforce' },
    @{ From = 'OKS_Surrender'; To = 'OKS_fnc_Surrender' },
    @{ From = 'OKS_Civilians'; To = 'OKS_fnc_Civilians' },
    @{ From = 'OKS_Retexture'; To = 'OKS_fnc_Retexture' }
)

function Replace-AllStringsCaseInsensitive($content, $replacements) {
    foreach ($rep in $replacements) {
        $content = [regex]::Replace($content, [regex]::Escape($rep.From), [System.Text.RegularExpressions.MatchEvaluator]{ $rep.To }, "IgnoreCase")
    }
    return $content
}

function Remove-LegacyLines($content) {
    # Remove full lines containing legacy calls that should no longer exist
    # Example: [... ] spawn OKS_Inactive_VehicleSpawn;
    $content = [regex]::Replace(
        $content,
        '(?im)^.*\bspawn\s+OKS_Inactive_VehicleSpawn\b\s*;\s*(?:\r?\n|$)',
        ''
    )
    return $content
}

function Replace-ImagePaths($content) {
    # Only process init= lines in mission.sqm, don't touch Description.ext image paths
    $content = [regex]::Replace($content, '(init\s*=\s*["'']{1,2})(.*?)(["'']{1,2};)', {
        param($m)
        $initPrefix = $m.Groups[1].Value
        $initCode = $m.Groups[2].Value
        $initSuffix = $m.Groups[3].Value
        
        # Replace images\\ with full path in init code
        $initCode = $initCode -replace '(?i)images\\\\', '\OKS_GOL_Misc\data\images\'
        
        # Fix setFlagTexture to use double quotes
        $initCode = [regex]::Replace($initCode, '(setFlagTexture\s*)["''](\\OKS_GOL_Misc\\data\\images\\[^""'']+)["'']', 'setFlagTexture ""$2""')
        
        # Apply other replacements
        $initCode = Replace-AllStringsCaseInsensitive $initCode $replacements
        
        return $initPrefix + $initCode + $initSuffix
    }, 'Singleline')
    
    # Remove PlatoonRoster setObjectTexture lines
    $content = $content -replace 'setObjectTexture\s*\[\s*0\s*,\s*""PlatoonRoster\.jpg""\s*\]\s*;\s*', ''
    
    return $content
}

# === Apply replacements and image path fixes to all files ===
$missionContent = Replace-AllStringsCaseInsensitive $missionContent $replacements
$missionContent = Replace-ImagePaths $missionContent
$missionContent = Remove-LegacyLines $missionContent

foreach ($file in $extraFileContents.Keys) {
    $content = $extraFileContents[$file]
    $content = Replace-AllStringsCaseInsensitive $content $replacements
    $content = Replace-ImagePaths $content
    $content = Remove-LegacyLines $content
    $filePath = Join-Path $MissionDir $file
    $content | Set-Content -Path $filePath -Encoding UTF8
    Log-Message "$file updated successfully"
}

# === Apply replacements and image path fixes to mission.sqm ===
$missionContent = Replace-AllStringsCaseInsensitive $missionContent $replacements
$missionContent = Replace-ImagePaths $missionContent
$missionContent = Remove-LegacyLines $missionContent

# === Reset GW_isConfigured to trigger first-time setup ===
# Look for the pattern: property="GW_isConfigured"; ... value=1; and change value to 0
if ($missionContent -match 'property="GW_isConfigured"') {
    $missionContent = $missionContent -replace '(property="GW_isConfigured"[\s\S]*?value=)\d+;', '${1}0;'
    Log-Message "Reset GW_isConfigured to 0 (false) to trigger first-time setup"
} else {
    Log-Message "Warning: GW_isConfigured not found in mission.sqm"
}

# === Extract author from mission.sqm ===
$author = ""
if ($missionContent -match 'class\s+ScenarioData\s*\{[^}]*?author\s*=\s*"([^"]+)"') {
    $author = $matches[1]
    Log-Message "Extracted author from mission.sqm: $author"
} else {
    Log-Message "Warning: Could not find author in mission.sqm ScenarioData class"
}

# === Description.ext updates ===
if ($descContent) {
    # Update BRIEFING_NAME with extracted briefingName from folder
    if ($briefingName -and ($descContent -match '#define\s+BRIEFING_NAME\s+"[^"]+"')) {
        $descContent = $descContent -replace '(#define\s+BRIEFING_NAME\s+")[^"]+(")' , "`$1$briefingName`$2"
        Log-Message "Updated BRIEFING_NAME to '$briefingName' in Description.ext"
    } elseif ($briefingName) {
        Log-Message "Warning: BRIEFING_NAME not found in Description.ext to update"
    }
    
    # Update author with extracted value from mission.sqm
    if ($author -and ($descContent -match 'author\s*=\s*"[^"]*"')) {
        $descContent = $descContent -replace '(author\s*=\s*")[^"]*(")' , "`$1$author`$2"
        Log-Message "Updated author to '$author' in Description.ext"
    } elseif ($author) {
        Log-Message "Warning: author field not found in Description.ext to update"
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
    $descContent = Remove-LegacyLines $descContent
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
