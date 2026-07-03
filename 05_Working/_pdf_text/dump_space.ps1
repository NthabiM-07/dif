$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open("C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model\417.xlsx")
$s = $wb.Worksheets.Item("Space_Summary")
for ($r = 1; $r -le 25; $r++) {
    $line = ""
    for ($c = 1; $c -le 4; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) { $line += "[$c]=" + ([string]$v).Substring(0, [Math]::Min(40, ([string]$v).Length)) + " " }
    }
    if ($line.Length -gt 0) { Write-Host ("R$r " + $line) }
}
$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
