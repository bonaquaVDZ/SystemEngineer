# Enable Remote Powershell
Enable-PSRemoting -Force

# Run Commands on Remote Machines
Invoke-Command -ComputerName RemotePC -ScriptBlock { Get-Process }

# Enter Remote Session
Enter-PSSession -ComputerName RemotePC
Exit-PSSession