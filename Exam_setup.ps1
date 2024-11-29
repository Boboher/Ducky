$spotifyAppId = (Get-StartApps | Where-Object {$_.Name -like "*Spotify*"}).AppId
Start-Process $spotifyAppId
Start-Process MSEdge https://kavoskenslaan.smartschool.be
