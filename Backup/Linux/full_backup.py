#!/usr/bin/env python3
"""
Linux Backup Script
-------------------
This Python script automates the backup of specified directories on a Linux system. It compresses the selected directories into a timestamped `.tar.gz` archive, logs all activities, and sends email notifications upon success or failure.

Key Features:
    - Automates backups of specified directories.
    - Creates timestamped compressed archives.
    - Logs operations and errors to a log file.
    - Sends email notifications via Gmail's SMTP server.

Setup:
    1. Configure source directories, backup location, and log file path.
    2. Enable email notifications by setting up Gmail SMTP and using an App Password.
    3. Run manually or schedule with cron for regular backups.

Requirements:
    - Python 3
    - Read access to source directories.
    - Write access to backup and log locations.
    - A Gmail account with 2FA and an App Password for SMTP.

Usage:
    - Run the script manually: `./backup_linux.py`
    - Schedule automated backups using `cron`.

Security Note:
    - Use environment variables for sensitive credentials like SMTP passwords.
"""

import datetime
import logging
import os
import smtplib
import subprocess
from email.mime.text import MIMEText

# Configuration
SOURCE_DIRECTORIES = [
    '/home/yourusername/Documents/important_data',
    '/home/yourusername/Pictures',
    # Add more directories as needed
]

BACKUP_DIRECTORY = '/home/yourusername/Backups'
LOG_FILE = '/var/log/backup_script.log'

EMAIL_NOTIFICATIONS = True
EMAIL_RECIPIENT = 'recipient.email@example.com'

# SMTP Configuration
SMTP_SERVER = 'smtp.gmail.com'  # Set to 'smtp.gmail.com' for Gmail
SMTP_PORT = 587  # Gmail SMTP port for TLS
SMTP_USERNAME = 'your.email@gmail.com'

# For security, retrieve the SMTP password from an environment variable
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


def create_backup():
    date_str = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_filename = f'backup_{date_str}.tar.gz'
    backup_path = os.path.join(BACKUP_DIRECTORY, backup_filename)

    try:
        for source_dir in SOURCE_DIRECTORIES:
            subprocess.check_call([
                'tar',
                '-czpf',
                backup_path,
                '--preserve',
                '-C',
                os.path.dirname(source_dir),
                os.path.basename(source_dir)
            ])
            logging.info(f"Added {source_dir} to backup.")
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
