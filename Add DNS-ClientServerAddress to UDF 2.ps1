<#store DNS severs address in UDF field
Created By Jonathan Bullock 2024-10-16 14:19:56#>

$udf2 = (((Get-DnsClientServerAddress | Where-Object {$_.ServerAddresses -notlike "fec0*"}).serveraddresses| Sort-Object -Unique ) -join ", "| Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom2$env:usrUDF2" -Value $udf2
$udf2

<# old code as of 20230912
$udf2 = ((Get-DnsClientServerAddress | Where-Object {$_.ServerAddresses -notlike "fec0:0:0:ffff::*"}).serveraddresses| Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom2$env:usrUDF2" -Value $udf2
#>