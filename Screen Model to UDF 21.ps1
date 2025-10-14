<#Write WMI screen model information to UDF.
Most cases this does not include laptop screens but this depends on the manufacture.
Note: Some manufactures don't fill out this information so it will return blank for some.
#>

$screens = Get-WmiObject WmiMonitorID -Namespace root\wmi | Select-Object @{l="Manufacturer";e={[System.Text.Encoding]::ASCII.GetString($_.ManufacturerName)}}, @{l="Model";e={[System.Text.Encoding]::ASCII.GetString($_.UserFriendlyName)}}, @{l="SerialNumber";e={[System.Text.Encoding]::ASCII.GetString($_.SerialNumberID)}}

$udf21 = (($screens.model) -join ", ").Substring(2)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom21$env:usrUDF21" -Value $udf21
$udf21
