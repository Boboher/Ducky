$spotifyAppId = (Get-StartApps | Where-Object {$_.Name -like "*Spotify*"}).AppId
Start-Process $spotifyAppId
Start-Process MSEdge https://kavoskenslaan.smartschool.be
Start-Process MSEdge https://open.spotify.com/playlist/7ovmLivliKHDrROnPg3oYv?si=8e15ccefcc8e407d
