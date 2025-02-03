#!/bin/bash
# Automate Software Installation Script for Linux
#
# This script checks for root privileges, updates the package list,
# and installs a list of software packages using apt-get.
# All actions and errors are logged to a specified log file.
#
# NOTE:
#   - This script must be run as root (using sudo).
#   - Modify the PACKAGES array to include the software you wish to install.
#   - Tested on Debian/Ubuntu-based systems.

# Define the log file path (adjust as needed)
LOG_FILE="/mnt/c/Users/vadzi/Tech/SystemEngineer/Automation/Linux/software_installation.log"

# Define the list of software packages to install (modify as desired)
PACKAGES=(
    "curl"          # Command-line tool for transferring data with URLs
    "vim"           # Text editor
    "git"           # Version control system
    "vlc"           # Media player
    "htop"          # Interactive process viewer
)

# Function to log messages with a timestamp
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $message" >> "$LOG_FILE"
}

# Function to log error messages with a timestamp
log_error() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $message" >> "$LOG_FILE"
}

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo." | tee -a "$LOG_FILE"
    exit 1
fi

log_message "Software installation script started."

# Update the package list
log_message "Updating package list..."
apt-get update >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log_error "Failed to update package list. Aborting installation."
    exit 1
fi

# Loop through the list of packages and install each one
for package in "${PACKAGES[@]}"; do
    log_message "Installing package: $package"
    apt-get install -y "$package" >> "$LOG_FILE" 2>&1
    if [ $? -eq 0 ]; then
        log_message "Package '$package' installed successfully."
    else
        log_error "Failed to install package '$package'."
    fi
done

log_message "Software installation script completed."


