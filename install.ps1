# Automatic installation for my personal apps on Windows systems
# Created by Dan Koller 2024

Write-Host "Installing essential software..."
# Install basic programs
winget install -e --id Google.Chrome
winget install -e --id Google.Drive
winget install -e --id Brave.Brave
winget install -e --id Discord.Discord
Write-Host "...done!"

Write-Host "Installing utilities..."
# Install utility programs
winget install -e --id 7zip.7zip
winget install -e --id Microsoft.PowerToys
winget install -e --id smartmontools.smartmontools
Write-Host "...done!"

Write-Host "Installing development tools..."
# Install development programs
winget install -e --id Git.Git
winget install -e --id Python.Python.3
winget install -e --id OpenJS.NodeJS.LTS
winget install -e --id Microsoft.OpenJDK.17
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.VisualStudio.2022.Community
Write-Host "...done!"

Write-Host "Installing WSL2..."
# Install WSL2
wsl --install
Write-Host "...done!"

Write-Host "Configuring additional settings..."
# Copy settings
Copy-Item -Path .gitconfig -Destination $env:USERPROFILE -Force
Write-Host "...done!"

# Reminders
Write-Host "SQL Server Express can be downloaded from https://www.microsoft.com/en-us/sql-server/sql-server-downloads"
Write-Host "Please configure your git user and email:"
Write-Host "git config --global user.name '<your name>'"
Write-Host "git config --global user.email '<your email>'"

# Finish
Write-Host "Installation finished. Please restart your system now."
