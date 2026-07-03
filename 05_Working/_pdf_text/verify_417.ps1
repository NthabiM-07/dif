# Dump key cells from 417.xlsx to verify build
$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open("C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model\417.xlsx")

Write-Host "=== Sheets ==="
foreach ($s in $wb.Worksheets) { Write-Host (" - " + $s.Name) }

Write-Host "`n=== Evaluation totals ==="
$ev = $wb.Worksheets.Item("Evaluation")
for ($r = 1; $r -le 12; $r++) {
    $line = ""
    for ($c = 1; $c -le 8; $c++) {
        $v = $ev.Cells.Item($r,$c).Value2
        if ($v -ne $null) { $line += "[$c]=$v " }
    }
    if ($line.Length -gt 0) { Write-Host ("R$r " + $line) }
}

Write-Host "`n=== Bottleneck top rows ==="
$b = $wb.Worksheets.Item("Bottleneck")
for ($r = 1; $r -le 26; $r++) {
    $line = ""
    for ($c = 1; $c -le 6; $c++) {
        $v = $b.Cells.Item($r,$c).Value2
        if ($v -ne $null) { $line += "[$c]=" + ([string]$v).Substring(0, [Math]::Min(40, ([string]$v).Length)) + " " }
    }
    if ($line.Length -gt 0) { Write-Host ("R$r " + $line) }
}

Write-Host "`n=== BusinessCase summary ==="
$bc = $wb.Worksheets.Item("BusinessCase")
for ($r = 1; $r -le 10; $r++) {
    $line = ""
    for ($c = 1; $c -le 5; $c++) {
        $v = $bc.Cells.Item($r,$c).Value2
        if ($v -ne $null) { $line += "[$c]=" + ([string]$v).Substring(0, [Math]::Min(50, ([string]$v).Length)) + " " }
    }
    if ($line.Length -gt 0) { Write-Host ("R$r " + $line) }
}
# total capex
Write-Host ("Building subtotal D9 = " + $bc.Cells.Item(9,4).Value2)
# find total row
for ($r = 30; $r -le 45; $r++) {
    $a = $bc.Cells.Item($r,1).Value2
    if ($a -like "TOTAL*") { Write-Host ("Total capex (R" + $r + ") = " + $bc.Cells.Item($r,4).Value2); break }
}

Write-Host "`n=== Traceability rows ==="
$t = $wb.Worksheets.Item("Traceability")
for ($r = 4; $r -le 22; $r++) {
    $line = ""
    for ($c = 1; $c -le 7; $c++) {
        $v = $t.Cells.Item($r,$c).Value2
        if ($v -ne $null) { $line += "[$c]=" + ([string]$v).Substring(0, [Math]::Min(30, ([string]$v).Length)) + " " }
    }
    if ($line.Length -gt 0) { Write-Host ("R$r " + $line) }
}

$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
