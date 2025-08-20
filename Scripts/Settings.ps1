param(
    [string]$Hostname,
    [string]$GitUsername,
    [string]$GitEmail
)

# Set the hostname if provided
if ($Hostname) {
    Rename-Computer -NewName $Hostname -Force
    Write-Host "Hostname set to $Hostname. Please restart your computer for the changes to take effect." -ForegroundColor Yellow
}

# Copy the .gitconfig file to the home directory
$repoRoot = Split-Path -Parent $PSScriptRoot
Copy-Item -Path (Join-Path $repoRoot "Config\.gitconfig") -Destination (Join-Path $HOME ".gitconfig") -Force

# Set the Git username and email if provided
if ($GitUsername) {
    git config --global user.name $GitUsername
}

if ($GitEmail) {
    git config --global user.email $GitEmail
}

exit 0