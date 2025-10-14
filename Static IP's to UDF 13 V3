<#List static IP's if any and output them to UDF 13
These are only statics that are defined on Windows devices and not on the DHCP server Reservation.

V2 Update now makes an additional note in the UDF if there are locally set DNS servers which could override DHCP even if DHCP is enabled.

V3 updated to handle Error when there are no local statics set for DNS

v3 update to only evaluate DNS search if variable isn't Null
-Jonathan Bullock 2024-09-18#>

#check if there is a static Reserved IP
$udf13 = (Get-NetIPAddress | where SuffixOrigin -EQ Manual | ft ipaddress -HideTableHeaders | Out-String -Width 250).Trim()
if ($udf13.Length -eq 0) {$udf13 = "No Static IP"}

#check if the DNS Is set static Seperate of DHCP
function Check-StaticDNS {
    $StaticDNSSearch = (netsh int ip show dnsservers) | Select-String "Statically" | Where-Object { $_.Line -notlike "*None*" }
    if ($StaticDNSSearch -ne $null){
        $results = ($StaticDNSSearch.ToString()).Trim()
        }
    return $results
}

#Prepend UDF with Note
$StaticDNS = Check-StaticDNS
if (($StaticDNS).Length -ne 0) {
    $udf13 = $udf13 + " There is Static DNS set."
    }

$StaticDNS

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom13$env:usrUDF13" -Value $udf13
$udf13
