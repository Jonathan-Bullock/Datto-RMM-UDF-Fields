$quserResult = quser /server:$env:COMPUTERNAME 2>&1 #get user login status
$quserRegex = $quserResult | ForEach-Object -Process { $_ -replace '\s{2,}',',' } #convert to CSV
$quserObject = $quserRegex | ConvertFrom-Csv #convert to object type
$quserObject #write data
$udf = ((Get-Date) - [datetime]($quserObject.'LOGON TIME')).Days #get amound of time user has been logged in days
$udf26 = ($udf | Out-String -Width 250)
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom26$env:usrUDF26" -Value $udf26