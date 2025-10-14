if ((Get-CimInstance Win32_OperatingSystem -Property name).name -notlike "*Server*") {
    $udf12 = (((Get-ComputerRestorePoint | measure).Count) | Out-String -Width 250)
    if ($udf12 -eq $null) {$udf12 = "No Restore Points"}
    Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom12$env:usrUDF12" -Value $udf12
}
else {Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom12$env:usrUDF12" -Value "SERVER"}
$udf12
