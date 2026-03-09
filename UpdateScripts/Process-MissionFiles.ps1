param(
    [string]$LogFile,
    [string]$MissionDir
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = if ($MissionDir) { (Resolve-Path -LiteralPath $MissionDir).Path } else { Split-Path -Parent $ScriptDir }
Set-Location $MissionDir

if (-not $LogFile) {
    $LogFile = Join-Path $MissionDir "undo_log.txt"
} elseif (-not [System.IO.Path]::IsPathRooted($LogFile)) {
    $LogFile = Join-Path $MissionDir $LogFile
}

function Log-Message {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "$timestamp - $msg"
    Write-Host $line
    if ($LogFile) {
        try {
            Add-Content -Path $LogFile -Value $line -Encoding UTF8 -ErrorAction Stop
        } catch {
            Write-Warning "Failed to write log file: $($_.Exception.Message)"
        }
    }
}

Log-Message "Starting mission processing in: $MissionDir"
Log-Message "Log file: $LogFile"

# === Files to process ===
$missionSqmPath = Join-Path $MissionDir "mission.sqm"
$descExtPath = Join-Path $MissionDir "Description.ext"
$extraFiles = @(
    "spawnList.sqf",
    "spawnlist.sqf"
) # Add more .sqf files here if needed

# === Load files ===
if (-not (Test-Path $missionSqmPath)) {
    Log-Message "Error: mission.sqm not found. Aborting."
    exit 1
}
$missionContent = Get-Content $missionSqmPath -Raw
Log-Message "Loaded mission.sqm"

$descContent = ""
if (Test-Path $descExtPath) {
    $descContent = Get-Content $descExtPath -Raw
    Log-Message "Loaded Description.ext"
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

    # ArtySuppression: legacy missions may reference function-file from OKS_Spawn
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_fnc_ArtySuppression.sqf"'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_fnc_ArtySuppression.sqf";'; To = 'spawn OKS_fnc_ArtySuppression;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_fnc_ArtySuppression.sqf""'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_fnc_ArtySuppression.sqf"";'; To = 'spawn OKS_fnc_ArtySuppression;' },

    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_ArtySuppression.sqf"'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_ArtySuppression.sqf";'; To = 'spawn OKS_fnc_ArtySuppression;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_ArtySuppression.sqf""'; To = 'spawn OKS_fnc_ArtySuppression' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_ArtySuppression.sqf"";'; To = 'spawn OKS_fnc_ArtySuppression;' },

    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf"'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf";'; To = 'spawn OKS_fnc_CreateZone;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf""'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf"";'; To = 'spawn OKS_fnc_CreateZone;' },

    # Rush SpawnGroup is rewritten structurally (execVM -> OKS_fnc_Lambs_SpawnGroup) in Apply-StructuredLegacyRewrites.

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

    # Lambs charge spawner: legacy script path and legacy function name
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_Lambs_ChargeSpawn.sqf"'; To = 'spawn OKS_fnc_LambsChargeSpawn' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_Lambs_ChargeSpawn.sqf";'; To = 'spawn OKS_fnc_LambsChargeSpawn;' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_Lambs_ChargeSpawn.sqf""'; To = 'spawn OKS_fnc_LambsChargeSpawn' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_Lambs_ChargeSpawn.sqf"";'; To = 'spawn OKS_fnc_LambsChargeSpawn;' },
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
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_fnc_Convoy_Spawn.sqf"'; To = 'spawn OKS_fnc_Convoy_Spawn' },
    @{ From = 'execVM "Scripts\OKS_Spawn\OKS_Convoy_Reinforce.sqf"'; To = 'spawn OKS_fnc_Convoy_Reinforce' },
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
	@{ From = 'OKS_Lambs_ChargeSpawn'; To = 'OKS_fnc_LambsChargeSpawn' },
    @{ From = 'OKS_Mechanized_Spawn'; To = 'OKS_fnc_Mechanized_Spawn' },
    @{ From = 'OKS_Attack_SpawnGroup'; To = 'OKS_fnc_Attack_SpawnGroup' },
    @{ From = 'OKS_Radar'; To = 'OKS_fnc_Radar' },
    @{ From = 'OKS_Destroy_Barricade'; To = 'OKS_fnc_Destroy_Barricade' },
    @{ From = 'OKS_Destroy_Houses'; To = 'OKS_fnc_Destroy_Houses' },
    @{ From = '"OKS_PowerGenerator"'; To = '"OKS_fnc_PowerGenerator"' },
    @{ From = 'OKS_PowerGenerator'; To = 'OKS_fnc_PowerGenerator' },
    @{ From = 'GW_Ambient_AAA'; To = 'OKS_fnc_Ambient_AAA' },
    @{ From = 'execVM ""Scripts\OKS_Spawn\OKS_fnc_Ambient_AAA.sqf""'; To = 'spawn OKS_fnc_Ambient_AAA' },
    @{ From = 'OKS_IR_AA'; To = 'OKS_fnc_IR_AA' },
    @{ From = 'OKS_DeleteDeadAndObjects'; To = 'OKS_fnc_DeleteDeadAndObjects' },
    @{ From = 'OKS_Destroy_Task'; To = 'OKS_fnc_Destroy_Task' },
	@{ From = 'OKS_Deliver_Supplies'; To = 'OKS_fnc_Deliver_Supplies' },
    @{ From = 'OKS_Lambs_Spawner'; To = 'OKS_fnc_Lambs_Spawner' },
    @{ From = 'OKS_ArtySupression'; To = 'OKS_fnc_ArtySuppression' },
    @{ From = 'OKS_CreateZone'; To = 'OKS_fnc_CreateZone' },
    @{ From = 'OKS_Patrol_Spawn'; To = 'OKS_fnc_Patrol_Spawn' },
    @{ From = 'OKS_ClearImmediateArea'; To = 'OKS_fnc_ClearImmediateArea' },
    @{ From = 'OKS_AddVehicleCrew'; To = 'OKS_fnc_AddVehicleCrew' },
    @{ From = 'OKS_Defuse_Explosive'; To = 'OKS_fnc_Defuse_Explosive' },
    @{ From = 'OKS_Convoy_Spawn'; To = 'OKS_fnc_Convoy_Spawn' },
    @{ From = 'NEKY_Airbase'; To = 'OKS_fnc_Airbase' },
    @{ From = 'NEKY_AirDrop'; To = 'OKS_fnc_AirDrop' },
    @{ From = 'execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf"'; To = 'spawn OKS_fnc_AirDrop' },
    @{ From = 'execVM "Scripts\NEKY_AddActions.sqf"'; To = 'spawn OKS_fnc_NEKY_AddActions' },
    @{ From = 'execVM ""Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf""'; To = 'spawn OKS_fnc_AirDrop' },
    @{ From = 'execVM "Scripts\OKS_fnc_AirDrop\OKS_fnc_AirDrop.sqf"'; To = 'spawn OKS_fnc_AirDrop' },
    @{ From = 'execVM ""Scripts\OKS_fnc_AirDrop\OKS_fnc_AirDrop.sqf""'; To = 'spawn OKS_fnc_AirDrop' },
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

