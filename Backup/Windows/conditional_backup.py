#!/usr/bin/env python3
"""
Windows Backup Script
---------------------
A Python script to automate the backup of specified directories on a Windows system. It compresses selected directories into timestamped `.zip` archives, logs activities, and can send email notifications via Gmail SMTP.

Key Features:
    - Automates backups of multiple directories.
    - Creates timestamped compressed `.zip` archives.
    - Logs operations and errors to a log file.
    - Sends optional email notifications on success or failure.

Requirements:
    - Python 3 installed on Windows.
    - Read/write access to source directories, backup location, and log file.
    - Gmail account with Two-Factor Authentication and an App Password for SMTP.

Quick Setup:
    1. Configure source directories, backup location, and log file paths in the script.
    2. Set up Gmail SMTP for email notifications:
        - Enable 2FA on your Gmail account.
        - Generate an App Password for the script.
        - Set the `SMTP_PASSWORD` as an environment variable:
          `set SMTP_PASSWORD=your_app_password`
    3. Run the script manually or automate using Task Scheduler.

Security Notes:
    - Do not hardcode sensitive credentials in the script. Use environment variables for secure storage.
    - Ensure proper permissions for all specified paths.
"""

import os
import datetime
import logging
import smtplib
from email.mime.text import MIMEText
import zipfile

# Configuration
SOURCE_DIRECTORIES = [
    r'C:\Users\YourUsername\Documents\important_data',
    r'C:\Users\YourUsername\Pictures',
    # Add more directories as needed
]

BACKUP_DIRECTORY = r'D:\Backups'
LOG_FILE = r'C:\Users\YourUsername\logs\backup_script.log'

EMAIL_NOTIFICATIONS = True
EMAIL_RECIPIENT = 'recipient.email@example.com'

# SMTP Configuration
SMTP_SERVER = 'smtp.gmail.com'  # Set to 'smtp.gmail.com' for Gmail
SMTP_PORT = 587  # Gmail SMTP port for TLS
SMTP_USERNAME = 'your.email@gmail.com'

# Retrieve SMTP password from an environment variable
SMTP_PASSWORD = os.environ.get('SMTP_PASSWORD')

# Set up logging
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)


def send_email(subject, message):
    if not EMAIL_NOTIFICATIONS:
        return

    msg = MIMEText(message)
    msg['Subject'] = subject
    msg['From'] = SMTP_USERNAME
    msg['To'] = EMAIL_RECIPIENT

    try:
        with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
            server.ehlo()
            server.starttls()  # Secure the connection with TLS
            server.ehlo()
            server.login(SMTP_USERNAME, SMTP_PASSWORD)
            server.send_message(msg)
        logging.info("Email notification sent.")
    except Exception as e:
        logging.error(f"Failed to send email: {e}")


def zip_directory(source_dir, zipf):
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            filepath = os.path.join(root, file)
            # Store files relative to the source directory
            arcname = os.path.relpath(filepath, os.path.dirname(source_dir))
            zipf.write(filepath, arcname)
            logging.info(f"Added {filepath} to backup as {arcname}")


def create_backup():
    date_str = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_filename = f'backup_{date_str}.zip'
    backup_path = os.path.join(BACKUP_DIRECTORY, backup_filename)

    try:
        with zipfile.ZipFile(backup_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for source_dir in SOURCE_DIRECTORIES:
                zip_directory(source_dir, zipf)
        logging.info(f"Backup created successfully at {backup_path}")
        send_email(
            subject='Backup Successful',
            message=f'Backup created successfully at {backup_path}'
        )
    except Exception as e:
        logging.error(f"Backup failed: {e}")
        send_email(
            subject='Backup Failed',
            message=f'Backup failed with error: {e}'
        )


if __name__ == '__main__':
    logging.info("Backup script started.")
    create_backup()
    logging.info("Backup script finished.")
