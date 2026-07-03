param([string]$Src,[string]$OutTxt)
# Tries pdftotext if available, otherwise tries System.Windows.Forms via Word interop, otherwise tries iTextSharp.
$pdftotext = Get-Command pdftotext -ErrorAction SilentlyContinue
if($pdftotext){
  & pdftotext.exe -layout -enc UTF-8 "$Src" "$OutTxt"
  return
}
# Try Word interop (works on Windows with Word installed)
try {
  $word = New-Object -ComObject Word.Application
  $word.Visible = $false
  $doc = $word.Documents.Open($Src, $false, $true)
  $text = $doc.Content.Text
  $doc.Close($false)
  $word.Quit()
  [Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
  Set-Content -LiteralPath $OutTxt -Value $text -Encoding UTF8
  return
} catch {}
Write-Error "No PDF reader available"
