<#Gets the network suffix for all interfaces and then writes the data to UDF 20

-Jonathan Bullock 2024/07/29

------------------------------------------------------
#2024/10/2024 Updated to remove Null values and to seperate interfaces with a comma#>

# Get the DNS Client info and store in $string
$string = (Get-DnsClient)

# Filter out empty or null values and then join them
$string = (($string.ConnectionSpecificSuffix | Where-Object {$_ -ne ""}) -join ", ").Trim() | Out-String -Width 250

# Output the result
$string

#write the results to Registry to pipe to UDF in Datto RMM
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom22$env:usrUDF22" -Value $string
