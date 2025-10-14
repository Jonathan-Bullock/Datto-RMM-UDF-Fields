$udf26 = ((Resolve-DnsName -Server 103.247.36.36 -Name myip.dnsfilter.com -Type A).IPAddress | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom26$env:usrUDF26" -Value $udf26
$udf26
