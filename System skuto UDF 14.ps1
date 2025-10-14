<#Add System SKU to UDF 14.
Needed primarily for HP Warranty Check lookup Since this is not the same as the OS reported serial Number.>
Goel is to get system hardware sku for HPE Warantee lookup
check Field Valie
#>
$udf14 = (Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty SystemSKUNumber | Out-String -Width 250) 2> error.txt
#check for errors
$Message = Get-ChildItem .\error.txt

#error Action
if ($Message.Length -gt 500){
$udf14 = "No Data"
Echo "No Data"
}
#write output to UDF
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom14$env:usrUDF14" -Value $udf14
#File Cleanup
Remove-Item .\error.txt
$udf14
