$udf19 = (((ipconfig /all | Select-String "DHCP Server*") -replace 'DHCP Server \. .+ :', ''| Sort-Object -Unique ).TrimStart() -join ", "| Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom19$env:usrUDF19" -Value $udf19
$udf19
