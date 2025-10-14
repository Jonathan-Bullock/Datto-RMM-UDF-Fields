$udf19 = (((ipconfig /all | Select-String "Subnet Mask*") -replace 'Subnet Mask \. .+ :', ''| Sort-Object -Unique ).TrimStart() -join ", "| Out-String -Width 250)
$udf19
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom23$env:usrUDF23" -Value $udf23
