# winget-install

A collection of post-install scripts for Windows using `winget` to install common applications and set up my environment. Feel free to use or modify it for your own needs.

## Requirements

-   Windows 10 or later
-   [winget\*](https://github.com/microsoft/winget-cli/releases) (use the `msixbundle` installer for the latest version)

\*) winget is included with Windows 11, but you can also install it manually if needed.

## Usage

1. Clone this repository to your local machine or download the ZIP file and extract it.
2. Open a PowerShell terminal with **administrative privileges**.
3. Navigate to the directory where you cloned or extracted the repository.

    ```powershell
    cd C:\path\to\winget-install
    ```

4. Run the following command to execute the PowerShell script:

    ```powershell
    powershell -ExecutionPolicy Bypass -File .\Setup.ps1
    ```

5. Wait\*\* :)

\*\*) You may need to accept some UAC pop-ups on certain installation processes.

## Applications

By default, this post-installer will set up a system with my preferred applications. You can modify the `Install.*` and `Packages.*` script to add or remove applications as needed. Here is a selection of the applications included:

### General

-   [7-Zip](https://www.7-zip.org/) - File archiver with a high compression ratio.
-   [Discord](https://discord.com/) - VoIP, instant messaging and digital distribution platform.
-   [HWMonitor](https://www.hwinfo.com/) - Hardware monitoring and diagnostic tool.
-   [Google Chrome](https://www.google.com/chrome/) - Web browser developed by Google.
-   [Google Drive](https://www.google.com/drive/) - File storage and synchronization service.
-   [PowerToys](https://learn.microsoft.com/de-de/windows/powertoys/) - Set of utilities for power users to tune and streamline their Windows experience.
-   [Smartmon](https://smartmon.org/) - Smart monitoring tool for hard drives and SSDs.
-   [Spotify](https://www.spotify.com/) - Digital music service that gives you access to millions of songs.

### Development

-   [Git](https://git-scm.com/) - Free and open source distributed version control system.
-   [Python 3](https://www.python.org/) - High-level programming language for general-purpose programming.
-   [Visual Studio Code](https://code.visualstudio.com/) - Source-code editor developed by Microsoft.

### Gaming

-   [Epic Games Launcher](https://www.epicgames.com/store/en-US/download) - Digital distribution platform for video games.
-   [Steam](https://store.steampowered.com/about/) - Digital distribution platform for video games.

### Customization

-   Dark mode selected
-   Classic context menu enabled
-   Copy gitconfig to `%USERPROFILE%`
-   Additional tweaks applied (show hidden files, etc.)

## Previous Versions

Earlier versions of this script combined Batch and PowerShell to maximize compatibility with older Windows releases.

The installer has now been fully rewritten in PowerShell to leverage its advanced capabilities and deliver a more reliable, consistent experience on modern Windows versions.

If you still need the old implementation, you can find it in the [legacy branch](https://github.com/dikayx/winget-install/tree/legacy) or the [legacy release](https://github.com/dikayx/winget-install/releases/tag/v0.9).
