$username = "<Insert User Name>"
$udf18 = (get-localuser -Name $username ).LastLogon
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom18$env:usrUDF18" -Value $udf18
$udf18
<#Feature road map
Would like to check for the most recent user of the administrators security group that has signed in not just the most recently signed in.
#>
