<#Change Log

Version 1:
Built Speed test server using No-IP address hard codeded

Version 1.2
Added code to use locally loaded table of serial numbers so each device can find it's shedualed time since the server can only run one speed test at a time
had question of what to do for devices that have time drift.

Version 2
since gob is run simultaniosly plan to just try and having sequential time delay in seonds from when the job is registered for the job to sleep until the appointed time to do a quick fix for the time delay.

Version 3
Broke upload and download tests into seperate functions to make it simpler to add logic to check if the server is busy.

Version 4.1
Added randomness in delay so all clients don't attempt to re-attempt at the same time each time.
If I can get more resources could pobibly use randomness to select from a range of ports or since most clients don't have more than 300 Mbps might have 3-4 instances of the same service running on the host at a time so more tests can run simultaniosly.

Version 4.2
Added Error checking for "0" transfer speeds that can happen with incompatable windows versions such as Windows 7 and 2012

Written by Jonathan Bullock Last Update: 2025-07-06

#>

#Should add componant varialbe to adjust the random delay depending on the number of devices the job is being run against.
Start-Sleep -Seconds (Get-Random -Minimum 30 -Maximum 1000) # Wait X seconds before retrying\
$server

#-------------Run Speed Test-------------
function Get-NetSpeedUp{
    $Errors = $true
    $Sent = 0

    While ($Errors -eq $true) {
        # Get Upload Speeds
        $output = & cmd /c '.\iperf3.exe -c $Server -J'
        $results = $output | ConvertFrom-Json

        # Check for errors in the output
        if ($null -ne $results.error) {
            Write-Host "Error: $($results.error)"
            Start-Sleep -Seconds (Get-Random -Minimum 30 -Maximum 1000) # Wait X seconds before retrying
        } else {
            # No error; process the results
            $Errors = $false
            $Sent = [Math]::Round(($results.end.sum_sent.bits_per_second / 1000000), 0)
        }
    }
    if($Sent -eq 0){Write-Error "Non-valid speed Value Exiting..."
    exit 1}
    return $Sent
}

function Get-NetSpeedDown{
    $Errors = $true
    $Sent = 0

    While ($Errors -eq $true) {
        # Get Download Speeds
        $output = & cmd /c '.\iperf3.exe -c $Server -J --reverse'
        $results = $output | ConvertFrom-Json

        # Check for errors in the output
        if ($null -ne $results.error) {
            Write-Host "Error: $($results.error)"
            Start-Sleep -Seconds (Get-Random -Minimum 30 -Maximum 1000) # Wait X seconds before retrying
        } else {
            # No error; process the results
            $Errors = $false
            $Download = [Math]::Round(($results.end.sum_sent.bits_per_second / 1000000), 0)
        }
    }
    if($Download -eq 0){Write-Error "Non-valid speed Value Exiting..."
    exit 1}
    return $Download
}

function Get-NetSpeed{
    #Get Download Speeds
    #concat and output the results
    $udf = " $(Get-NetSpeedDown) / $(Get-NetSpeedUp) Mbps, Last Test: $(get-date)." #I don't think the unit conversion is correct
    $udf
    Set-ItemProperty "HKLM:\Software\CentraStage" -Name "Custom16$env:usrUDF16" -Value $udf
}

Get-NetSpeed