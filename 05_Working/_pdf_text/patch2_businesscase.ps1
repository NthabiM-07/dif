# Patch 2: rebuild BusinessCase equipment + risks + schedule with explicit per-row writes
$ErrorActionPreference = 'Stop'
$path = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model\417.xlsx"

$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open($path)
$s = $wb.Worksheets.Item("BusinessCase")

# Clear rows 13 onwards (keep building-capex rows 1-9 intact)
$s.Range("A11:E200").Clear() | Out-Null

# --- Equipment header (rows 11-12) ---
$s.Cells.Item(11,1) = "Equipment capex (supplier-based; quote required)"
$s.Cells.Item(11,1).Font.Bold = $true
$s.Cells.Item(12,1) = "Equipment"
$s.Cells.Item(12,2) = "Qty"
$s.Cells.Item(12,3) = "Indicative unit cost (R)"
$s.Cells.Item(12,4) = "Capex (R)"
$s.Cells.Item(12,5) = "Supplier-class source"
$s.Range("A12:E12").Font.Bold = $true

# --- Equipment rows ---
function AddEquipRow($s, $row, $name, $qty, $unit, $src) {
    $s.Cells.Item($row, 1) = $name
    if ($qty -is [string] -and $qty.StartsWith("=")) { $s.Cells.Item($row, 2).Formula = $qty } else { $s.Cells.Item($row, 2) = $qty }
    $s.Cells.Item($row, 3) = $unit
    $s.Cells.Item($row, 4).Formula = "=B" + $row + "*C" + $row
    $s.Cells.Item($row, 5) = $src
}

$r = 13
AddEquipRow $s $r "Automatic cold saw with bar feed (tube cut)" "=Capacity!M4" 350000 "ProfiFeed A420 class; supplier quote"; $r++
AddEquipRow $s $r "Electric tapping machine (internal thread)" "=Capacity!M5" 180000 "Roscamat Tiger class; supplier quote"; $r++
AddEquipRow $s $r "Ram-type tube end former (narrow end)" "=Capacity!M6" 250000 "Hippo class; supplier quote"; $r++
AddEquipRow $s $r "Two-die thread/profile rolling machine (knurl + thread)" "=Capacity!M7" 380000 "Profimach PTR 42 class; supplier quote"; $r++
AddEquipRow $s $r "Power press, progressive die (shovel head stamp)" "=Capacity!M8" 450000 "mechanical press class; supplier quote"; $r++
AddEquipRow $s $r "Press brake (shovel head shape/bend)" "=Capacity!M9" 300000 "press brake class; supplier quote"; $r++
AddEquipRow $s $r "Automated grinder (blade sharpening, 8 units)" "=Capacity!M10" 280000 "automated grinder class; supplier quote"; $r++
AddEquipRow $s $r "Automated serrator (blade serrate, 4 units)" "=Capacity!M11" 220000 "automated serrator class; supplier quote"; $r++
AddEquipRow $s $r "Power press, progressive die (hinge stamp)" "=Capacity!M12" 280000 "mechanical press class; supplier quote"; $r++
AddEquipRow $s $r "Small press brake (hinge bend)" "=Capacity!M13" 180000 "press brake class; supplier quote"; $r++
AddEquipRow $s $r "Pneumatic riveter" "=Capacity!M14" 60000 "standard riveter class; supplier quote"; $r++
AddEquipRow $s $r "Polishing / deburring station (4 units)" "=Capacity!M15" 120000 "buffing/deburring class; supplier quote"; $r++
AddEquipRow $s $r "Assembly workstation (bench + tooling)" "=Capacity!M16" 40000 "fitting bench + tooling"; $r++
AddEquipRow $s $r "Packaging workstation (bench + tape + scale)" "=Capacity!M17" 35000 "fitting bench + tooling"; $r++
AddEquipRow $s $r "T6 ageing batch oven" "='Equipment-dep'!B15" 950000 "ARC / aluminium ageing furnace class; supplier quote"; $r++
AddEquipRow $s $r "Sandblasting booth with extraction" 1 650000 "enclosed booth class; supplier quote"; $r++
AddEquipRow $s $r "Powder-coat conveyor + booth + cure oven" "='Equipment-dep'!B9" 2800000 "conveyorised 600 parts/h line; supplier quote"; $r++
AddEquipRow $s $r "Counterbalance forklift (3 t)" 3 450000 "standard 3 t forklift class"; $r++
AddEquipRow $s $r "Pallet jacks and trolleys" 8 18000 "standard MH"; $r++

$equipFirstRow = 13
$equipLastRow = $r - 1
$subRow = $r
$s.Cells.Item($subRow, 1) = "Subtotal equipment"
$s.Cells.Item($subRow, 4).Formula = "=SUM(D" + $equipFirstRow + ":D" + $equipLastRow + ")"
$s.Cells.Item($subRow, 1).Font.Bold = $true
$s.Cells.Item($subRow, 4).Font.Bold = $true
$r += 2

