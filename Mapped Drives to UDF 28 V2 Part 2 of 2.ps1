<#Mapped Drives to UDF 28 V2 Part 2 of 2

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

function Get-MappedDrives {
$sids = reg query HKU
    foreach ($sid in $sids){
        $registryPath = "Registry::$sid\Software\UserNetworkDrives"
    
        # Validate key and read the property
        if (Test-Path $registryPath) {
                $mappedDrives = (Get-ItemProperty -Path $registryPath "MappedDrives").MappedDrives
                #Write-Output "Mapped Drives for user: "
                return $mappedDrives
            } else {
                Write-Output "No mapped drives found."
            }
    } 
}

$udf28 = (Get-MappedDrives) -join ','| Out-String -Width 250
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom28$env:usrUDF28" -Value $udf28
$udf28 #write value to output