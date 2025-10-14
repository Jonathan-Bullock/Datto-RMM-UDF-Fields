$username = "<Insert User Name>" #doesn't work for Azure AD / Entra Accounts
$udf18 = (get-localuser -Name $username ).LastLogon 
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom18$env:usrUDF18" -Value $udf18
$udf18
<#Feature road map
Would like to check for the most recent user of the administrators security group that has signed in not just the most recently signed in.

Psudo code for future update:

$admins = (Get-LocalGroupMember -Group Administrators).name

foreach ($admin in $admins){
    $logindate.add = (get-localuser -Name $admin).LastLogon} #having issues with this section for mixed account types


$udf18 = $logindate -sort | select 1 #select the most recent date from list
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom18$env:usrUDF18" -Value $udf18
$udf18

#>

