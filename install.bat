:: Automatic installation for my personal apps on Windows systems
:: Created by Dan Koller 2021

echo "Installing essential software..."
:: Install basic programs
winget install Google.Chrome
winget install Google.DriveFileStream
winget install Microsoft.WindowsTerminal
winget install Notepad++.Notepad++
winget install Discord.Discord
winget install Spotify.Spotify
echo "...done!"

echo "Installing development tools..."
:: Install development programs
:: Runtimes
winget install AdoptOpenJDK.OpenJDK -v 11.0.7
winget install Python.Python
winget install OpenJS.Nodejs
:: IDEs & editors
winget install JetBrains.IntelliJIDEA.Community
winget install JetBrains.PyCharm.Community
winget install Microsoft.VisualStudioCode
:: Other tools
winget install GitHub.GitHubDesktop
winget install Postman.Postman
winget install wsl --install
echo "...done!"

:: Other tools
echo "Install Git manually (https://git-scm.com/downloads)."
echo "Don't forget to install gradle (https://gradle.org/install/)"
echo "Copy terminal settings from https://gist.github.com/dan-koller/e8eefc0d0c987f5a57666d28e6ba8cec"