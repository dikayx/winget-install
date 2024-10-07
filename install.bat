:: Automatic installation for my personal apps on Windows systems
:: Created by Dan Koller 2021
@echo off

echo "Installing essential software..."
:: Install basic programs
winget install -e --id Google.Chrome
winget install -e --id Google.Drive
winget install -e --id Discord.Discord
echo "...done!"

echo "Installing utilities..."
:: Install utility programs
winget install -e --id 7zip.7zip
winget install -e --id Microsoft.PowerToys
winget install -e --id smartmontools.smartmontools
echo "...done!"

echo "Installing development tools..."
:: Install development programs
winget install -e --id Git.Git
winget install -e --id Python.Python.3
winget install -e --id Microsoft.OpenJDK.17
winget install -e --id Microsoft.VisualStudioCode
echo "...done!"

echo "Configuring additional settings..."
:: Copy settings
xcopy .gitconfig %userprofile%\
echo "...done!"

:: Reminders
echo "SQL Server Express can be downloaded from https://www.microsoft.com/en-us/sql-server/sql-server-downloads"
echo "Please configure your git user and email:"
echo "git config --global user.name '<your name>'"
echo "git config --global user.email '<your email>'"

:: Finish
echo "Installation finished. Please restart your system now."
