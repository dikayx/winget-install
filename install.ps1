#####################################################################################################
# This script will install packages, apply tweaks, and set configurations based on user input.      #
# It can be run using the Setup script or directly with parameters.                                 #
#####################################################################################################

#####################################################################################################
# Parameters                                                                                        #
#####################################################################################################

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

# Write-Host "EnableClassicContextMenu: $EnableClassicContextMenu"
# Write-Host "InstallPackages: $InstallPackages"
# Write-Host "ApplyTweaks: $ApplyTweaks"
# Write-Host "RestartSystem: $RestartSystem"
# Write-Host "Help: $Help"
# Write-Host "Hostname: $Hostname"
# Write-Host "GitUsername: $GitUsername"
# Write-Host "GitEmail: $GitEmail"

#####################################################################################################
# Show help message if the user requested it                                                        #
#####################################################################################################

if ($Help) {
    Write-Host "Usage: Install.ps1 [-InstallPackages] [-EnableClassicContextMenu] [-ApplyTweaks] [-RestartSystem] [-Help] [-Hostname <hostname>] [-GitUsername <username>] [-GitEmail <email>]"
    Write-Host "Options:"
    Write-Host "  -InstallPackages: Install the packages using the Packages.ps1 script."
    Write-Host "  -EnableClassicContextMenu: Enable the classic context menu."
    Write-Host "  -ApplyTweaks: Apply additional tweaks (dark mode, etc.)."
    Write-Host "  -RestartSystem: Restart the system after installation."
    Write-Host "  -Help: Show this help message."
    Write-Host "  -Hostname: Set the hostname of the system."
    Write-Host "  -GitUsername: Set the Git username."
    Write-Host "  -GitEmail: Set the Git email."
    Write-Host "Examples:"
    Write-Host "  Install.ps1 -InstallPackages -EnableClassicContextMenu -ApplyTweaks"
    Write-Host "  Install.ps1 -InstallPackages -GitUsername 'John Doe' -GitEmail '<YOUR_EMAIL>'"
    Write-Host "  Install.ps1 -Help"
    exit 0
}

#####################################################################################################
# Install packages                                                                                  #
#####################################################################################################

if ($InstallPackages) {
    Write-Host "Installing packages..."
    .\Packages.ps1

    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while installing packages. Please check the output above." -ForegroundColor Red
    }
}

#####################################################################################################
# Apply settings & tweaks                                                                           #
#####################################################################################################

# Classic context menu
if ($EnableClassicContextMenu) {
    Write-Host "Enabling classic context menu..."

    $regKeyPath = "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
    $inprocKey = "$regKeyPath\InprocServer32"

    function Restart-Explorer {
        Write-Host "Restarting explorer.exe..."
        Stop-Process -Name explorer -Force
        Start-Process explorer.exe
    }

    if (Test-Path $inprocKey) {
        Write-Host "Classic context menu is already enabled."
    } else {
        reg.exe add "$inprocKey" /f /ve | Out-Null
        Write-Host "Classic context menu enabled."
        Restart-Explorer
    }
}

# System tweaks
if ($ApplyTweaks) {
    Write-Host "Applying tweaks..."
    
    # Enable the system dark mode
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord

    # Explorer tweaks
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "FullPathAddressBar" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo" -Name "RestorePreviousFolder" -Value 1 -Type DWord

    # Restart Explorer to apply changes
    Stop-Process -Name explorer -Force
    Start-Process explorer

    if ($LASTEXITCODE -ne 0) {
        Write-Host "An error occurred while applying tweaks. Please check the output above." -ForegroundColor Red
    }
}

# Set Git configuration
if ($GitUsername -or $GitEmail) {
    try {
        Write-Host "Setting Git configuration..."

        Write-Host "Copying default Git configuration..."
        $source = Join-Path $PSScriptRoot "Config\.gitconfig"
        $destination = Join-Path $HOME ".gitconfig"

        if (Test-Path $source) {
            Copy-Item -Path $source -Destination $destination -Force
        } else {
            Write-Host "Source .gitconfig not found at $source" -ForegroundColor Red
        }

        if ($GitUsername) {
            Write-Host "Setting Git username to '$GitUsername'..."
            git config --global user.name "$GitUsername"
        }
        if ($GitEmail) {
            Write-Host "Setting Git email to '$GitEmail'..."
            git config --global user.email "$GitEmail"
        }
    } catch {
        Write-Host "Failed to set Git configuration. Error: $_" -ForegroundColor Red
    }
}

# Setting the hostname (requires admin rights)
if ($Hostname) {
    try {
        Write-Host "Setting hostname to '$Hostname'..."

        # Check if running as admin
        $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        if (-not $isAdmin) {
            # Relaunch as admin automatically
            Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"Rename-Computer -NewName '$Hostname' -Force`""
            exit
        }

        Write-Host "You must restart your computer for the change to take effect." -ForegroundColor Yellow
    } catch {
        Write-Host "Failed to set hostname. Error: $_" -ForegroundColor Red
    }
}

#####################################################################################################
# Evaluate overall success and exit with appropriate code                                           #
#####################################################################################################

$allSuccess = $true
if ($InstallPackages -and $LASTEXITCODE -ne 0) { $allSuccess = $false }
if ($ApplyTweaks -and $LASTEXITCODE -ne 0) { $allSuccess = $false }
if ($Hostname -and $LASTEXITCODE -ne 0) { $allSuccess = $false }
if ($allSuccess) {
    $exitCode = 0
} else {
    Write-Host "Some operations failed. Please check the output above." -ForegroundColor Red
    $exitCode = 1
}