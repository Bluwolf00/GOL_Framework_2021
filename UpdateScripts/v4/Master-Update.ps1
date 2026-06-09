# Master-Update.ps1  (Framework 4)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
Set-Location $MissionDir

$LogFile = Join-Path $ScriptDir "undo_log.txt"
if (Test-Path $LogFile) { Remove-Item $LogFile -Force }
"=== Script started at $(Get-Date) ===" | Out-File -FilePath $LogFile

# === PROMPT USER BEFORE DELETION ===
Write-Host ""
Write-Host "This script will DELETE and replace the following (you will paste fresh copies from the FW4 template):"
Write-Host " - Gear\          (folder at mission root)"
Write-Host " - Core\          (FW3 — if present)"
Write-Host " - Modules\       (FW3 — if present)"
Write-Host " - Scripts\       (if present)"
Write-Host " - Description.ext"
Write-Host " - version.hpp"
Write-Host " - Init.sqf"
Write-Host " - missionSettings.sqf, script_Component.hpp, onPlayerRespawn.sqf, InitPlayerLocal.sqf"
Write-Host " - All loadimage.jpg files (recursively)"
Write-Host ""
Write-Host "The following are NOT touched:"
Write-Host " + CustomGear\     — your mission-specific loadouts (protected)"
Write-Host " + spawnList.sqf   — your spawn config"
Write-Host " + mission.sqm     — updated in-place by this script (not deleted)"
Write-Host ""
Write-Host "Have you made a backup of your mission folder? (Y/N): "
$response = Read-Host
if ($response -notmatch "^[Yy]$") {
    Write-Host "Aborting. Please make a backup before running this script."
    exit 1
}

# 1. Clean folders
& "$ScriptDir\Clean-Folders.ps1" -FoldersToDelete @("Core", "Modules", "Gear", "Scripts") -LogFile $LogFile

# 2. Clean files
& "$ScriptDir\Clean-Files.ps1" -FilesToDelete @("Description.ext","missionSettings.sqf","init.sqf","initPlayerLocal.sqf","script_Component.hpp","PlatoonRoster.jpg","onPlayerRespawn.sqf","version.hpp") -LogFile $LogFile

# 3. Show manual copy instructions
& "$ScriptDir\Show-ManualCopyInstructions.ps1"

# 4. Process mission files
& "$ScriptDir\Process-MissionFiles.ps1" -LogFile $LogFile
