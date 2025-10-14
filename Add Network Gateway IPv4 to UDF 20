$udf20 = ((Get-NetIPConfiguration).IPv4DefaultGateway.nexthop).TrimStart() -join ", "
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom20$env:usrUDF20" -Value $udf20
$udf20