function Apply-StructuredLegacyRewrites($content) {
    # Handle legacy function calls where the new function requires a different parameter order/count.
    # These rewrites run BEFORE the simple literal replacement table.

    $ordinalIgnoreCase = [System.StringComparison]::OrdinalIgnoreCase

    function Split-TopLevelCsv([string]$text) {
        $parts = New-Object System.Collections.Generic.List[string]
        $depth = 0
        $inString = $false
        $start = 0

        for ($i = 0; $i -lt $text.Length; $i++) {
            $ch = $text[$i]

            if ($ch -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($ch -eq '[') {
                $depth++
                continue
            }
            if ($ch -eq ']') {
                if ($depth -gt 0) { $depth-- }
                continue
            }

            if ($ch -eq ',' -and $depth -eq 0) {
                $parts.Add($text.Substring($start, $i - $start).Trim())
                $start = $i + 1
            }
        }

        if ($start -le $text.Length) {
            $parts.Add($text.Substring($start).Trim())
        }

        return $parts
    }

    # OKS_Rush_Wavespawn -> OKS_fnc_Lambs_Wavespawn (inserts "rush" before side)
    # Legacy: [[pos1,pos2],UnitsPerWave,AmountOfWaves,DelayPerWave,Side,Range,"Var"] spawn OKS_Rush_Wavespawn;
    # New:    [[pos1,pos2],UnitsPerWave,AmountOfWaves,DelayPerWave,"rush",Side,Range,"Var"] spawn OKS_fnc_Lambs_Wavespawn;
    if ($content.IndexOf('OKS_Rush_Wavespawn', $ordinalIgnoreCase) -ge 0) {
        $content = [regex]::Replace(
            $content,
            '(?is)\[\s*(\[[^\]]*\])\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^\]]+?)\s*\]\s*(spawn|call)\s+OKS_Rush_Wavespawn\b',
            {
                param($m)
                [string]::Format(
                    '[{0},{1},{2},{3},"rush",{4},{5},{6}] {7} OKS_fnc_Lambs_Wavespawn',
                    $m.Groups[1].Value,
                    $m.Groups[2].Value,
                    $m.Groups[3].Value,
                    $m.Groups[4].Value,
                    $m.Groups[5].Value,
                    $m.Groups[6].Value,
                    $m.Groups[7].Value,
                    $m.Groups[8].Value
                )
            }
        )
    }

    # OKS_Rush_Spawner -> OKS_fnc_Lambs_Spawner (inserts "rush" as 2nd arg)
    # Legacy: [SpawnPos,UnitsPerBase,Side,Range,[],Trigger] spawn OKS_Rush_Spawner;
    # New:    [SpawnPos,"rush",UnitsPerBase,Side,Range,[],Trigger] spawn OKS_fnc_Lambs_Spawner;
    if ($content.IndexOf('OKS_Rush_Spawner', $ordinalIgnoreCase) -ge 0) {
        $content = [regex]::Replace(
            $content,
            '(?is)\[\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*(\[[^\]]*\])\s*,\s*([^\]]+?)\s*\]\s*(spawn|call)\s+OKS_Rush_Spawner\b',
            {
                param($m)
                [string]::Format(
                    '[{0},"rush",{1},{2},{3},{4},{5}] {6} OKS_fnc_Lambs_Spawner',
                    $m.Groups[1].Value,
                    $m.Groups[2].Value,
                    $m.Groups[3].Value,
                    $m.Groups[4].Value,
                    $m.Groups[5].Value,
                    $m.Groups[6].Value,
                    $m.Groups[7].Value
                )
            }
        )
    }

    # Rush SpawnGroup (legacy script/symbol) -> OKS_fnc_Lambs_SpawnGroup (inserts "rush" as 2nd arg)
    # Legacy execVM: [SpawnPos,InfantryCountOrVehicleArray,Side,Range] execVM "Scripts\OKS_Ambience\OKS_Rush_SpawnGroup.sqf";
    # Legacy spawn:  [SpawnPos,InfantryCountOrVehicleArray,Side,Range] spawn OKS_Rush_SpawnGroup;
    # New:          [SpawnPos,"rush",InfantryCountOrVehicleArray,Side,Range,[]] spawn OKS_fnc_Lambs_SpawnGroup;
    # Supports both OKS_Rush_SpawnGroup.sqf and OKS_fnc_Rush_SpawnGroup.sqf in the path.
    if ($content.IndexOf('Rush_SpawnGroup', $ordinalIgnoreCase) -ge 0) {
        $rushArg = '(?:selectRandom\s*\[[^\]]*\]|\[[^\]]*\]|[^,\]]+)'
        $rushTailArray = '(\[[^\]]*\])'
        $rushScript = 'Scripts\\OKS_Ambience\\OKS_(?:fnc_)?Rush_SpawnGroup\.sqf'
        $rushQuote = '"{1,2}'

        # execVM: rewrite directly to OKS_fnc_Lambs_SpawnGroup (never emit OKS_fnc_Rush_SpawnGroup).
        $patternExecVm = '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*\]\s*execVM\s*' + $rushQuote + $rushScript + $rushQuote + '\s*;'
        $content = [regex]::Replace(
            $content,
            $patternExecVm,
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',[]] spawn OKS_fnc_Lambs_SpawnGroup;'
            }
        )

        # Also handle missing semicolon (rare)
        $patternExecVmNoSemi = '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*\]\s*execVM\s*' + $rushQuote + $rushScript + $rushQuote
        $content = [regex]::Replace(
            $content,
            $patternExecVmNoSemi,
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',[]] spawn OKS_fnc_Lambs_SpawnGroup'
            }
        )

        # spawn/call with explicit trailing array argument
        $patternSpawnWithArr = '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*,\s*(?<p5>' + $rushTailArray + ')\s*\]\s*(?<mode>spawn|call)\s+OKS_Rush_SpawnGroup\b'
        $content = [regex]::Replace(
            $content,
            $patternSpawnWithArr,
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',' + $m.Groups['p5'].Value + '] ' + $m.Groups['mode'].Value + ' OKS_fnc_Lambs_SpawnGroup'
            }
        )

        # spawn/call without trailing array argument
        $patternSpawnNoArr = '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*\]\s*(?<mode>spawn|call)\s+OKS_Rush_SpawnGroup\b'
        $content = [regex]::Replace(
            $content,
            $patternSpawnNoArr,
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',[]] ' + $m.Groups['mode'].Value + ' OKS_fnc_Lambs_SpawnGroup'
            }
        )
    }

    # OKS_fnc_Rush_SpawnGroup -> OKS_fnc_Lambs_SpawnGroup (inserts "rush" as 2nd arg)
    # Legacy: [SpawnPos,InfantryCountOrVehicleArray,Side,Range] (spawn/call) OKS_fnc_Rush_SpawnGroup;
    # Legacy: [SpawnPos,InfantryCountOrVehicleArray,Side,Range,[]] (spawn/call) OKS_fnc_Rush_SpawnGroup;
    # New:    [SpawnPos,"rush",InfantryCountOrVehicleArray,Side,Range,[]] (spawn/call) OKS_fnc_Lambs_SpawnGroup;
    if ($content.IndexOf('OKS_fnc_Rush_SpawnGroup', $ordinalIgnoreCase) -ge 0) {
        $rushArg = '(?:selectRandom\s*\[[^\]]*\]|\[[^\]]*\]|[^,\]]+)'
        $rushTailArray = '(\[[^\]]*\])'

        $content = [regex]::Replace(
            $content,
            '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*,\s*(?<p5>' + $rushTailArray + ')\s*\]\s*(?<mode>spawn|call)\s+OKS_fnc_Rush_SpawnGroup\b',
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',' + $m.Groups['p5'].Value + '] ' + $m.Groups['mode'].Value + ' OKS_fnc_Lambs_SpawnGroup'
            }
        )

        $content = [regex]::Replace(
            $content,
            '(?is)\[\s*(?<p1>' + $rushArg + ')\s*,\s*(?<p2>' + $rushArg + ')\s*,\s*(?<p3>' + $rushArg + ')\s*,\s*(?<p4>' + $rushArg + ')\s*\]\s*(?<mode>spawn|call)\s+OKS_fnc_Rush_SpawnGroup\b',
            {
                param($m)
                '[' + $m.Groups['p1'].Value + ',"rush",' + $m.Groups['p2'].Value + ',' + $m.Groups['p3'].Value + ',' + $m.Groups['p4'].Value + ',[]] ' + $m.Groups['mode'].Value + ' OKS_fnc_Lambs_SpawnGroup'
            }
        )
    }

    # OKS_PlayerWaypoint_SpawnGroup -> OKS_fnc_Lambs_SpawnGroup (Lambs type "attack")
    # Legacy commonly: [SpawnPos,UnitOrClassname,Side,Range,TargetWaypoint,StepWaypoint,<legacyFlag>] (spawn/call)
    # New:             [SpawnPos,"attack",UnitOrClassname,Side,Range,[]] (target/step/flag are not used by Lambs SpawnGroup)
    if ($content.IndexOf('OKS_PlayerWaypoint_SpawnGroup', $ordinalIgnoreCase) -ge 0) {
        # Keep this pattern intentionally simple for performance and reliability.
        # Assumes: 1st arg is scalar or simple array; 2nd arg is scalar or selectRandom[...] or simple array.
        $spawnArg = '(?:\[[^\]]*\]|[^,\]]+)'
        $unitArg = '(?:selectRandom\[[^\]]*\]|\[[^\]]*\]|[^,\]]+)'
        $pattern = "(?is)\[\s*($spawnArg)\s*,\s*($unitArg)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*[^\]]*\]\s*(spawn|call)\s+OKS_PlayerWaypoint_SpawnGroup\b"
        $content = [regex]::Replace(
            $content,
            $pattern,
            {
                param($m)
                $spawn = $m.Groups[1].Value
                $classnameOrNumber = $m.Groups[2].Value
                $side = $m.Groups[3].Value
                $range = $m.Groups[4].Value
                $mode = $m.Groups[5].Value
                "[$spawn,""attack"",$classnameOrNumber,$side,$range,[]] $mode OKS_fnc_Lambs_SpawnGroup"
            }
        )
    }

    # OKS_fnc_Lambs_SpawnGroup vehicle argument normalization
    # fn_Lambs_SpawnGroup expects the 3rd parameter to be either:
    # - SCALAR (infantry count)
    # - ARRAY  (vehicle mode): [_VehicleTypesArray, _CargoCount]
    # Some legacy spawnLists pass a vehicle classname string or selectRandom[...] (string) as param #3.
    # This rewrite converts those into: [["classname"],0] or [["a","b"],0]
    if ($content.IndexOf('OKS_fnc_Lambs_SpawnGroup', $ordinalIgnoreCase) -ge 0) {
        $spawnArg = '(?:\[[^\]]*\]|[^,\]]+)'
        $typeArg = '"[^"]+"'
        $vehicleArg = '(?:selectRandom\[[^\]]+\]|"[^"]+")'
        $tailArg = '(?:\[[^\]]*\]|[^,\]]+)'

        $pattern = "(?is)\[\s*($spawnArg)\s*,\s*($typeArg)\s*,\s*($vehicleArg)\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*($tailArg)\s*\]\s*(spawn|call)\s+OKS_fnc_Lambs_SpawnGroup\b"

        $content = [regex]::Replace(
            $content,
            $pattern,
            {
                param($m)
                $spawn = $m.Groups[1].Value
                $lambsType = $m.Groups[2].Value
                $vehicleSpec = $m.Groups[3].Value
                $side = $m.Groups[4].Value
                $range = $m.Groups[5].Value
                $arr = $m.Groups[6].Value
                $mode = $m.Groups[7].Value

                $vehicleTypesArray = $null
                if ($vehicleSpec -match '^selectRandom\[(?<arr>[^\]]+)\]$') {
                    # $Matches['arr'] is the inner list (e.g. "a","b") so wrap it back into an array literal.
                    $vehicleTypesArray = "[$($Matches['arr'])]"
                } else {
                    # quoted classname string
                    $vehicleTypesArray = "[$vehicleSpec]"
                }

                "[$spawn,$lambsType,[$vehicleTypesArray,0],$side,$range,$arr] $mode OKS_fnc_Lambs_SpawnGroup"
            }
        )

        # Fix malformed vehicle arrays like ["a","b",0] -> [["a","b"],0]
        # (Only targets cases where the 3rd argument is an array of 2+ strings ending with 0.)
        $patternFix = '(?is)\[\s*(' + $spawnArg + ')\s*,\s*(' + $typeArg + ')\s*,\s*\[(\s*"[^"]+"(?:\s*,\s*"[^"]+")+\s*),\s*0\s*\]\s*,\s*([^,\]]+)\s*,\s*([^,\]]+)\s*,\s*(' + $tailArg + ')\s*\]\s*(spawn|call)\s+OKS_fnc_Lambs_SpawnGroup\b'
        $content = [regex]::Replace(
            $content,
            $patternFix,
            {
                param($m)
                $spawn = $m.Groups[1].Value
                $lambsType = $m.Groups[2].Value
                $vehicleList = $m.Groups[3].Value
                $side = $m.Groups[4].Value
                $range = $m.Groups[5].Value
                $arr = $m.Groups[6].Value
                $mode = $m.Groups[7].Value
                "[$spawn,$lambsType,[[$vehicleList],0],$side,$range,$arr] $mode OKS_fnc_Lambs_SpawnGroup"
            }
        )
    }

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

