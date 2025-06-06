param(
    [bool]$CreateBackup,
    [string[]]$FilesToBackup,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
Set-Location $MissionDir

function Log-Message($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

if ($CreateBackup) {
    foreach ($file in $FilesToBackup) {
        $fullPath = Join-Path $MissionDir $file
        if (Test-Path $fullPath) {
            Copy-Item -Path $fullPath -Destination "$fullPath.bak" -Force
            Log-Message "Backup created: $file.bak"
        }
    }
}
