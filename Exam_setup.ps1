$spotifyAppId = (Get-StartApps | Where-Object {$_.Name -like "*Spotify*"}).AppId
Start-Process $spotifyAppId
Start-Process MSEdge https://kavoskenslaan.smartschool.be
Start-Sleep -Seconds 3
Start-Process MSEdge https://open.spotify.com/track/1LVKWm2sixcBd1sqqrvNNU?si=d17105e918524c3c
