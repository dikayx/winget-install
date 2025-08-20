# TODOS:

# - Check if the user is running as administrator   - OK
# - Get the args                                    - OK
# - Install the packages                            - OK
# - Enable the classic context menu (if wanted)     - OK
# - Apply additional tweaks (dark mode, etc.)       - OK
# - Restart the system (if needed)                  - OK

# Get the arguments
param (
    [switch]$InstallPackages,
    [switch]$EnableClassicContextMenu,
    [switch]$ApplyTweaks,
    [switch]$RestartSystem,
    [switch]$Help,
    [string]$Hostname,
    [string]$GitUsername,
    [string]$GitEmail
)
# Print all the arguments for debugging purposes
Write-Host "EnableClassicContextMenu: $EnableClassicContextMenu"
Write-Host "InstallPackages: $InstallPackages"
Write-Host "ApplyTweaks: $ApplyTweaks"
Write-Host "RestartSystem: $RestartSystem"
Write-Host "Help: $Help"
Write-Host "Hostname: $Hostname"
Write-Host "GitUsername: $GitUsername"
Write-Host "GitEmail: $GitEmail"

# Print help message if the user requested it
if ($Help) {
    Write-Host "Usage: Install.ps1 [--InstallPackages] [--EnableClassicContextMenu] [--ApplyTweaks] [--RestartSystem] [--Help] [--Hostname <hostname>] [--GitUsername <username>] [--GitEmail <email>]"
    Write-Host "Options:"
    Write-Host "  --InstallPackages: Install the packages using the Packages.ps1 script."
    Write-Host "  --EnableClassicContextMenu: Enable the classic context menu."
    Write-Host "  --ApplyTweaks: Apply additional tweaks (dark mode, etc.)."
    Write-Host "  --RestartSystem: Restart the system after installation."
    Write-Host "  --Help: Show this help message."
    Write-Host "  --Hostname: Set the hostname of the system."
    Write-Host "  --GitUsername: Set the Git username."
    Write-Host "  --GitEmail: Set the Git email."
    Write-Host "Examples:"
    Write-Host "  Install.ps1 --InstallPackages --EnableClassicContextMenu --ApplyTweaks"
    Write-Host "  Install.ps1 --InstallPackages --GitUsername 'John Doe' --GitEmail '<YOUR_EMAIL>'"
    Write-Host "  Install.ps1 --Help"
    exit 0
}

# Check if the user is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an administrator." -ForegroundColor Red
    exit 1
}

# Install the packages using the Packages.ps1 script
if ($InstallPackages) {
    Write-Host "Installing packages..."
    .\Scripts\Packages.ps1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while installing packages. Please check the output above." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "Packages installed successfully." -ForegroundColor Green
    }
}

# Enable the classic context menu if the user wants it
if ($EnableClassicContextMenu) {
    Write-Host "Enabling classic context menu..."
    .\Scripts\Restore-Classic-ContextMenu.ps1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while enabling the classic context menu. Please check the output above." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "Classic context menu enabled successfully." -ForegroundColor Green
    }
}

# Apply tweaks (Dark mode, explorer options, etc.) if the user wants them
if ($ApplyTweaks) {
    Write-Host "Applying tweaks..."
    .\Scripts\Tweaks.ps1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while applying tweaks. Please check the output above." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "Tweaks applied successfully." -ForegroundColor Green
    }
}

# Apply settings (Hostname, Git config, etc.) if the user wants them
if ($Hostname -or $GitUsername -or $GitEmail) {
    Write-Host "Applying settings..."
    .\Scripts\Settings.ps1 -Hostname $Hostname -GitUsername $GitUsername -GitEmail $GitEmail 
    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while applying settings. Please check the output above." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "Settings applied successfully." -ForegroundColor Green
    }
}

# Restart the system if the user wants it
if ($RestartSystem) {
    Write-Host "Installation completed." -ForegroundColor Green
    Write-Host "Restarting the system in 60 seconds..." -ForegroundColor Yellow
    Write-Host "You can cancel the restart by pressing Ctrl+C." -ForegroundColor Yellow
    Start-Sleep -Seconds 60
    Restart-Computer -Force
} else {
    Write-Host "Installation completed." -ForegroundColor Green
    Write-Host "You may need to restart your system for some changes to take effect." -ForegroundColor Yellow
    exit 0
}
