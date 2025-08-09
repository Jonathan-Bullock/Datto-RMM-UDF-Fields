# Get list of network drives
$drives = Get-WmiObject -Class Win32_NetworkConnection | Select-Object -ExpandProperty RemoteName

# Format the drives list as a string
$drivesString = ($drives -join ',' | Out-String).Trim()

# Write to a user-accessible registry key
$registryPath = "HKCU:\Software\UserNetworkDrives"
New-Item -Path $registryPath -Force | Out-Null
Set-ItemProperty -Path $registryPath -Name "MappedDrives" -Value $drivesString
