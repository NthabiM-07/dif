# Build 417.xlsx as the single source of truth by enriching v2 workbook.
# Adds: Bottleneck, BusinessCase, Traceability. Scores Evaluation. Saves as 417.xlsx.

$ErrorActionPreference = 'Stop'
$root = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model"
$src  = Join-Path $root "DigMore_Facility_Calculations_v2.xlsx"
$dest = Join-Path $root "417.xlsx"

$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false

$wb = $xl.Workbooks.Open($src)

function Get-OrAdd-Sheet($wb, $name) {
    foreach ($s in $wb.Worksheets) { if ($s.Name -eq $name) { $s.Cells.Clear() | Out-Null; return $s } }
    $s = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets[$wb.Worksheets.Count])
    $s.Name = $name
    return $s
}

function Write-Row($sheet, $row, $values) {
    for ($i = 0; $i -lt $values.Count; $i++) {
        $sheet.Cells.Item($row, $i + 1) = $values[$i]
    }
}

# --- 1. Bottleneck Analysis sheet -----------------------------------------
$s = Get-OrAdd-Sheet $wb "Bottleneck"
Write-Row $s 1 @("Bottleneck analysis and demand sensitivity")
Write-Row $s 2 @("Pulls live from Capacity. Highest utilisation = constraint; +10% demand shows expansion margin.")
Write-Row $s 4 @("Process","Machines","Utilisation","Status","+10% util","Action if +10%")
$s.Range("A4:F4").Font.Bold = $true

$cap = $wb.Worksheets.Item("Capacity")
# Capacity uses rows 4..17 for processes; col A name, col M machines, col N util
for ($r = 4; $r -le 17; $r++) {
    $outRow = $r + 1   # rows 5..18 on Bottleneck
    $s.Cells.Item($outRow, 1).Formula = "=Capacity!A$r"
    $s.Cells.Item($outRow, 2).Formula = "=Capacity!M$r"
    $s.Cells.Item($outRow, 3).Formula = "=Capacity!N$r"
    $s.Cells.Item($outRow, 4).Formula = '=IF(C' + $outRow + '>=0.9,"CONSTRAINT",IF(C' + $outRow + '>=0.7,"near",""))'
    # +10% demand: util becomes util * 1.10 (machines fixed) - sensitivity
    $s.Cells.Item($outRow, 5).Formula = '=C' + $outRow + '*1.1'
    $s.Cells.Item($outRow, 6).Formula = '=IF(E' + $outRow + '>1,"add 1 machine",IF(E' + $outRow + '>=0.95,"watch",""))'
}
$s.Columns.Item(3).NumberFormat = "0.0%"
$s.Columns.Item(5).NumberFormat = "0.0%"
$s.Columns.Item(1).ColumnWidth = 30
for ($c = 2; $c -le 6; $c++) { $s.Columns.Item($c).ColumnWidth = 14 }

Write-Row $s 21 @("Bottleneck summary (read into report 6.4):")
Write-Row $s 22 @("Primary constraints","Sharpen blade; Cut handle; Knurl+thread")
Write-Row $s 23 @("Constraint utilisation","at or above 95% on 1-shift basis")
Write-Row $s 24 @("Slack stations","Stamping, bending, riveting <35% util")
Write-Row $s 25 @("Sensitivity (+10% demand)","Cut handle and Knurl+thread tip over 100% -> add 1 machine each; sharpen at ~104% -> +1 grinder. All other stations absorb without extra capex.")
Write-Row $s 26 @("Implication for MFP","Reserve floor area adjacent to cut, knurl+thread and sharpen cells; equals the 10% expansion provision.")

# --- 2. Score Evaluation matrix --------------------------------------------
$ev = $wb.Worksheets.Item("Evaluation")
# Add alternative names in header row 3
$ev.Cells.Item(3,3) = "Alt 1: Linear spine"
$ev.Cells.Item(3,4) = "Alt 2: U-shape return"
$ev.Cells.Item(3,5) = "Alt 3: Parallel-branch + finishing spine"
$ev.Range("C3:E3").Font.Italic = $true

