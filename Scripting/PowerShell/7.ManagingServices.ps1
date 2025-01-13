# List services
Get-Service

# Start, Stop and Restart Services
Start-Service -Name "Spooler"
Stop-Service -Name "Spooler"
Restart-Service -Name "Spooler"

# Change Service Startup Type
Set-Service -Name "Spooler" -StartupType Manual