foreach ($file in $extraFileContents.Keys) {
    $content = $extraFileContents[$file]
    $content = Apply-StructuredLegacyRewrites $content
    $content = Replace-AllStringsCaseInsensitive $content $replacements
    $content = Apply-StructuredLegacyRewrites $content
    $content = Remove-LegacyLines $content
    $filePath = Join-Path $MissionDir $file
    try {
        $content | Set-Content -Path $filePath -Encoding UTF8 -ErrorAction Stop
        Log-Message "$file updated successfully"
    } catch {
        Log-Message "Failed to save ${file}: $($_.Exception.Message)"
    }
}

# === Apply replacements and image path fixes to mission.sqm ===
Log-Message "Processing mission.sqm rewrites..."
$missionContent = Apply-StructuredLegacyRewrites $missionContent
Log-Message "mission.sqm: structured rewrites done"
$missionContent = Replace-AllStringsCaseInsensitive $missionContent $replacements
Log-Message "mission.sqm: string replacements done"
$missionContent = Apply-StructuredLegacyRewrites $missionContent
Log-Message "mission.sqm: structured rewrites (post-replacements) done"
$missionContent = Replace-ImagePaths $missionContent
Log-Message "mission.sqm: image path fixes done"
$missionContent = Remove-LegacyLines $missionContent
Log-Message "mission.sqm: legacy line removal done"

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
    try {
        $descContent | Set-Content -Path $descExtPath -Encoding UTF8 -ErrorAction Stop
        Log-Message "Description.ext updated"
    } catch {
        Log-Message "Failed to save Description.ext: $($_.Exception.Message)"
    }
}

# === Save mission.sqm ===
try {
    Log-Message "Saving mission.sqm..."
    $missionContent | Set-Content -Path $missionSqmPath -Encoding UTF8 -ErrorAction Stop
    Log-Message "mission.sqm updated successfully"
} catch {
    Log-Message "Failed to save mission.sqm: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "mission.sqm, Description.ext, and extra files updated successfully!"
Write-Host "Check undo_log.txt for details."
