<#Add RAM Part Number To UDF 3

Created by Jonathan Bullock 2024-10-16 14:23:07#>

$memory = Get-CimInstance -Class CIM_PhysicalMemory

$results = foreach ($mem in $memory) {
    [pscustomobject]@{
        PartNumber = $mem.PartNumber
        ConfiguredClockSpeed = $mem.ConfiguredClockSpeed
        of = "of"
        Speed = $mem.Speed
    }
}
$udf = ($results | Format-Table -HideTableHeaders)
#Limit Field to max character count for RMM
$udf = $udf | Out-String -Width 250
#write varialbe to Regisry for agent to collect
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom3$env:usrUDF3" -Value $udf
$udf