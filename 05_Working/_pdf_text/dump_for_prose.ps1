$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open("C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model\417.xlsx")

Write-Host "=== Capacity rows 3-17 ==="
$s = $wb.Worksheets.Item("Capacity")
for ($r = 3; $r -le 17; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 16; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 22) { $sv = $sv.Substring(0,22) }
            $line += "[$c]$sv "
        }
    }
    Write-Host $line
}

Write-Host "`n=== Equipment-dep rows 1-20 ==="
$s = $wb.Worksheets.Item("Equipment-dep")
for ($r = 1; $r -le 20; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 6; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 40) { $sv = $sv.Substring(0,40) }
            $line += "[$c]$sv | "
        }
    }
    Write-Host $line
}

Write-Host "`n=== Personnel ==="
$s = $wb.Worksheets.Item("Personnel")
for ($r = 1; $r -le 25; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 4; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 40) { $sv = $sv.Substring(0,40) }
            $line += "[$c]$sv | "
        }
    }
    Write-Host $line
}

Write-Host "`n=== Parking ==="
$s = $wb.Worksheets.Item("Parking")
for ($r = 1; $r -le 15; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 4; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 40) { $sv = $sv.Substring(0,40) }
            $line += "[$c]$sv | "
        }
    }
    Write-Host $line
}

Write-Host "`n=== Storage_3D ==="
$s = $wb.Worksheets.Item("Storage_3D")
for ($r = 1; $r -le 30; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 4; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 35) { $sv = $sv.Substring(0,35) }
            $line += "[$c]$sv | "
        }
    }
    Write-Host $line
}

Write-Host "`n=== Inventory_Pack ==="
$s = $wb.Worksheets.Item("Inventory_Pack")
for ($r = 1; $r -le 20; $r++) {
    $line = "R" + $r + ": "
    for ($c = 1; $c -le 4; $c++) {
        $v = $s.Cells.Item($r,$c).Value2
        if ($v -ne $null) {
            $sv = [string]$v
            if ($sv.Length -gt 35) { $sv = $sv.Substring(0,35) }
            $line += "[$c]$sv | "
        }
    }
    Write-Host $line
}

Write-Host "`n=== BusinessCase total + equipment subtotal ==="
$s = $wb.Worksheets.Item("BusinessCase")
for ($r = 30; $r -le 40; $r++) {
    $a = $s.Cells.Item($r,1).Value2
    $d = $s.Cells.Item($r,4).Value2
    if ($a -ne $null) { Write-Host "R${r}: [$a] [D=$d]" }
}

$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()

