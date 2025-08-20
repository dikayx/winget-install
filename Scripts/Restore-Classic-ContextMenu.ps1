# This script enables or disables the classic context menu in Windows 11.
# Usage: Restore-Classic-ContextMenu.ps1 [--undo]
#        --undo: Restores the default context menu (undoes the classic context menu).

# TODO: Maybe move to the Tweaks.ps1 script?
param (
    [string]$Action = ""
)

$regKeyPath = "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
$inprocKey = "$regKeyPath\InprocServer32"

function Restart-Explorer {
    Write-Host "Restarting explorer.exe..."
    Stop-Process -Name explorer -Force
    Start-Process explorer.exe
}

if ($Action -eq "--undo") {
    Write-Host "Undoing classic context menu - restoring default..."
    reg.exe delete "$regKeyPath" /f | Out-Null
    Restart-Explorer
    Write-Host "Done. Default context menu restored."
} else {
    Write-Host "Enabling classic context menu..."
    reg.exe add "$inprocKey" /f /ve | Out-Null
    Restart-Explorer
    Write-Host "Done. Classic context menu enabled."
}
