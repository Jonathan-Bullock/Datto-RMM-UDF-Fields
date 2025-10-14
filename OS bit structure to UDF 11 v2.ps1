#add OS Bit Structure to UDF
$udf11 = ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom11$env:usrUDF11" -Value $udf11
