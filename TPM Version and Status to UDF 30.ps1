<#Gets TPM version number and status.
Only write status of active if it's initialized, Enabled and owned all equal true.#>

$TPM = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm
$udf = $TPM.PhysicalPresenceVersionInfo
if ($TPM.IsActivated_InitialValue -and $TPM.IsEnabled_InitialValue -and $TPM.IsOwned_InitialValue){
    #if all are true
    $udf = $TPM.PhysicalPresenceVersionInfo + ", " + "Active"}
    else{
    #if any are false
    $udf = $TPM.PhysicalPresenceVersionInfo + ", " + "Inacitve"}

$udf30 = $udf

Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom30$env:usrUDF30" -Value $udf30
$udf30