# Total capex
$totalRow = $r
$s.Cells.Item($totalRow, 1) = "TOTAL ESTIMATED CAPEX (building + equipment)"
$s.Cells.Item($totalRow, 4).Formula = "=D9+D" + $subRow
$s.Cells.Item($totalRow, 1).Font.Bold = $true
$s.Cells.Item($totalRow, 4).Font.Bold = $true
$s.Cells.Item($totalRow, 4).Interior.ColorIndex = 35
$r += 2

# --- Risks ---
$s.Cells.Item($r, 1) = "Risk register"
$s.Cells.Item($r, 1).Font.Bold = $true
$r++
$s.Cells.Item($r, 1) = "Risk"
$s.Cells.Item($r, 2) = "Likelihood"
$s.Cells.Item($r, 3) = "Impact"
$s.Cells.Item($r, 4) = "Score"
$s.Cells.Item($r, 5) = "Mitigation"
$s.Range("A" + $r + ":E" + $r).Font.Bold = $true
$r++

function AddRiskRow($s, $row, $risk, $like, $impact, $score, $mit) {
    $s.Cells.Item($row, 1) = $risk
    $s.Cells.Item($row, 2) = $like
    $s.Cells.Item($row, 3) = $impact
    $s.Cells.Item($row, 4) = $score
    $s.Cells.Item($row, 5) = $mit
}

AddRiskRow $s $r "Powder-coat enclosure construction delay" "High" "High" 9 "Phase build: powder line on critical path; pre-order long-lead extraction units; commission in parallel"; $r++
AddRiskRow $s $r "Equipment delivery lead time (heat-treat oven, powder line)" "Medium" "High" 6 "Place orders at design freeze; penalty clauses; identify alternate suppliers"; $r++
AddRiskRow $s $r "Aluminium price volatility" "High" "Medium" 6 "6-month rolling supplier contracts; track LME; pass-through clause to customers"; $r++
AddRiskRow $s $r "Bottleneck stations under +10% demand growth" "Medium" "High" 6 "Reserve floor space adjacent to cut, knurl+thread and sharpen for +1 machine each; utilities sized at +20% margin"; $r++
AddRiskRow $s $r "Skilled operator shortage (threading, powder coat)" "Medium" "Medium" 4 "8-week training programme; TVET partnership; OEM training during commissioning"; $r++
AddRiskRow $s $r "Regulatory approval (zoning, fume emissions)" "Low" "High" 3 "Municipality engagement at concept; environmental compliance certificate before slab pour"; $r++
AddRiskRow $s $r "Building cost overrun" "Medium" "Medium" 4 "Fixed-price contract with QS oversight; 10% capex contingency"; $r++
AddRiskRow $s $r "Forklift / pedestrian collision" "Medium" "High" 6 "Painted pedestrian lanes; mirrors at blind corners; speed governors; induction training"; $r++

$r += 1

# --- Schedule ---
$s.Cells.Item($r, 1) = "Implementation schedule (high-level, 11 months)"
$s.Cells.Item($r, 1).Font.Bold = $true
$r++
$s.Cells.Item($r, 1) = "Phase"
$s.Cells.Item($r, 2) = "Months"
$s.Cells.Item($r, 3) = "Key activities"
$s.Range("A" + $r + ":C" + $r).Font.Bold = $true
$r++

function AddPhaseRow($s, $row, $phase, $months, $activities) {
    $s.Cells.Item($row, 1) = $phase
    $s.Cells.Item($row, 2) = $months
    $s.Cells.Item($row, 3) = $activities
}

AddPhaseRow $s $r "1. Design freeze + procurement" "M1-M2" "Detail design sign-off; quotations; place equipment orders (long-lead first)"; $r++
AddPhaseRow $s $r "2. Site preparation" "M2-M3" "Earthworks, services, foundations"; $r++
AddPhaseRow $s $r "3. Building construction" "M3-M7" "Slab, structure, envelope, internal walls; powder-coat enclosure in parallel"; $r++
AddPhaseRow $s $r "4. Services and utilities" "M5-M8" "Power (3-phase), water, compressed air, HVAC, fume extraction, fire suppression"; $r++
AddPhaseRow $s $r "5. Equipment installation" "M7-M9" "Machines positioned, levelled, wired, commissioned"; $r++
AddPhaseRow $s $r "6. Trial production and ramp-up" "M9-M10" "First-off parts, capacity tests, operator training, OEM sign-off"; $r++
AddPhaseRow $s $r "7. Handover to Operations" "M10-M11" "Documentation, spares, maintenance plan, formal handover"; $r++

# Format
$s.Columns.Item(1).ColumnWidth = 50
$s.Columns.Item(2).ColumnWidth = 14
$s.Columns.Item(3).ColumnWidth = 22
$s.Columns.Item(4).ColumnWidth = 18
$s.Columns.Item(5).ColumnWidth = 60
for ($rr = $equipFirstRow; $rr -le $equipLastRow; $rr++) { $s.Cells.Item($rr, 4).NumberFormat = "#,##0" }
$s.Cells.Item($subRow, 4).NumberFormat = "#,##0"
$s.Cells.Item($totalRow, 4).NumberFormat = "#,##0"

$wb.Save() | Out-Null
$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
Write-Host ("BusinessCase rebuilt. Equipment subtotal row=" + $subRow + "  Total capex row=" + $totalRow)
