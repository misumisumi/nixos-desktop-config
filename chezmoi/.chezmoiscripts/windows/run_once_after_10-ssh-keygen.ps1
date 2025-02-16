$sshHome="$env:USERPROFILE\.ssh"

if((Test-Path $sshHome) -ne "True"){
    New-Item $sshHome -ItemType Directory
    # chmod 700
    icacls $sshHome /reset
    icacls $sshHome /GRANT:F "$($env:USERNAME):(F)"
}

if((Test-Path $sshHome/id_ed25519.pub) -ne "True"){
    Write-Host "Generate ssh key..."
    ssh-keygen -t ed25519 -N '""' -C "$(whoami)@$(hostname)-$(date -I)" -f "$sshHome\id_ed25519"
    # chmod 600
    # Disable inheritance from folders
    icacls $sshHome\id_ed25519 /inheritance:d
    # Remove default groups (Authenticated Users, System, Administrators, Users)
    icacls $sshHome\id_ed25519 /remove *S-1-5-11 *S-1-5-18 *S-1-5-32-544 *S-1-5-32-545
}

$SOPS_AGE_KEY_FILE="$env:USERPROFILE\.config\sops\age\keys.txt"
if((Test-Path $SOPS_AGE_KEY_FILE) -ne "True"){
    if (Get-Command * | Where-Object { $_.Name -match "go" }) {
        Write-Host "Generate age key..."
        New-Item $(Split-Path -Parent $SOPS_AGE_KEY_FILE) -ItemType Directory -Force
        go run "github.com/Mic92/ssh-to-age/cmd/ssh-to-age@latest" -private-key -i "$env:USERPROFILE\.ssh\id_ed25519" -o $SOPS_AGE_KEY_FILE
    }
}

Write-Host "Finish!"
