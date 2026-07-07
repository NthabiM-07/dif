# build_report.ps1 - one-command report build for the DigMore GA3 project
# Usage:
#   .\tools\build_report.ps1          -> re-export 417.docx to 417.pdf
#   .\tools\build_report.ps1 -Push    -> also git add/commit/push the report files
param([switch]$Push)

$root = Split-Path $PSScriptRoot -Parent
$docx = Join-Path $root "05_Working\5.2_Report\417.docx"
$pdf  = Join-Path $root "05_Working\5.2_Report\417.pdf"

if (-not (Test-Path $docx)) { Write-Error "Report not found: $docx"; exit 1 }

Write-Host "Exporting $docx -> PDF..."
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$doc = $word.Documents.Open($docx, $false, $true)   # read-only
$doc.ExportAsFixedFormat([string]$pdf, 17)           # 17 = wdExportFormatPDF
# Cleanup is best-effort: Word COM objects can disconnect after export (RPC_E_DISCONNECTED)
try { $doc.Close($false) } catch {}
# Only quit Word if this instance has no other documents open (protects a user-opened Word window)
try { if ($word.Documents.Count -eq 0) { $word.Quit() } } catch {}
try { [System.Runtime.InteropServices.Marshal]::ReleaseComObject($doc)  | Out-Null } catch {}
try { [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null } catch {}
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
Write-Host "PDF written: $pdf"

if ($Push) {
    Set-Location $root
    git add "05_Working/5.2_Report/417.docx" "05_Working/5.2_Report/417.pdf" "05_Working/5.1_Capacity_Model/417.xlsx"
    $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "Report build $stamp" && git push origin master
}
