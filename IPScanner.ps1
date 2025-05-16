
$Devices = Import-Csv .\downloads\DeviceDetailsExport.csv #Default name and location of Datto RMM device export
$Sites = $Devices | ForEach-Object { 
    if($_.'Ext IP Addr' -ne $null){
        [PSCustomObject]@{
            Client     = $_.'Site Name'
            ExternalIP = $_.'Ext IP Addr'
        }
    }
}

# Group the devices by the 'Ext IP Addr' property
$UniqueSites = $Devices | Group-Object -Property 'Ext IP Addr' | ForEach-Object { 
    # Select the first item from each group
    $_.Group | Select-Object -First 1

}

foreach ($site in $UniqueSites) {
    $site.'Ext IP Addr'
    $site.'Site Name'
$test  = Test-NetConnection -Port 4433 -ComputerName $site.ExternalIP >> 4433audit.csv
}
