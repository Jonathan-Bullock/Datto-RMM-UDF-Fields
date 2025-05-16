Write-Host "Attempting Version Targeting..."
try{
  #Windows Version Targeting
  Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name ProductVersion -Value "Windows 11"
  Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name TargetReleaseVersion -Value 1
  Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name TargetReleaseVersionInfo -Value "23H2"
  Write-Host "Version Targeting Has Been Applied"
  #exit 0
} catch {
  Write-Host "Version Targeting Has Encountered Error"
  #exit 1
}