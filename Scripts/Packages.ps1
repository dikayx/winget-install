# Automatic installation for my personal apps on Windows systems
# Created by Dan Koller 2025

Write-Host "Starting installation of packages..."

$packages = @(
    # General
    "7zip.7zip",
    "Discord.Discord",
    "CPUID.HWMonitor",
    "Google.Chrome",
    "Google.GoogleDrive",
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

$packageManager = "winget"
# $command = "$packageManager install --id {0}" -f $packages -join " "

# Check if winget is installed
if (Get-Command $packageManager -ErrorAction SilentlyContinue) {
    Write-Host "Using $packageManager to install packages..."
} else {
    Write-Host "$packageManager is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Install packages
$allSuccess = $true
foreach ($package in $packages) {
    Write-Host "Installing $package..."
    try {
        # Start winget as a process and wait for it to finish
        $process = Start-Process -FilePath "winget.exe" `
                                 -ArgumentList "install --id $package --accept-source-agreements --accept-package-agreements -h" `
                                 -Wait -NoNewWindow -PassThru
        if ($process.ExitCode -eq 0) {
            Write-Host "$package installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install $package. Exit code: $($process.ExitCode)" -ForegroundColor Red
            $allSuccess = $false
        }
    } catch {
        $allSuccess = $false
        Write-Host "Failed to install $package. Error: $_" -ForegroundColor Red
    }
}

# Return 0 if all packages were installed successfully, 1 if any failed
# $allSuccess = $true
# foreach ($package in $packages) {
#     if ($LASTEXITCODE -ne 0) {
#         $allSuccess = $false
#         break
#     }
# }

if ($allSuccess) {
    exit 0
} else {
    exit 1
}
