Backup for Linux

This is a Python script designed to automate the backup of specified directories on a Linux system. It compresses the selected directories into a timestamped .tar.gz archive, preserving file permissions and metadata. The script includes logging functionality to track backup activities and can send email notifications upon success or failure using Gmail’s SMTP server.

Features

	•	Automated Backups: Specify one or more directories to back up regularly.
	•	Compression: Creates compressed .tar.gz archives to save storage space.
	•	Timestamped Archives: Generates backups with timestamps to prevent overwriting.
	•	Preserves Metadata: Retains file permissions and metadata during compression.
	•	Logging: Records backup operations and errors to a log file for monitoring.
	•	Email Notifications: Sends email alerts upon backup success or failure via Gmail SMTP.
	•	Error Handling: Includes exception handling to manage errors gracefully.
	•	Customizable: Easily configure source directories, backup location, and email settings.

How It Works

	1.	Configuration: Set the source directories to back up, the backup destination, log file path, and email settings in the script.
	2.	Backup Process:
	•	The script generates a timestamped filename for the backup archive.
	•	It uses the tar command to compress the specified directories into a .tar.gz file.
	•	File permissions and metadata are preserved using the --preserve option.
	3.	Logging: All activities, including successes and errors, are logged to the specified log file.
	4.	Email Notifications:
	•	If enabled, the script sends an email notification upon completion.
	•	Utilizes Gmail’s SMTP server with TLS encryption for secure email transmission.
	•	Requires a Gmail account and an App Password for authentication.

Requirements

	•	Python 3: Ensure Python 3 is installed on your Linux system.
	•	Permissions:
	•	Read access to the source directories.
	•	Write access to the backup directory and log file location.
	•	Gmail Account:
	•	A Gmail account with Two-Factor Authentication (2FA) enabled.
	•	An App Password generated for the script to use SMTP.

Setup and Configuration

	1.	Clone or Copy the Script: Save the script as backup_script.py.
	2.	Modify Configuration Settings: Edit the script to update the following variables:

# Configuration
SOURCE_DIRECTORIES = [
    '/path/to/your/important_data',
    '/another/path/to/backup',
]

BACKUP_DIRECTORY = '/path/to/backup/destination'
LOG_FILE = '/path/to/log/backup_script.log'

EMAIL_NOTIFICATIONS = True
EMAIL_RECIPIENT = 'your.email@example.com'

# SMTP Configuration for Gmail
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USERNAME = 'your.email@gmail.com'
SMTP_PASSWORD = os.environ.get('SMTP_PASSWORD')  # Use an environment variable for security


	3.	Set Up Gmail SMTP:
	•	Enable 2FA: Follow Google’s instructions to enable Two-Factor Authentication on your account.
	•	Generate an App Password: Create an App Password specifically for this script.
	•	Set SMTP Password:
	•	Option 1: Export the App Password as an environment variable:

export SMTP_PASSWORD='your_app_password'


	•	Option 2: Store the password securely using a configuration file or secret manager.

	4.	Ensure Proper Permissions:
	•	Make the script executable:

chmod +x backup_script.py


	•	Verify that the user running the script has the necessary read and write permissions.

Usage

	•	Run Manually: Execute the script from the terminal:

./backup_script.py


	•	Automate with Cron:
	•	Open the crontab editor:

crontab -e


	•	Add a cron job to schedule the backup (e.g., daily at 2 AM):

0 2 * * * . /path/to/your/env_variables; /usr/bin/env python3 /path/to/backup_script.py

	•	Replace /path/to/your/env_variables with the path to a file containing the SMTP_PASSWORD export if needed.

Logging

	•	The script logs its operations to the file specified by LOG_FILE.
	•	Logs include timestamps, actions performed, and any errors encountered.
	•	Review the log file regularly to monitor backup activities.

Email Notifications

	•	If EMAIL_NOTIFICATIONS is set to True, the script will send an email to EMAIL_RECIPIENT upon completion.
	•	Emails indicate whether the backup was successful or if an error occurred.
	•	Ensure that the Gmail SMTP configuration is correctly set up and that the SMTP_PASSWORD is securely provided.

Security Considerations

	•	Protect Credentials: Do not hardcode sensitive information like passwords in the script. Use environment variables or secure storage methods.
	•	File Permissions: Restrict access to the script and log files to authorized users only.
	•	Data Sensitivity: If backing up sensitive data, consider encrypting the backup archives.
