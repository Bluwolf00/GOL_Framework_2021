param(
    [string[]]$FilesToDelete,
    [string]$LogFile
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$MissionDir = Split-Path -Parent $ScriptDir
Set-Location $MissionDir

function Log-Message($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

foreach ($file in $FilesToDelete) {
    $fullPath = Join-Path $MissionDir $file
    if (Test-Path $fullPath) {
        Remove-Item $fullPath -Force
        Log-Message "Deleted $file"
    }
}

# Delete all loadimage.jpg (case-insensitive)
Get-ChildItem -Path $MissionDir -Recurse -File | Where-Object { $_.Name -imatch '^loadimage\.jpg$' } | ForEach-Object {
    Remove-Item $_.FullName -Force
    Log-Message "Deleted $($_.FullName)"
}
