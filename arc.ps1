$LocalTempDir = $env:TEMP
$ArcInstaller = "ArcInstaller.exe" 

(new-object System.Net.WebClient).DownloadFile('https://releases.arc.net/windows/ArcInstaller.exe', "$LocalTempDir\$ArcInstaller") 

&"$LocalTempDir\$ArcInstaller" /silent /install
$Process2Monitor = "ArcInstaller"

Do { 
  $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name
  If ($ProcessesFound) { 
    "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 
  } else { 
    rm "$LocalTempDir\$ArcInstaller" -ErrorAction SilentlyContinue -Verbose 
  } 
} Until (!$ProcessesFound)
