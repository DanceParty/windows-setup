$LocalTempDir = $env:TEMP
$VSCodeInstaller = "VSCodeInstaller.exe"
$vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"

(new-object System.Net.WebClient).DownloadFile($vscodeUrl, "$LocalTempDir\$VSCodeInstaller") 

&"$LocalTempDir\$VSCodeInstaller" /silent /install
$Process2Monitor = "VSCodeInstaller"

Do { 
  $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name
  If ($ProcessesFound) { 
    "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 
  } else { 
    rm "$LocalTempDir\$ArcInstaller" -ErrorAction SilentlyContinue -Verbose 
  } 
} Until (!$ProcessesFound)

# extension list:
# prettier
# panda theme