$i = 0..3 #Initialize Array
#check with multiple services for the clients network public IP and return the resolved address as a string
$i[0] = (Invoke-RestMethod -Uri "https://ipinfo.io/").ip
$i[1] = (Invoke-WebRequest -Uri "https://api.ipify.org/" -UseBasicParsing).Content
$i[2] = (Invoke-WebRequest -Uri "https://ifconfig.me/ip" -UseBasicParsing).Content
#This value is important since it is used to check if DNS filter is authenticated
$i[3] = (nslookup myip.dnsfilter.com 2>$null | Select-String -Pattern "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | ForEach-Object { $_.Matches.Value } | Select-Object -Index 1)
#Group the values of the array and return the most common item
$PublicIP = $i | Group-Object | Sort-Object Count -Descending | Select-Object -First 1 -ExpandProperty Name
return $PublicIP


<# Straght return#>
cls
write-host "$((Invoke-RestMethod -Uri "https://ipinfo.io/").ip) - IPInfo.io"
write-host "$((Invoke-WebRequest -Uri "https://api.ipify.org/" -UseBasicParsing).Content) - ipify.org"
write-host "$((Invoke-WebRequest -Uri "https://ifconfig.me/ip" -UseBasicParsing).Content) - ifconfig.me"
write-host "$(Resolve-DnsName -Name myip.dnsfilter.com -Server 103.247.36.36) - dnsfilter.com"
#>

Resolve-DnsName -Name myip.dnsfilter.com -Server 103.247.36.36