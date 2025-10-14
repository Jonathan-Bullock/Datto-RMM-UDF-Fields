#Check if UAC is enabled and update UDF 15 of the Status to read enabled or disabled
$UacStatus = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System").EnableLUA
if ($UacStatus -eq 1) {
    $udf15 = "UAC Enabled."
    write-host '<-Start Result->'
 		write-host "STATUS=UAC is enabled."
 		write-host '<-End Result->'
		Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom15$env:usrUDF15" -Value $udf15
 	exit 0
} else {
    $udf15 = "UAC Disabled."
    write-host '<-Start Result->'
 		write-host "STATUS=UAC is disabled."
 		write-host '<-End Result->'
		Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom15$env:usrUDF15" -Value $udf15
 	exit 1
}
$udf15
