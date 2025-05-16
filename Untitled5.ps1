# Import the Group Policy module
Import-Module GroupPolicy

# Get a GPO
$gpo = Get-GPO -Name "MyGPO"

# Set a registry value in the GPO
Set-GPRegistryValue -Name $gpo.DisplayName -Key "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName "WUServer" -Type String -Value "http://wsusserver"

# Apply the GPO to a specific OU
$ou = "OU=Computers,DC=example,DC=com"
New-GPLink -Name $gpo.DisplayName -Target $ou

# Update group policy on the local machine
gpupdate /force