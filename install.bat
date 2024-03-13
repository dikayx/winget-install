:: Automatic installation for my personal apps on Windows systems
:: Created by Dan Koller 2021
@echo off

echo "Installing essential software..."
:: Install basic programs
winget install -e --id Google.Chrome
winget install -e --id Google.Drive
winget install -e --id Brave.Brave
winget install -e --id Discord.Discord
echo "...done!"

echo "Installing utilities..."
:: Install utility programs
winget install -e --id Microsoft.PowerToys
winget install -e --id smartmontools.smartmontools
echo "...done!"

echo "Installing development tools..."
:: Install development programs
winget install -e --id Python.Python.3
winget install -e --id OpenJS.NodeJS.LTS
winget install -e --id Microsoft.OpenJDK.17
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.VisualStudio.2022.Community
winget install -e --id Git.Git
echo "...done!"

echo "Installing security software..."
:: Install security programs
winget install -e --id Maltego.Maltego
winget install -e --id WiresharkFoundation.Wireshark
winget install -e --id PortSwigger.BurpSuite.Community
echo "...done!"

echo "Installing WSL2..."
:: Install WSL2
wsl --install
echo "...done!"

echo "Installing database software..."
:: Install database programs (may be error prone)
winget install -e --id Microsoft.SQLServer.2022.Developer
winget install -e --id Microsoft.SQLServerManagementStudio
if %ERRORLEVEL% NEQ 0 (
    echo Error: Could not install SQL Server. Please install manually.
    echo SQL Server can be downloaded from https://www.microsoft.com/en-us/sql-server/sql-server-downloads
)
echo "...done!"

echo "Configuring additional settings..."
:: Copy settings
xcopy .gitconfig %userprofile%\

:: Reminders
echo "Please configure your git user and email:"
echo "git config --global user.name '<your name>'"
echo "git config --global user.email '<your email>'"

:: Finish
echo "Installation finished. Please restart your system now."
