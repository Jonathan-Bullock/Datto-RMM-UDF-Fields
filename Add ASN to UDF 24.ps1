<#
Author: Jonathan Bullock
Reviewer: Jacob Riley
Date of Review: 10/6/2025 @ 11:00AM
Language: PowerShell
Changes Made: Added global variable for API Token, and added DNS hijacking testing

-----------Update 10/7/2025-----------
replaced CURL with Invoke-WebRequest to make consistant
added silently continue to DNS Check so Error output isn't written

#>

$env:token

# Create new http request to access the ipinfo.io API

$response = Invoke-WebRequest -Uri "https://ipinfo.io/json" -UseBasicParsing
$dnsInfo = $response.Content | ConvertFrom-Json
$dnsInfo.ip

# Use curl to request the response data

$response = Invoke-WebRequest ipinfo.io/"($dnsInfo.ip)"?token=$env:token -UseBasicParsing
$dnsInfo = $response.Content | ConvertFrom-Json
$dnsInfo
$dnsInfo.asn.domain

 if (Resolve-DnsName -server 5.5.5.5 -name google.com -ErrorAction SilentlyContinue){
  $dnsRedirect = $true
 } else {
  $dnsRedirect = $false
 }
 write-host $dnsRedirect

$udf24 =  ($dnsInfo.asn.domain + ", " + $dnsInfo.country + ", " + $dnsInfo.loc + ", " + "DNS_Redirect=$($dnsRedirect)" | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom24$env:usrUDF24" -Value $udf24
$udf24
