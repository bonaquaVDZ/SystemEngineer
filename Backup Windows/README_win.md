Windows Backup Script

A Python script to automate the backup of specified directories on a Windows system. It compresses selected directories into timestamped .zip archives, logs activities, and can send email notifications via Gmail SMTP.

Features

	•	Automated Backups: Backup multiple directories.
	•	Compression: Creates timestamped .zip archives.
	•	Logging: Records backup activities and errors.
	•	Email Notifications: Optional alerts upon success or failure.

Requirements

	•	Python 3 installed on Windows.
	•	Read/Write Permissions: Access to source directories, backup location, and log file.
	•	Gmail Account (if using email notifications):
	•	Two-Factor Authentication enabled.
	•	App Password generated for the script.

Quick Setup

	1.	Save the Script
Save the Python script as backup_script.py.
	2.	Install Python 3
Download and install from python.org.
	3.	Configure the Script
Edit backup_script.py to set your preferences:
	•	Source Directories:

SOURCE_DIRECTORIES = [
    r'C:\path\to\directory1',
    r'C:\path\to\directory2',
]


	•	Backup Directory:

BACKUP_DIRECTORY = r'D:\Backups'


	•	Log File:

LOG_FILE = r'C:\path\to\backup_script.log'


	•	Email Settings (optional):

EMAIL_NOTIFICATIONS = True  # Set to False to disable
EMAIL_RECIPIENT = 'your.email@example.com'
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USERNAME = 'your.email@gmail.com'
SMTP_PASSWORD = os.environ.get('SMTP_PASSWORD')  # Use environment variable


	4.	Set Up Gmail SMTP (if using email notifications)
	•	Enable Two-Factor Authentication on your Gmail account.
	•	Generate an App Password for the script.
	•	Set the SMTP Password Environment Variable:

set SMTP_PASSWORD=your_app_password

	•	Alternatively, set the environment variable at the system level.

	5.	Run the Script
	•	Open Command Prompt.
	•	Navigate to the script directory.
	•	Execute:

python backup_script.py



Automate with Task Scheduler

	1.	Open Task Scheduler:
	•	Search for “Task Scheduler” in the Start menu.
	2.	Create a New Task:
	•	Provide a name (e.g., “Automated Backup”).
	•	Configure to run whether the user is logged on or not.
	3.	Set Triggers:
	•	Define the schedule (e.g., daily at 2:00 AM).
	4.	Set Actions:
	•	Action: Start a program.
	•	Program/script: Path to python.exe (e.g., C:\Python39\python.exe).
	•	Add arguments: Path to backup_script.py (e.g., C:\path\to\backup_script.py).
	5.	Ensure Environment Variables:
	•	If using SMTP_PASSWORD, set it as a system environment variable.
	•	Alternatively, use a wrapper batch file to set the variable before running the script.

Important Notes

	•	Permissions: Verify that the script has the necessary permissions for all specified paths.
	•	Testing: Run the script manually to ensure it works before scheduling.
	•	Security:
	•	Do not hardcode sensitive information like passwords in the script.
	•	Use environment variables or secure storage methods for credentials.
	•	Email Notifications:
	•	Ensure Gmail SMTP settings are correctly configured.
	•	Check that emails are being sent and received as expected.

Troubleshooting

	•	Errors in Logs: Check the log file for details on any issues.
	•	No Backup Created: Verify paths and permissions.
	•	Email Not Sent: Confirm SMTP settings and internet connectivity.

This concise guide provides essential information for setting up and using the Windows Backup Script.