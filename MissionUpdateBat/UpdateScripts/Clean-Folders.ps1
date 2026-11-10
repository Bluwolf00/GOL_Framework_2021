param(
    [string[]]$FoldersToDelete,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
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
