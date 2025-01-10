# JSON
$Json = '{"Name": "Alice", "Age": 230}'
$ParsedJson = $Json | ConvertFrom-Json # Parse Json
$ParsedJson.Name                       # Access Json properties
$ParsedJson | ConvertTo-Json           # Convert back to Json

# XML
$Xml= Get-Content file.xml
$ParsedXml=[xml]$Xml                   # Parse XML
$ParsedXml.ElementName                 # Access XML elements

# CSV
$Csv= Import-Csv file.csv
$Csv | Export-Csv new_file.csv -NoTypeInformation