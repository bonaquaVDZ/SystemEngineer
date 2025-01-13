# List Files
Get-ChildItem -Path C:\Folder
Get-ChildItem -Filter *.txt  # Lists files with a specific extension

# Copy, Move, and Delete Files
Copy-Item -Path source.txt -Destination dest.txt
Move-Item -Path source.txt -Destination dest.txt
Remove-Item -Path file.txt  # Deletes a file

# Create Files and Directories
New-Item -Path C:\Folder -ItemType Directory
New-Item -Path file.txt -ItemType File -Value "Sample Content"

# Check File/Directory Existence
Test-Path -Path C:\Folder  # Returns True/False

# Read and Write to Files
Get-Content file.txt       # Reads the content of a file
Set-Content file.txt "New Content"  # Overwrites content
Add-Content file.txt "More Content" # Appends content
