# Run from mission folder to update mission files safely.

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $BaseDir

$LogFile = Join-Path $BaseDir "undo_log.txt"
if (Test-Path $LogFile) { Remove-Item $LogFile -Force }
"=== Script started at $(Get-Date) ===" | Out-File -FilePath $LogFile

function Log-Message {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

# === Folder Cleanup ===
$foldersToDelete = @("Core", "Modules", "Scripts", "images")
foreach ($folder in $foldersToDelete) {
    $fullPath = Join-Path $BaseDir $folder
    if (Test-Path $fullPath) {
        try {
            Remove-Item -Path $fullPath -Recurse -Force
            Log-Message "Deleted folder: $folder"
        } catch {
            $errMsg = $_.Exception.Message
            Log-Message "Failed to delete folder ${folder}: ${errMsg}"
        }
    }
}

# === Delete missionSettings.sqf and all loadimage.jpg files (case-insensitive) ===
$missionSettingsPath = Join-Path $BaseDir "missionSettings.sqf"
if (Test-Path $missionSettingsPath) {
    Remove-Item $missionSettingsPath -Force
    Log-Message "Deleted missionSettings.sqf"
}
Get-ChildItem -Path $BaseDir -Recurse -File | Where-Object { $_.Name -imatch '^loadimage\.jpg$' } | ForEach-Object {
    Remove-Item $_.FullName -Force
    Log-Message "Deleted $($_.FullName)"
}

# === Prompt User to Copy Framework Files ===
Write-Host ""
Write-Host "Please COPY and PASTE the following files and folders from your framework folder into this folder:"
Write-Host " - script_Compontent.hpp"
Write-Host " - onPlayerRespawn.sqf"
Write-Host " - initPlayerLocal.sqf"
Write-Host " - init.sqf"
Write-Host " - Description.ext"
Write-Host " - Modules (folder)"
Write-Host " - Core (folder)"
Write-Host ""
Write-Host "Press ENTER when done."
[void][System.Console]::ReadLine()

# === Ask About Backups ===
$createBackup = $false
do {
    Write-Host "Create .bak backup files before replacing? (Y/N): "
    $response = Read-Host
    if ($response -match "^[YyNn]$") {
        $createBackup = $response.ToUpper() -eq "Y"
        break
    }
} while ($true)

# === Files to process ===
$missionSqmPath = Join-Path $BaseDir "mission.sqm"
$descExtPath = Join-Path $BaseDir "Description.ext"
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
    $path = Join-Path $BaseDir $file
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
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_fnc_CreateZone.sqf""'; To = 'spawn OKS_fnc_CreateZone' },
    @{ From = 'execVM "Scripts\OKS_Ambience\OKS_ArtyFire.sqf"'; To = 'spawn OKS_fnc_ArtyFire;' },
    @{ From = 'execVM ""Scripts\OKS_Ambience\OKS_ArtyFire.sqf"";'; To = 'spawn OKS_fnc_ArtyFire;' },
    # ... (all your other replacements as before) ...
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
    @{ From = 'OKS_Destroy_Task'; To = 'OKS_fnc_DestroyTask' },
    @{ From = 'OKS_Lambs_Spawner'; To = 'OKS_fnc_Lambs_Spawner' },
    @{ From = 'OKS_ArtySupression'; To = 'OKS_fnc_ArtySuppression' },
    @{ From = 'OKS_CreateZone'; To = 'OKS_fnc_CreateZone' },
    @{ From = 'OKS_Patrol_Spawn'; To = 'OKS_fnc_Patrol_Spawn' },
    @{ From = 'OKS_ClearImmediateArea'; To = 'OKS_fnc_ClearImmediateArea' },
    @{ From = 'OKS_Rush_SpawnGroup'; To = 'OKS_fnc_Rush_SpawnGroup' },
    @{ From = 'OKS_AddVehicleCrew'; To = 'OKS_fnc_AddVehicleCrew' },
    @{ From = 'OKS_Defuse_Explosive'; To = 'OKS_fnc_DefuseExplosive' },
    @{ From = 'OKS_Convoy_Spawn'; To = 'OKS_fnc_Convoy_Spawn' },
    @{ From = 'NEKY_Airbase'; To = 'OKS_fnc_Airbase' }
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
    return $content
}

# === Backup files ===
if ($createBackup) {
    Copy-Item -Path $missionSqmPath -Destination "$missionSqmPath.bak" -Force
    Log-Message "Backup created: mission.sqm.bak"
    if (Test-Path $descExtPath) {
        Copy-Item -Path $descExtPath -Destination "$descExtPath.bak" -Force
        Log-Message "Backup created: Description.ext.bak"
    }
    foreach ($file in $extraFileContents.Keys) {
        $filePath = Join-Path $BaseDir $file
        if (Test-Path $filePath) {
            Copy-Item -Path $filePath -Destination "$filePath.bak" -Force
            Log-Message "Backup created: $file.bak"
        }
    }
}

# === Apply replacements and image path fixes to all files ===
$missionContent = Replace-AllStringsCaseInsensitive $missionContent $replacements
$missionContent = Replace-ImagePaths $missionContent

foreach ($file in $extraFileContents.Keys) {
    $content = $extraFileContents[$file]
    $content = Replace-AllStringsCaseInsensitive $content $replacements
    $content = Replace-ImagePaths $content
    $filePath = Join-Path $BaseDir $file
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
