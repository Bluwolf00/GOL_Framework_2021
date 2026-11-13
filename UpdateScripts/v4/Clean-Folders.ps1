param(
    [string[]]$FoldersToDelete,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
if (-not (Test-Path -LiteralPath (Join-Path $MissionDir "mission.sqm")) -and (Test-Path -LiteralPath (Join-Path (Split-Path -Parent $MissionDir) "mission.sqm"))) {
    $MissionDir = Split-Path -Parent $MissionDir
}
Set-Location $MissionDir

function Log-Message($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

foreach ($folder in $FoldersToDelete) {
    $fullPath = Join-Path $MissionDir $folder
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
