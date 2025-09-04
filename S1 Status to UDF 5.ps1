#find current version Config File
if(!(test-path "C:\Program Files\SentinelOne\")){
    Write-error "C:\Program Files\SentinelOne\ doesn't exist. Exiting early..."
    exit 1}


Set-Location  (Get-ChildItem -Path "C:\Program Files\SentinelOne\" -Recurse -Filter *sentinelctl*).DirectoryName

#Run Queery's
$s1_mgmtServer = .\sentinelctl configure server.mgmtServer
$S1_Site = .\sentinelctl configure server.site
$S1_vssSnapshots  = .\sentinelctl configure agent.vssSnapshots 

#Build String
$udf = "VSS Snapshots: " + $S1_vssSnapshots + ", Site ID: " + $S1_Site + ", MGMT SVR: " +$s1_mgmtServer
#write sting to terminal
$udf

#Write to registry for Datto RMM UDF
Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom5$env:usrUDF5" -Value $udf

#used for Performance Tracking
Get-Date