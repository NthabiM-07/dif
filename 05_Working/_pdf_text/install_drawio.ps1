$ProgressPreference = 'SilentlyContinue'
$url = 'https://github.com/jgraph/drawio-desktop/releases/download/v30.0.4/draw.io-30.0.4-windows-installer.exe'
$dst = Join-Path $env:TEMP 'drawio-installer.exe'
Write-Host "Downloading ~136 MB..."
Invoke-WebRequest -Uri $url -OutFile $dst -UseBasicParsing -TimeoutSec 600
$len = (Get-Item $dst).Length
Write-Host "Downloaded $([Math]::Round($len/1MB,1)) MB"
if ($len -lt 100MB) { Write-Error "Download too small"; exit 1 }

Write-Host "Running silent install..."
# NSIS-based installer: /S = silent, /D=path (must be last, no quotes)
$installDir = "$env:LOCALAPPDATA\Programs\drawio"
& $dst /S /D=$installDir
Start-Sleep -Seconds 8

$exe = Get-ChildItem $installDir -Recurse -Filter 'draw.io.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $exe) {
    # Try default install dir
    $alt = Get-ChildItem "$env:LOCALAPPDATA\Programs" -Recurse -Filter 'draw.io.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($alt) { $exe = $alt }
}
if ($exe) { Write-Host "INSTALLED: $($exe.FullName)" } else { Write-Error "draw.io.exe not found after install"; exit 1 }
