<# Backup of Bitlocker Key for C: disk
Created by Jonathan Bullock
#>
$udf7 = ((Get-BitLockerVolume -MountPoint C: | Select-Object -ExpandProperty KeyProtector).RecoveryPassword | Out-String -Width 250)
if (($udf7).length -eq 0) {$udf7 = "No Bitlocker on C:"}
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom7$env:usrUDF7" -Value $udf7
$udf7