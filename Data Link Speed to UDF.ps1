<#----------------------08/09/2025----------------------
Updated to add Wi-Fi Signal Strength
-Jonathan Bullock
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
    if (($adapter.Name -eq "Wi-Fi") -and ($adapter.Status -eq "Up")){
        $SignaStrength = ((netsh wlan show interfaces) -Match 'Signal').trim('    Signal                 :').ToString()
        $string += " "
        $string += "Strength: $($SignaStrength)"
    }

    $string += ", "
}

$udf8 = ($String.TrimEnd(', ') | Out-String -Width 250)

$udf8

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom8$env:usrUDF8" -Value $udf8