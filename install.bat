:: Automatic installation for my personal apps on Windows systems
:: Created by Dan Koller 2021

echo "Installing essential software..."
:: Install basic programs
winget install -e --id Google.Chrome
winget install -e --id Google.Drive
winget install -e --id Discord.Discord
echo "...done!"

echo "Installing utilities..."
:: Install utility programs
winget install -e --id smartmontools.smartmontools
echo "...done!"

echo "Installing development tools..."
:: Install development programs
winget install -e --id JetBrains.IntelliJIDEA.Community
winget install -e --id Microsoft.VisualStudio.2022.Community
winget install -e --id Microsoft.SQLServerManagementStudio
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.OpenJDK.17
winget install -e --id OpenJS.NodeJS.LTS
winget install -e --id Postman.Postman
winget install -e --id Git.Git
echo "...done!"

echo "Installing WSL2..."
:: Install WSL2
wsl --install
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
