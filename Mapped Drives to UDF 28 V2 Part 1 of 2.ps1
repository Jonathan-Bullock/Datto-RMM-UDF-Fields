<#Mapped Drives to UDF 28 V2 Part 1 of 2

Important Notes: 
Part 1 needs to be run in user context
Part 2 needs to be run with system permissions.

Known issues:
1. Requires jobs to be run in order
2. Don't yet have a way for clearning out drive mappings that don't exist any more other than over writting per user.
3. This information is collected for all users not just the currently logged in one and it is indifferent to the last time someone signed in.
Contemplating making part 2 delete the information after it is collected or delete the entries for users that haven't logged in x amount of time.

original version Written 2024-12-06
--------------------------Updated 2025-06-02--------------------------
Used Hatz AI assisted develpment to test multiple methods and creat sudo code.
had to do some fine tunning to make sure correct registry hives were accessed per SSID and format to output to a Datto RMM UDF
-Jonathan Bullock
#>


# Get list of network drives
$drives = Get-WmiObject -Class Win32_NetworkConnection | Select-Object -ExpandProperty LocalNameRemoteName

# Format the drives list as a string
$drivesString = ($drives -join ',' | Out-String).Trim()

# Write to a user-accessible registry key
$registryPath = "HKCU:\Software\UserNetworkDrives"
New-Item -Path $registryPath -Force | Out-Null
Set-ItemProperty -Path $registryPath -Name "MappedDrives" -Value $drivesString
Get-ItemProperty -Path $registryPath -Name "MappedDrives"
