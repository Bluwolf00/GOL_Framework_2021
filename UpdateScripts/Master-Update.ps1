# Compatibility launcher. The maintained Framework 4 updater lives in v4\.
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
& (Join-Path $ScriptDir "v4\Master-Update.ps1")
