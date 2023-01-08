:: Automatic installation for my personal apps on Windows systems
:: Created by Dan Koller 2021

echo "Installing essential software..."
:: Install basic programs
winget install -e --id Google.Chrome
winget install -e --id Google.Drive
echo "...done!"

echo "Installing utilities..."
:: Install utility programs
winget install -e --id smartmontools.smartmontools
echo "...done!"

echo "Installing development tools..."
:: Install development programs
winget install -e --id JetBrains.IntelliJIDEA.Community
winget install -e --id JetBrains.PyCharm.Community
winget install -e --id Microsoft.VisualStudio.2022.Community
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id OpenJS.NodeJS.LTS
winget install -e --id Postman.Postman
winget install -e --id Git.Git
winget install -e --id GitHub.cli
echo "...done!"

echo "Configuring additional settings..."
:: Copy settings
xcopy .\settings.json %localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
xcopy .\gitconfig %userprofile%\.gitconfig

:: Other tools
echo "MSSQL Server can be downloaded from https://www.microsoft.com/en-us/sql-server/sql-server-downloads"
echo "SQL Server Management Studio can be downloaded from https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver18"

:: Reminders
echo "Please configure your git user and email:"
echo "git config --global user.name '<your name>'"
echo "git config --global user.email '<your email>'"

:: Finish
echo "Installation finished. Please restart your system now."
