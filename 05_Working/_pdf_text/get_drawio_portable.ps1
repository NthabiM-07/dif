$ProgressPreference = 'SilentlyContinue'
$urls = @(
  'https://github.com/jgraph/drawio-desktop/releases/download/v28.0.6/draw.io-28.0.6-windows-no-installer.zip',
  'https://github.com/jgraph/drawio-desktop/releases/download/v27.0.5/draw.io-27.0.5-windows-no-installer.zip',
  'https://github.com/jgraph/drawio-desktop/releases/download/v26.2.2/draw.io-26.2.2-windows-no-installer.zip',
  'https://github.com/jgraph/drawio-desktop/releases/download/v24.7.17/draw.io-24.7.17-windows-no-installer.zip'
)
$dst = Join-Path $env:TEMP 'drawio_portable'
if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
New-Item -ItemType Directory -Path $dst | Out-Null
$zip = Join-Path $dst 'drawio.zip'

$ok = $false
foreach ($u in $urls) {
    Write-Host "Trying $u"
    try {
        Invoke-WebRequest -Uri $u -OutFile $zip -UseBasicParsing -ErrorAction Stop -TimeoutSec 120
        $len = (Get-Item $zip).Length
        Write-Host "Downloaded $len bytes"
        if ($len -gt 1MB) { $ok = $true; break }
    } catch {
        Write-Host "FAIL: $($_.Exception.Message)"
    }
}

if (-not $ok) { Write-Error "All downloads failed"; exit 1 }

Expand-Archive -LiteralPath $zip -DestinationPath $dst -Force
$exe = Get-ChildItem $dst -Recurse -Filter 'draw.io.exe' | Select-Object -First 1
if ($exe) { Write-Host "EXE: $($exe.FullName)" } else { Write-Error "draw.io.exe not found after extract"; exit 1 }
