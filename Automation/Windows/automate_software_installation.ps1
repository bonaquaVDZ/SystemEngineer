<#
.SYNOPSIS
    Automates the installation of software packages on Windows using Chocolatey.
    
.DESCRIPTION
    This PowerShell script checks if Chocolatey is installed on the system.
    If Chocolatey is not present, it will install it.
    Then, it installs a list of software packages defined within the script.
    The script logs all actions and errors to a specified log file.
    
.NOTES
    - This script must be run with administrative privileges.
    - Adjust the $packages array to include the software you wish to install.
    - Tested on Windows 10.
#>

# Ensure the script is running with Administrator rights.
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script. Please run as Administrator."
    exit 1
}

# Define the log file path (adjust as needed)
$logFile = "C:\Users\$env:USERNAME\Tech\SystemEngineer\Automation\Windows\software_installation.log"

# Define the list of software packages to install using Chocolatey
$packages = @(
    "googlechrome",    # Google Chrome web browser
    "7zip",            # 7-Zip file archiver
    "notepadplusplus", # Notepad++ text editor
    "vlc",             # VLC media player
    "git"              # Git version control system
)

# Function to log messages to the console and to a log file.
function Write-Log {
    param (
        [string]$message,
        [string]$level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp [$level] $message"
    Write-Output $logMessage
    Add-Content -Path $logFile -Value $logMessage
}

Write-Log "Software installation script started."

# Check if Chocolatey is installed. If not, install Chocolatey.
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Log "Chocolatey is not installed. Installing Chocolatey..."
    # Set execution policy and download/install Chocolatey (requires admin rights)
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    try {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } catch {
        Write-Log "Failed to download and install Chocolatey. $_" "ERROR"
        exit 1
    }
    # Verify installation
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Log "Chocolatey installation failed." "ERROR"
        exit 1
    } else {
        Write-Log "Chocolatey installed successfully."
    }
} else {
    Write-Log "Chocolatey is already installed."
}

# Loop through the list of packages and install each one.
foreach ($package in $packages) {
    Write-Log "Installing package: $package"
    try {
        choco install $package -y | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Package '$package' installed successfully."
        } else {
            Write-Log "Failed to install package '$package'." "ERROR"
        }
    } catch {
        Write-Log "Error installing package '$package': $_" "ERROR"
    }
}

Write-Log "Software installation script completed."
