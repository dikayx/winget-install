# Automatic installation script for Windows

Installation script for my personal apps on a windows system. Feel free to use and modify it depending on your needs.

## Requirements

-   OS: Windows 10 (or above)
-   `winget` must be installed. Download the msixbundle [here](https://github.com/microsoft/winget-cli/releases) or install it from the [Microsoft Store](https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab)

### How to run

> Note: I recommend to run the powershell script. However, you can also run the `install.bat` file if you prefer.

-   Open a terminal with administrator privileges
-   Navigate to `install.ps1` file location

    ```powershell
    cd winget-install
    ```

-   Run the file

    ```powershell
    powershell -ExecutionPolicy Bypass -File .\install.ps1
    ```

-   Wait\* :)

_\*You may need to accept some UAC pop-ups on individual installation processes._
