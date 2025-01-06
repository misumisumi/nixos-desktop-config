Write-Host "Update all installed packages..."

if (Get-Command * | Where-Object { $_.Name -match "winget" }) {
Write-Host "Updating winget packages..."
sudo winget install `
    --accept-package-agreements `
    --accept-source-agreements `
    --disable-interactivity `
    --include-unknown `
    --all
}

if (Get-Command * | Where-Object { $_.Name -match "scoop" }) {
Write-Host "Updating scoop packages..."
scoop update *
}
