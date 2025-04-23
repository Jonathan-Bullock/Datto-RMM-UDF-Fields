<# Get Disk part Name to UDF 4
In windows powershell this is the disk friendly name.

Created by Jonathan Bullock 2024-10-18 15:35:44
#>

$udf4 = ((get-disk).friendlyname | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom4$env:usrUDF4" -Value $udf4
$udf4