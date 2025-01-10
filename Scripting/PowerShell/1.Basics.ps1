# Get Help
Get-Help                        # Displays help about PowerShell cmdlets
Get-Help Get-Process            # Displays help for a specific cmdlet
Get-Help Get-Process -Examples  # Shows examples for a cmdlet

# Listing and Navigating
Get-ChildItem           # Lists files and directories (like `ls`)
Set-Location C:\Folder  # Changes the current directory (like `cd`)
Get-Location            # Displays the current directory

# Working with Variables
$Variable = "Value"           # Create a variable
$Variable                     # Access a variable
Remove-Variable -Name VariableName  # Deletes a variable

# Displaying Output
Write-Output "Hello, World!"  # Prints to the console
Write-Host "Hello, World!"    # Prints without adding it to the pipeline
