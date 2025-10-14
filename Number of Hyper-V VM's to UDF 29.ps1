#Get the number of Hyper-V VM's and write output to UDF 29
$udf29 = ((Get-VM).count | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom29$env:usrUDF29" -Value $udf29
$udf29
