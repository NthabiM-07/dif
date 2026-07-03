param([string]$Src)
$tmp = Join-Path $env:TEMP ('docx_' + [IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tmp -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($Src, $tmp)
$docPath = Join-Path $tmp 'word\document.xml'
if (-not (Test-Path $docPath)) { Write-Error "document.xml not found"; exit 1 }
$xmlText = Get-Content -LiteralPath $docPath -Raw -Encoding UTF8
$xml = New-Object System.Xml.XmlDocument
$xml.LoadXml($xmlText)
$ns = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
$ns.AddNamespace('w','http://schemas.openxmlformats.org/wordprocessingml/2006/main')
$paras = $xml.SelectNodes('//w:p', $ns)
foreach ($p in $paras) {
    $sb = New-Object System.Text.StringBuilder
    $runs = $p.SelectNodes('.//w:t', $ns)
    foreach ($r in $runs) { [void]$sb.Append($r.InnerText) }
    $line = $sb.ToString()
    if ($line.Trim().Length -gt 0) { $line }
}
Remove-Item $tmp -Recurse -Force
