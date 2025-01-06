#!/usr/bin/env python3
"""
Add Users to Windows Server
---------------------------
This script reads a file containing user information and automatically adds
those users to a Windows Server using the `net user` command.

File Format:
Each line in the file should contain the following (comma-separated):
    username,password

If no password is provided, a default password will be used.

Requirements:
- Python 3.x installed.
- Must run the script with administrative privileges.
- Windows Server environment.
"""

import os
import subprocess
import sys
from datetime import datetime

# Default password for users if not provided
DEFAULT_PASSWORD = "P@ssw0rd123"

# Log file for tracking script actions
LOG_FILE = "user_addition_log.txt"


def log_message(message):
    """
    Logs a message to the log file with a timestamp.

    Args:
        message (str): The message to log.

    Returns:
        None
    """
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG_FILE, "a") as log_file:
        log_file.write(f"[{timestamp}] {message}\n")


def check_admin_privileges():
    """
    Checks if the script is running with administrative privileges.

    Returns:
        bool: True if running as admin, False otherwise.
    """
    try:
        # Attempting to write to a protected directory as a test
        test_path = os.path.join(os.environ.get("SystemRoot", "C:\\Windows"), "temp")
        test_file = os.path.join(test_path, "admin_check.tmp")
        with open(test_file, "w") as file:
            file.write("test")
        os.remove(test_file)
        return True
    except (PermissionError, OSError):
        return False


def add_user(username, password=DEFAULT_PASSWORD):
    """
    Adds a user to the Windows system.

    Args:
        username (str): The username of the new user.
        password (str): The password for the new user.

    Returns:
        None
    """
    try:
        # Run the 'net user' command to add the user
        result = subprocess.run(
            ["net", "user", username, password, "/add"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            shell=True,
        )

        if result.returncode == 0:
            message = f"Successfully added user: {username}"
            print(message)
            log_message(message)
        else:
            message = f"Failed to add user: {username}\n{result.stderr}"
            print(message)
            log_message(message)
    except Exception as e:
        error_message = f"An error occurred while adding user {username}: {e}"
        print(error_message)
        log_message(error_message)


def add_users_from_file(file_path):
    """
    Reads a file containing user information and adds them to the system.

    Args:
        file_path (str): Path to the file containing user information.

    Returns:
        None
    """
    if not os.path.exists(file_path):
        error_message = f"Error: The file '{file_path}' does not exist."
        print(error_message)
        log_message(error_message)
        return

    with open(file_path, "r") as file:
        for line in file:
            # Skip empty lines or lines starting with a comment (#)
            line = line.strip()
            if not line or line.startswith("#"):
                continue

            # Split the line into username and password
            parts = line.split(",")
            username = parts[0].strip()
            password = parts[1].strip() if len(parts) > 1 else DEFAULT_PASSWORD

            # Add the user
            add_user(username, password)


def main():
    import argparse

    if not check_admin_privileges():
        print("Error: This script must be run with administrative privileges.")
        log_message("Error: Insufficient privileges to run the script.")
        sys.exit(1)

    parser = argparse.ArgumentParser(description="Add users to Windows Server from a file.")
    parser.add_argument(
        "file_path", type=str, help="Path to the file containing user information."
    )
    args = parser.parse_args()

    # Log the start of the script
    log_message("Script started.")
    log_message(f"Processing file: {args.file_path}")

    add_users_from_file(args.file_path)

    # Log the end of the script
    log_message("Script finished.")


if __name__ == "__main__":
    main()