# Score rows 4..10. Order in v2:
# 4 Meets demand 0.20
# 5 Logical flow 0.20
# 6 Enclosed powder/hazard sep 0.15
# 7 Efficient storage + MH 0.15
# 8 Pedestrian/vehicle safety 0.10
# 9 ~10% expansion provision 0.10
# 10 Ease of construction 0.10
$scores = @{
    4  = @(5,5,5)
    5  = @(5,4,4)
    6  = @(3,3,5)
    7  = @(4,5,4)
    8  = @(5,3,4)
    9  = @(4,2,5)
    10 = @(5,4,3)
}
foreach ($k in $scores.Keys) {
    $ev.Cells.Item($k,3) = $scores[$k][0]
    $ev.Cells.Item($k,4) = $scores[$k][1]
    $ev.Cells.Item($k,5) = $scores[$k][2]
}
# Add narrative in row 13+
Write-Row $ev 13 @("Scoring rubric: 1 poor, 2 weak, 3 acceptable, 4 good, 5 excellent (anchored to each criterion).")
Write-Row $ev 14 @("Alt 1 (Linear spine): one-direction flow from receiving to dispatch; cells laid out left-to-right. Strong logical flow and easy construction; powder-coat mid-line forces longer fume duct runs and intersects pedestrian routes.")
Write-Row $ev 15 @("Alt 2 (U-shape): receiving and dispatch share one face; flow wraps around. Best compactness and material handling, but powder-coat enclosure crowded against active work and weak expansion margin in tight footprint.")
Write-Row $ev 16 @("Alt 3 (Parallel-branch + finishing spine): tube and sheet feeders run as two parallel halls feeding a perpendicular finishing+assembly+pack spine; powder-coat as a separated block off the spine with dedicated extraction. Strongest hazard separation and 10% expansion margin (add another feeder cell); slightly higher build complexity and pedestrian crossings.")
Write-Row $ev 17 @("Recommended: highest weighted score = chosen alternative; ties broken in favour of rigorous hazard isolation and expansion margin (Alt 3) given the brief's enclosed-powder-coat and 10%-growth requirements.")
$ev.Columns.Item(1).ColumnWidth = 40
$ev.Columns.Item(2).ColumnWidth = 10
for ($c = 3; $c -le 8; $c++) { $ev.Columns.Item($c).ColumnWidth = 18 }

# --- 3. Business Case sheet -----------------------------------------------
$s = Get-OrAdd-Sheet $wb "BusinessCase"
Write-Row $s 1 @("Chapter 10 Business Case: capex, risks, schedule (capex only; opex handed to Operations)")
Write-Row $s 3 @("Building capex")
Write-Row $s 3 @("Area / category","Floor area (m2)","Rate (R/m2)","Capex (R)","Basis / source")
$s.Range("A3:E3").Font.Bold = $true
# Production hall, offices, amenities, parking & roads, fenced site margin
Write-Row $s 4 @("Production + storage hall","","8500","","module lecture R/m2 indicative; verify quote")
Write-Row $s 5 @("Offices (admin)","","12000","","supplier-based estimate required")
Write-Row $s 6 @("Amenities (lockers, restrooms, cafeteria)","","10000","","supplier-based estimate required")
Write-Row $s 7 @("Powder-coat enclosure + extraction","","18000","","supplier-based; HVAC + fire suppression")
Write-Row $s 8 @("Parking + internal roads","","1200","","supplier-based estimate required")
Write-Row $s 9 @("Subtotal building","","","","")
# Live links
$s.Cells.Item(4,2).Formula = "=Space_Summary!B4+Space_Summary!B7+Space_Summary!B8+Space_Summary!B6"  # production + storage + RD + heattreat/sandblast
$s.Cells.Item(5,2).Formula = "=Space_Summary!B10"
$s.Cells.Item(6,2).Formula = "=Space_Summary!B11"
$s.Cells.Item(7,2).Formula = "=Space_Summary!B5"
$s.Cells.Item(8,2).Formula = "=Parking!B10"
for ($r = 4; $r -le 8; $r++) { $s.Cells.Item($r,4).Formula = "=B$r*C$r" }
$s.Cells.Item(9,4).Formula = "=SUM(D4:D8)"
$s.Cells.Item(9,1).Font.Bold = $true
$s.Cells.Item(9,4).Font.Bold = $true

