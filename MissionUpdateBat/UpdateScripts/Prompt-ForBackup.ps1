param([string]$Prompt = "Create .bak backup files before replacing? (Y/N): ")

do {
    Write-Host $Prompt -NoNewline
    $response = Read-Host
    if ($response -match "^[YyNn]$") {
        $createBackup = $response.ToUpper() -eq "Y"
        return $createBackup
    }
} while ($true)
