#####################################################################################################
# This script contains the list of packages to be installed using winget.                           #
# It is meant to be called by the Install.ps1 script.                                               #
#####################################################################################################

Write-Host "Starting installation of packages..."

$packages = @(
    # General
    "7zip.7zip",
    "Discord.Discord",
    "CPUID.HWMonitor",
    "Brave.Brave",
    "Brave.BraveUpdater",
    "Elgato.4KCaptureUtility",
    "Microsoft.PowerToys",
    "smartmontools.smartmontools",
    "Spotify.Spotify",
    # Development
    "Git.Git",
    "Microsoft.VisualStudioCode",
    "Python.Python.3.13",
    # Gaming
    "EpicGames.EpicGamesLauncher",
    "Steam.Steam"
)

#####################################################################################################
# Check for winget installation                                                                     #
#####################################################################################################

$packageManager = "winget"

if (Get-Command $packageManager -ErrorAction SilentlyContinue) {
    Write-Host "Using $packageManager to install packages..."
} else {
    Write-Host "$packageManager is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

#####################################################################################################
# Install packages                                                                                  #
#####################################################################################################

$allSuccess = $true
foreach ($package in $packages) {
    Write-Host "Installing $package..."
    try {
        # Start winget as a process and wait for it to finish
        $process = Start-Process -FilePath "winget.exe" `
                                 -ArgumentList "install --id $package --accept-source-agreements --accept-package-agreements -h" `
                                 -Wait -NoNewWindow -PassThru

        # If the exit code is "-1978335189", it means that package is alerady installed, so we can ignore it
        if ($process.ExitCode -eq -1978335189) {
            Write-Host "$package is already installed. Skipping..." -ForegroundColor Yellow
            continue
        }

        if ($process.ExitCode -ne 0) {
            Write-Host "Failed to install $package. Exit code: $($process.ExitCode)" -ForegroundColor Red
            $allSuccess = $false
        }
    } catch {
        $allSuccess = $false
        Write-Host "Failed to install $package. Error: $_" -ForegroundColor Red
    }
}

#####################################################################################################
# Check overall success and return appropriate exit code                                            #
#####################################################################################################

if ($allSuccess) {
    exit 0
} else {
    exit 1
}
