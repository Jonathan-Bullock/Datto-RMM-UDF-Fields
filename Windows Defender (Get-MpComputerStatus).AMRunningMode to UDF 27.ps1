$udf27 = (Get-MpComputerStatus).AMRunningMode
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom27$env:usrUDF27" -Value $udf27
$udf27
