# Get list of user sessions
$sessions = query user | Select-String "Active|Disc"

foreach ($session in $sessions) {
    $entry = $session -split "\s+"
    $sessionUser = $entry[0]
    $sessionID = $entry[1]

    # Check drives for each session
    $cmd = "cmd.exe /c qwinsta /server:localhost $sessionID"
    $qwinstaOutput = Invoke-Expression $cmd
    # Parse qwinstaOutput to find mapped drives if the session allows visibility
    Write-Output "Session user: $sessionUser"
}
