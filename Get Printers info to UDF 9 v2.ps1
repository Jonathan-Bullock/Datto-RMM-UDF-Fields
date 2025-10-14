<#Return a list of printer names, host address and Driver names and versions.
Created 2023 by Jonathan Bullock
-------------Update--------------
2025/04/23
Used Hatz AI to blank spaces and lines in output
Updated filter to include Additional OneNote name
#>

$filter = 'Fax', 
          'Microsoft XPS Document Writer',
          'Microsoft Print to PDF',
          'OneNote (Desktop)',
          'OneNote for Windows 10'

# Get filtered printers without headers
$printer = Get-Printer *
$FilteredPrinters = $printer | Where-Object {$_.Name -notin $filter}
$mappedPrinters = $FilteredPrinters | Select-Object -ExpandProperty Name

# Get TCP/IP ports without headers
$printer = Get-PrinterPort *
$FilteredPrinters = $printer | Where-Object -Property Description -Like '*TCP*'
$printerAddresses = $FilteredPrinters | Select-Object -ExpandProperty PrinterHostAddress

# Get installed print drivers without headers
$printer = Get-PrinterDriver *
$FilteredPrinters = $printer | Where-Object -Property Manufacturer -NotLike 'Microsoft'
$installedPrintDrivers = $FilteredPrinters | Select-Object -ExpandProperty Name

# Combine results, trim spaces and join them
$udf9 = ($mappedPrinters + $printerAddresses + $installedPrintDrivers) | 
        ForEach-Object { $_.Trim() } | 
        Where-Object { $_ -ne "" } |
        Out-String -Stream | 
        Out-String

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom9$env:usrUDF9" -Value $udf9
$udf9
