# Test Connectivity
Test-Connection -ComputerName google.com   # ping
Resolve-DnsName google.com                 # DNS lookup


# Download files
Invoke-WebRequest -Uri http://example.com/file.txt -OutFile file.txt