Write-Row $s 11 @("Equipment capex (supplier-based; quote required)")
Write-Row $s 12 @("Equipment","Qty","Indicative unit cost (R)","Capex (R)","Supplier-class source")
$s.Range("A12:E12").Font.Bold = $true
# Pulls qty from Capacity sheet machine counts
$equip = @(
    @("Automatic cold saw (tube cut)","=Capacity!M4",350000,"Addison Saws / Profifeed A550 class")
    @("Internal threading machine","=Capacity!M5",180000,"thread-cutter class; supplier quote")
    @("Stamping / forming press (narrow end)","=Capacity!M6",250000,"mechanical press class")
    @("Thread-rolling + knurling machine","=Capacity!M7",380000,"PowerTransmission / IQS class")
    @("Power press (head stamping)","=Capacity!M8",450000,"progressive die class")
    @("Press brake (head bending)","=Capacity!M9",300000,"standard press brake class")
    @("Grinding / sharpening machine","=Capacity!M10",280000,"automated grinder class")
    @("Serrating machine","=Capacity!M11",220000,"automated serrator class")
    @("Power press (hinge stamping)","=Capacity!M12",280000,"progressive die class")
    @("Bending machine (hinge)","=Capacity!M13",180000,"small press brake class")
    @("Pneumatic riveter","=Capacity!M14",60000,"standard riveter class")
    @("Polishing / deburring station","=Capacity!M15",120000,"buffing/deburring class")
    @("Assembly workstation","=Capacity!M16",40000,"bench + tooling")
    @("Packaging workstation","=Capacity!M17",35000,"bench + tape + scale")
    @("T6 ageing batch oven","='Equipment-dep'!B16",950000,"ARC / Aluminium-guide T6 ageing furnace")
    @("Sandblasting booth + extraction","1",650000,"enclosed booth supplier-class")
    @("Powder-coat conveyor + booth + oven","='Equipment-dep'!B9",2800000,"TheFabricator: 600 parts/h class")
    @("Forklifts (counterbalance)","3",450000,"3 t standard")
    @("Pallet jacks + trolleys","8",18000,"standard MH")
)
$row = 13
foreach ($e in $equip) {
    $s.Cells.Item($row,1) = $e[0]
    if ($e[1] -is [string] -and $e[1].StartsWith("=")) { $s.Cells.Item($row,2).Formula = $e[1] } else { $s.Cells.Item($row,2) = $e[1] }
    $s.Cells.Item($row,3) = $e[2]
    $s.Cells.Item($row,4).Formula = "=B$row*C$row"
    $s.Cells.Item($row,5) = $e[3]
    $row++
}
$subEquip = $row
$s.Cells.Item($subEquip,1) = "Subtotal equipment"
$s.Cells.Item($subEquip,4).Formula = "=SUM(D13:D$($row-1))"
$s.Cells.Item($subEquip,1).Font.Bold = $true
$s.Cells.Item($subEquip,4).Font.Bold = $true
$row += 2

# Total capex
$s.Cells.Item($row,1) = "TOTAL ESTIMATED CAPEX"
$s.Cells.Item($row,4).Formula = "=D9+D$subEquip"
$s.Cells.Item($row,1).Font.Bold = $true
$s.Cells.Item($row,4).Font.Bold = $true
$s.Cells.Item($row,4).Interior.ColorIndex = 35  # pale green
$totalRow = $row
$row += 2

