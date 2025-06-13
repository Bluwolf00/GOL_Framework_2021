# Master-Update.ps1
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
Set-Location $MissionDir

$LogFile = Join-Path $MissionDir "undo_log.txt"
if (Test-Path $LogFile) { Remove-Item $LogFile -Force }
"=== Script started at $(Get-Date) ===" | Out-File -FilePath $LogFile

# === PROMPT USER BEFORE DELETION ===
Write-Host ""
Write-Host "WARNING: This script will DELETE the following folders and files from your mission folder:"
Write-Host " - Core"
Write-Host " - Modules"
Write-Host " - Scripts"
Write-Host " - images"
Write-Host " - missionSettings.sqf"
Write-Host " - script_component.hpp"
Write-Host " - onPlayerRespawn.sqf"
Write-Host " - InitPlayerLocal.sqf"
Write-Host " - Init.sqf"
Write-Host " - All loadimage.jpg files (recursively)"
Write-Host ""
Write-Host "Have you made a backup of your mission folder? (Y/N): "
$response = Read-Host
if ($response -notmatch "^[Yy]$") {
    Write-Host "Aborting. Please make a backup before running this script."
    exit 1
}

# 1. Clean folders
& "$ScriptDir\Clean-Folders.ps1" -FoldersToDelete @("Core", "Modules", "Scripts", "images") -LogFile $LogFile

# 2. Clean files
& "$ScriptDir\Clean-Files.ps1" -FilesToDelete @("missionSettings.sqf","init.sqf","initPlayerLocal.sqf","script_Component.hpp","PlatoonRoster.jpg") -LogFile $LogFile

# 3. Show manual copy instructions
& "$ScriptDir\Show-ManualCopyInstructions.ps1"

# 4. Process mission files
& "$ScriptDir\Process-MissionFiles.ps1" -LogFile $LogFile
