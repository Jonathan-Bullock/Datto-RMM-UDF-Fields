<#
V1
If a network is not authenticated Pinging myip.dnsfilter.com should result in the response:
"Ping request could not find host myip.dnsfilter.com. Please check the name and try again." or something of that nature.
If a network is authenticated then DNS filter will respond with the IP it see's the request coming from.
"n" flag is number of pings and "w" is the timeout delay in milliseconds.

-----V2 Update-----
myip.dnsfilter started working for un-authenticated domains.started using https://$($category).filterdns.net/status.json instead

-----V3 Update-----
Started Checking for multiple categories using foreach loop

-----V4 Update-----
Got all categories working. 
Extended field to mark the number of total categories that are blocked if any

-----V5 Update-----
Added check and installation for both DNSFilter and NetAlerts certificates

Recently gained access to Groc AI for reviewing code and added Error handeling in addition to adding check to make sure DNSFilter Cert is added to root store.
While working on this found out that DNS Filter has a secondary certificate that they use on some servers but not others

"https://app.dnsfilter.com/certs/DNSFilter.cer"
"https://app.dnsfilter.com/certs/NetAlerts.cer"



Jonathan Bullock Tech Team Solutions
#>

# Function to check and install both DNSFilter and NetAlerts certificates
function Install-DNSFilterAndNetAlertsCertificates {
    $certUrls = @{
        "DNSFilter" = "https://app.dnsfilter.com/certs/DNSFilter.cer"
        "NetAlerts" = "https://app.dnsfilter.com/certs/NetAlerts.cer"
    }

    $success = $true

    foreach ($certName in $certUrls.Keys) {
        $certUrl = $certUrls[$certName]
        $certFile = ".\$certName.cer"

        # Check if the certificate is already installed in the Root store
        if (Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*$certName*" }) {
            Write-Host -BackgroundColor Green "Verified $certName Cert is already installed"
        } else {
            # Certificate is missing
            Write-Host -BackgroundColor Red "Couldn't verify $certName Cert is installed. Attempting to add to root store."
            
            # Download the certificate
            try {
                Invoke-WebRequest -Uri $certUrl -OutFile $certFile
            } catch {
                Write-Host -BackgroundColor Red "Failed to download the $certName certificate: $_"
                $success = $false
                continue
            }
            
            # Wait for 5 seconds to ensure the download is complete
            Start-Sleep -Seconds 5
            
            # Display a message indicating the start of the certificate import process
            Write-Host "Importing $certName certificate..."
            
            # Import the certificate into the Root store
            try {
                certutil -addstore -enterprise -f "Root" $certFile
                Write-Host -BackgroundColor Green "$certName Certificate successfully imported"
            } catch {
                Write-Host -BackgroundColor Red "Failed to import the $certName certificate: $_"
                $success = $false
            }
        }
    }

    return $success
}

# Categories listed on https://debug.dnsfilter.com/
$categories = @(
    'abortion', 'adult', 'alcoholandtobacco', 'blogsandpersonal', 'business', 'contentiousandmisinformation',
    'personals', 'drugs', 'economyandfinance', 'education', 'entertainment', 'foodandrecipes', 'gambling',
    'games', 'government', 'hacking', 'health', 'humor', 'informationtech', 'jobrelated', 'mediasharing',
    'messageboardsandforums', 'newsandmedia', 'illegalcontent', 'realestate', 'religion',
    'searchenginesandportals', 'selfharm', 'socialnetworking', 'shopping', 'sports', 'streamingmedia',
    'terrorismandhate', 'travel', 'vehicles', 'virtualreality', 'weapons', 'chatandmessaging', 'botnet',
    'cryptomining', 'malware', 'newdomains', 'newlyobserveddomains', 'phishing', 'proxyandfilteravoidance',
    'suspiciousanddeceptive', 'translators', 'verynewdomains', 'advertising', 'iwf', 'maliciousdomainprotection',
    'parked', 'trackers', 'uncategorized'
)

# Initialize counters
$BlockedCount = 0
$AllowedCount = 0

# Check and install certificates
if (-not (Install-DNSFilterAndNetAlertsCertificates)) {
    Write-Host -BackgroundColor Red "Certificate installation failed for one or more certificates. Continuing with script execution."
}

# Check category status
foreach ($category in $categories) {
    Write-Host "Checking category: $category"
    try {
        $response = Invoke-WebRequest -Uri "https://$($category).filterdns.net/status.json" -UseBasicParsing
        $content = $response.Content
        Write-Host "Response: $content"
        
        # Uncomment the next line for debugging which node is used
        # Resolve-DnsName "$($category).filterdns.net" -QuickTimeout
        
        if ($content -match "true") {
            $BlockedCount++
        } else {
            $AllowedCount++
        }
    } catch {
        Write-Host -BackgroundColor Yellow "Error checking category $(category): $($Error[0].Message)"
    }
}

# Display results
Write-Host "Allowed Categories: $AllowedCount"
Write-Host "Blocked Categories: $BlockedCount"

# Update UDF in Datto RMM
if ($BlockedCount -gt 0) {
    $udf17 = "True, $BlockedCount of $($categories.Count) Categories Blocked"
} else {
    $udf17 = "False"
}

Write-Host $udf17 #write value to be stored in terminal

#write UDF contents to registry to be picked up by Datto RMM and stored in a UDF
Set-ItemProperty -Path "HKLM:\Software\CentraStage" -Name "Custom17$env:usrUDF17" -Value $udf17