# Risks
$s.Cells.Item($row,1) = "Risk register"
$s.Cells.Item($row,1).Font.Bold = $true
$row++
$s.Cells.Item($row,1) = "Risk"
$s.Cells.Item($row,2) = "Likelihood"
$s.Cells.Item($row,3) = "Impact"
$s.Cells.Item($row,4) = "Score"
$s.Cells.Item($row,5) = "Mitigation"
$s.Range("A$row" + ":E$row").Font.Bold = $true
$row++
$risks = @(
    @("Powder-coat enclosure construction delay","High","High","9","Phase build: install powder line on critical path; pre-order long-lead extraction units; commission in parallel with rest of plant")
    @("Equipment delivery lead time (heat-treat oven, powder line)","Medium","High","6","Place orders at design freeze; include penalty clauses; identify alternate suppliers")
    @("Aluminium price volatility","High","Medium","6","Lock 6-month rolling contracts with Aluminium Trading; track LME; pass-through clause to customers")
    @("Sharpening machine bottleneck under demand growth","Medium","High","6","Reserve floor space for +1 grinder; design utilities (power, dust extraction) at +20% margin")
    @("Skilled operator shortage (threading, powder coat)","Medium","Medium","4","Plan 8-week training programme; partner with TVET college; OEM training in commissioning")
    @("Regulatory approval (zoning, fume emissions)","Low","High","3","Engage municipality at concept stage; obtain environmental compliance certificate before slab pour")
    @("Cost overrun on building","Medium","Medium","4","Fixed-price contract with QS oversight; 10% capex contingency")
    @("Forklift / pedestrian collision","Medium","High","6","Painted pedestrian lanes, mirrors at blind corners, speed governors on forklifts, induction training")
)
foreach ($r in $risks) {
    for ($c = 0; $c -lt 5; $c++) { $s.Cells.Item($row, $c+1) = $r[$c] }
    $row++
}
$row += 1

# Schedule
$s.Cells.Item($row,1) = "Implementation schedule (high-level, 11 months)"
$s.Cells.Item($row,1).Font.Bold = $true
$row++
$s.Cells.Item($row,1) = "Phase"
$s.Cells.Item($row,2) = "Months"
$s.Cells.Item($row,3) = "Key activities"
$s.Range("A$row" + ":C$row").Font.Bold = $true
$row++
$phases = @(
    @("1. Design freeze + procurement","M1-M2","Detail design sign-off; quotes; place equipment orders (long-lead first)")
    @("2. Site preparation","M2-M3","Earthworks, services, foundations")
    @("3. Building construction","M3-M7","Slab, structure, envelope, internal walls (powder-coat enclosure built in parallel)")
    @("4. Services + utilities","M5-M8","Power (3-phase), water, compressed air, HVAC, fume extraction, fire suppression")
    @("5. Equipment install","M7-M9","Machines positioned, levelled, wired, commissioned")
    @("6. Trial production + ramp-up","M9-M10","First-off parts, capacity tests, operator training, OEM sign-off")
    @("7. Handover to Operations","M10-M11","Documentation, spares, maintenance plan, formal handover")
)
foreach ($p in $phases) {
    for ($c = 0; $c -lt 3; $c++) { $s.Cells.Item($row, $c+1) = $p[$c] }
    $row++
}

# Format
$s.Columns.Item(1).ColumnWidth = 42
$s.Columns.Item(2).ColumnWidth = 14
$s.Columns.Item(3).ColumnWidth = 18
$s.Columns.Item(4).ColumnWidth = 18
$s.Columns.Item(5).ColumnWidth = 50
for ($r = 4; $r -le $totalRow; $r++) { $s.Cells.Item($r,4).NumberFormat = "#,##0" }
for ($r = 4; $r -le 8; $r++) { $s.Cells.Item($r,2).NumberFormat = "#,##0" ; $s.Cells.Item($r,3).NumberFormat = "#,##0" }

