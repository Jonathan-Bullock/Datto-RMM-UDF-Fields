<# Gets interface link Speed and write to UDF

Created by Jonathan Bullock with Hatz AI
#>

$Adapters = Get-NetAdapter | Where-Object {($_.LinkSpeed -ne '0 bps') -and ($_.Name -like "Ethernet*" -or $_.Name -like "Wi-Fi*") }
$sting = ""
foreach ($Adapter in $Adapters) 
{
    $string += $adapter.Name
    $string += " "
    $string += $adapter.Status
    $string += " "
    $string += $adapter.LinkSpeed
    $string += ", "
}

$udf8 = ($String.TrimEnd(', ') | Out-String -Width 250)

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom8$env:usrUDF8" -Value $udf8