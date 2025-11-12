#####################################################################################################
# This script sets up my Windows environment using winget.                                          #
# It provides an interactive console UI to select options for installation and configuration.       #
#####################################################################################################

#####################################################################################################
# Miscellanous                                                                                      #
#####################################################################################################

$banner = @"
--------------------------------------------------------
         _               _       _         _        _ _ 
 __ __ _(_)_ _  __ _ ___| |_ ___(_)_ _  __| |_ __ _| | |
 \ V  V / | ' \/ _` / -_)  _|___| | ' \(_-<  _/ _` | | |
  \_/\_/|_|_||_\__, \___|\__|   |_|_||_/__/\__\__,_|_|_|
               |___/                                    
--------------------------------------------------------
"@

#####################################################################################################
# Draw UI                                                                                           #
#####################################################################################################

Clear-Host

$options = @(
    @{ Label = "Install Packages"; Selected = $false },
    @{ Label = "Enable the classic Windows 10 context menu in W11"; Selected = $false },
    @{ Label = "Apply tweaks (dark mode, default apps, etc.)"; Selected = $false },
    @{ Label = "Restart the System automatically after Setup"; Selected = $false },
    @{ Label = "Provide a custom hostname"; Selected = $false },
    @{ Label = "Provide git Settings (username and email)"; Selected = $false }
)

$selectedIndex = 0

function Draw-UI {
    Clear-Host
    Write-Host $banner -ForegroundColor Cyan
    Write-Host "Welcome to the winget-install setup wizard!" -ForegroundColor White
    Write-Host ""
    Write-Host "Use W/S to move, SPACE to select, ENTER to continue." -ForegroundColor Yellow
    Write-Host ""
    for ($i = 0; $i -lt $options.Count; $i++) {
        $prefix = if ($options[$i].Selected) { "[X]" } else { "[ ]" }
        if ($i -eq $selectedIndex) {
            Write-Host "$prefix $($options[$i].Label)" -BackgroundColor DarkCyan -ForegroundColor Black
        } else {
            Write-Host "$prefix $($options[$i].Label)"
        }
    }
    Write-Host ""
    Write-Host "Exit using CTRL+C at any time." -ForegroundColor Yellow
}

[Console]::CursorVisible = $false

$done = $false

do {
    Draw-UI
    $key = [System.Console]::ReadKey($true)

    switch ($key.Key.ToString()) {
        "Enter" {
            Write-Host "Enter key detected. Exiting input loop..."
            $done = $true
        }
        default {
            if ($key.KeyChar -ne 0) {
                switch ($key.KeyChar.ToString().ToLower()) {
                    "w" { $selectedIndex = [Math]::Max(0, $selectedIndex - 1) }
                    "s" { $selectedIndex = [Math]::Min($options.Count - 1, $selectedIndex + 1) }
                    " " { $options[$selectedIndex].Selected = -not $options[$selectedIndex].Selected }
                }
            }
        }
    }
} while (-not $done)

[Console]::CursorVisible = $true
Clear-Host

$hostname = ""
$gitUser = ""
$gitEmail = ""

if ($options[4].Selected) {
    $hostname = Read-Host "Enter the custom hostname"
}

if ($options[5].Selected) {
    $gitUser = Read-Host "Enter your Git username"
    $gitEmail = Read-Host "Enter your Git email"
}

#####################################################################################################
# Process Selections                                                                                #
#####################################################################################################

$args = @{}

if ($options[0].Selected) { $args.InstallPackages = $true }
if ($options[1].Selected) { $args.EnableClassicContextMenu = $true }
if ($options[2].Selected) { $args.ApplyTweaks = $true }
if ($options[3].Selected) { $args.RestartSystem = $true }

if ($hostname) { $args.Hostname = $hostname }
if ($gitUser)  { $args.GitUsername = $gitUser }
if ($gitEmail) { $args.GitEmail = $gitEmail }

######################################################################################################
# Execute Installation Script                                                                        #
######################################################################################################

$scriptPath = Join-Path $PSScriptRoot "Install.ps1"

& $scriptPath @args

if ($LASTEXITCODE -ne 0) {
    Write-Host "Installation script encountered an error." -ForegroundColor Red
}

######################################################################################################
# Post-Installation Message                                                                          #
######################################################################################################

if ($RestartSystem) {
    Write-Host "Setup completed." -ForegroundColor Green
    Write-Host "Restarting the system in 60 seconds (you can cancel with CTRL+C)..." -ForegroundColor Yellow
    Start-Sleep -Seconds 60
    Restart-Computer -Force
} else {
    Write-Host "Setup completed." -ForegroundColor Green
    Write-Host "You may need to restart your system for some changes to take effect." -ForegroundColor Yellow
    exit 0
}
