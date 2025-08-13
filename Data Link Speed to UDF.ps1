<#----------------------08/09/2025----------------------
Updated to add Wi-Fi Signal Strength
-Jonathan Bullock
#>

#Get array of Wi-Fi and Ethernet addapters
$Adapters = Get-NetAdapter | Where-Object {($_.LinkSpeed -ne '0 bps') -and ($_.Name -like "Ethernet*" -or $_.Name -like "Wi-Fi*") }
$sting = ""

#Build String output
foreach ($Adapter in $Adapters) 
{
    $string += $adapter.Name
    $string += " "
    $string += $adapter.Status
    $string += " "
    $string += $adapter.LinkSpeed
    #If the Primary uplink is Wi-Fi get the Wi-Fi signal Strength and apped to output
    if (($adapter.Name -eq "Wi-Fi") -and ($adapter.Status -eq "Up")){
        $SignaStrength = ((netsh wlan show interfaces) -Match 'Signal').trim('    Signal                 :').ToString()
        $string += " "
        $string += "Strength: $($SignaStrength)"
    }

    $string += ", " #output seperating interface by comma so if there is a CSV export from RMM you can use excels TextToColumn function with delimination to make sorting easier to locate trouble device
}

$udf8 = ($String.TrimEnd(', ') | Out-String -Width 250) #Strip last comma so there's not an extra one on the end so the report looks nicer and limit string length to 250 charecters for Datto RMM max UDF length


$udf8 #write output to host

#write output to registry to update UDF
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom8$env:usrUDF8" -Value $udf8