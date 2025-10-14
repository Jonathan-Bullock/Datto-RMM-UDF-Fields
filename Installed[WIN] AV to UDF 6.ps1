#Collect Windows registered AV apps and populate UDF 6

$udf6 = (get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct).displayname -join ", "

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom6$env:usrUDF6" -Value $udf6
$udf6

get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