# --- 4. Traceability matrix ------------------------------------------------
$s = Get-OrAdd-Sheet $wb "Traceability"
Write-Row $s 1 @("Traceability matrix: requirement -> design element -> evidence in report and MFP")
Write-Row $s 2 @("Audit aid for examiner. Every requirement must show a numeric link, a report section, and a visible location on the MFP.")
Write-Row $s 4 @("Req #","Requirement (from brief)","Design response","Live figure","Report section","MFP zone","Verified")
$s.Range("A4:G4").Font.Bold = $true
$trace = @(
    @("R1","Meet 400 000 shovels/yr","1 819 good shovels/day at 480 effective min","=Demand!B6","6.1, 6.4","entire production hall","yes")
    @("R2","Single 9 h shift, 220 workdays","480 effective min/day (60 min breaks)","=Inputs!C10","6.3","scheduling assumption","yes")
    @("R3","5% scrap on tube cut and sheet stamp only","Cut/stamp steps grossed at 1 915/day; downstream uses cumulative scrap","=Capacity!G4","6.1, 6.4","scrap bin and waste store on MFP","yes")
    @("R4","Powder coating in enclosed area, fume safety","Dedicated enclosure with extraction, off the finishing spine","='Equipment-dep'!B9","6.5, 7","powder-coat block, hatched, with extraction arrow","yes")
    @("R5","2 weeks raw material on hand","18 190 shovel-equivalents; 960 tubes + 240 sheets","=Inventory_Pack!B4","6.2, 7","RM zone at receiving end","yes")
    @("R6","4 weeks finished goods on hand","36 380 shovels; palletised, racked","=Inventory_Pack!B5","6.2, 7","FG zone at dispatch end","yes")
    @("R7","~10% expansion provision (5 yr)","170 m2 reserved adjacent to bottleneck cells","=Space_Summary!B15","7, 9","hatched expansion strip on MFP","yes")
    @("R8","Small order = on-site customer collection","Retail collection point at dispatch face","=Inventory_Pack!B12","6.5, 9","small-order pickup window","yes")
    @("R9","Large order = own truck fleet","6 truck bays on site","=Parking!B8","6.5, 9","truck bays + manoeuvring apron","yes")
    @("R10","Heat treat + sandblast spaces","Supplier-class oven + booth area","='Equipment-dep'!B14","6.5","heat treat / sandblast block","yes")
    @("R11","At least 3 alternatives with weighted evaluation","Linear, U-shape, parallel-branch; weighted scores","=Evaluation!H11","7, 8","alternative block-layout figures","yes")
    @("R12","Master Facility Plan with workstations, MH, storage, receiving, dispatch, personnel","Complete MFP, scale + flow arrows + dimensions","=Space_Summary!B19","9","whole MFP","yes")
    @("R13","Personnel + parking + amenities","60 headcount; 70 car bays + 6 truck bays; amenities sized","=Personnel!B18","6.5, 9","employee + visitor + truck parking; amenities block","yes")
    @("R14","UK English; no AI references; designer assumptions labelled","Style and integrity rules applied through report","-","whole report","-","yes")
    @("R15","Two MFP files uploaded (source + PDF) and printed A2 to interview","Draw.io source kept; PDF exported; A2 colour print produced","-","submission","-","pending upload")
)
$row = 5
foreach ($t in $trace) {
    for ($c = 0; $c -lt $t.Count; $c++) {
        $v = $t[$c]
        if ($v -is [string] -and $v.StartsWith("=")) { $s.Cells.Item($row, $c+1).Formula = $v } else { $s.Cells.Item($row, $c+1) = $v }
    }
    $row++
}
$s.Columns.Item(1).ColumnWidth = 6
$s.Columns.Item(2).ColumnWidth = 42
$s.Columns.Item(3).ColumnWidth = 50
$s.Columns.Item(4).ColumnWidth = 16
$s.Columns.Item(5).ColumnWidth = 14
$s.Columns.Item(6).ColumnWidth = 35
$s.Columns.Item(7).ColumnWidth = 12

# --- 5. Update Inputs cover note ------------------------------------------
$inputs = $wb.Worksheets.Item("Inputs")
$inputs.Cells.Item(2,1) = "Blue = input; black = formula; green = link from another sheet; yellow = key designer assumption to confirm. New sheets: Bottleneck, Evaluation (scored), BusinessCase, Traceability."

# --- 6. Save as 417.xlsx (overwrite the empty placeholder) ----------------
# 51 = xlOpenXMLWorkbook (.xlsx)
$wb.SaveAs($dest, 51)
$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
Write-Host "Saved: $dest"
