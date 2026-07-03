# Patch: fix BusinessCase production-hall area and rebuild Traceability
$ErrorActionPreference = 'Stop'
$path = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.1_Capacity_Model\417.xlsx"

$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open($path)

# --- Fix BusinessCase building areas -------------------------------------
$bc = $wb.Worksheets.Item("BusinessCase")
# Production + storage hall = building total - offices - amenities - powder-coat (which is listed separately)
$bc.Cells.Item(4,2).Formula = "=Space_Summary!B14-Space_Summary!B10-Space_Summary!B11-Space_Summary!B5"
# Offices
$bc.Cells.Item(5,2).Formula = "=Space_Summary!B10"
# Amenities
$bc.Cells.Item(6,2).Formula = "=Space_Summary!B11"
# Powder-coat enclosure
$bc.Cells.Item(7,2).Formula = "=Space_Summary!B5"
# Parking
$bc.Cells.Item(8,2).Formula = "=Parking!B10"

# --- Rebuild Traceability sheet -----------------------------------------
$t = $wb.Worksheets.Item("Traceability")
$t.Cells.Clear() | Out-Null

$t.Cells.Item(1,1) = "Traceability matrix: requirement -> design element -> evidence in report and MFP"
$t.Cells.Item(2,1) = "Audit aid for examiner. Every requirement must show a numeric link, a report section, and a visible MFP location."
$hdr = @("Req #","Requirement (from brief)","Design response","Live figure","Report section","MFP zone","Verified")
for ($c = 0; $c -lt $hdr.Count; $c++) { $t.Cells.Item(4, $c+1) = $hdr[$c] }
$t.Range("A4:G4").Font.Bold = $true

# Write rows one at a time, explicitly
function Write-TraceRow($t, $row, $reqNo, $req, $design, $figure, $section, $zone, $verified) {
    $t.Cells.Item($row, 1) = $reqNo
    $t.Cells.Item($row, 2) = $req
    $t.Cells.Item($row, 3) = $design
    if ($figure.StartsWith("=")) { $t.Cells.Item($row, 4).Formula = $figure } else { $t.Cells.Item($row, 4) = $figure }
    $t.Cells.Item($row, 5) = $section
    $t.Cells.Item($row, 6) = $zone
    $t.Cells.Item($row, 7) = $verified
}

Write-TraceRow $t  5 "R1"  "Meet 400 000 shovels/yr"                          "1 819 good shovels/day at 480 effective min"               "=Demand!B6"                "6.1, 6.4"     "entire production hall"                                "yes"
Write-TraceRow $t  6 "R2"  "Single 9 h shift, 220 workdays"                   "480 effective min/day (60 min breaks)"                     "=Inputs!C10"               "6.3"          "scheduling assumption"                                  "yes"
Write-TraceRow $t  7 "R3"  "5% scrap on tube cut and sheet stamp only"        "Cut/stamp grossed at 1 915/day; downstream cumulative"     "=Capacity!G4"              "6.1, 6.4"     "scrap bin and waste store on MFP"                       "yes"
Write-TraceRow $t  8 "R4"  "Powder coating in enclosed area"                  "Dedicated enclosure with extraction, off finishing spine"  "=Space_Summary!B5"         "6.5, 7"       "powder-coat block, hatched, with extraction arrow"      "yes"
Write-TraceRow $t  9 "R5"  "2 weeks raw material on hand"                     "18 190 shovel-equivalents; tube + sheet"                   "=Inventory_Pack!B4"        "6.2, 7"       "RM zone at receiving end"                               "yes"
Write-TraceRow $t 10 "R6"  "4 weeks finished goods on hand"                   "36 380 shovels; palletised, racked"                        "=Inventory_Pack!B5"        "6.2, 7"       "FG zone at dispatch end"                                "yes"
Write-TraceRow $t 11 "R7"  "~10% expansion provision (5 yr)"                  "170 m2 reserved adjacent to bottleneck cells"              "=Space_Summary!B15"        "7, 9"         "hatched expansion strip on MFP"                         "yes"
Write-TraceRow $t 12 "R8"  "Small order = on-site customer collection"        "Retail collection point at dispatch face"                  "=Personnel!B17"            "6.5, 9"       "small-order pickup window"                              "yes"
Write-TraceRow $t 13 "R9"  "Large order = own truck fleet"                    "6 truck bays on site"                                      "=Parking!B8"               "6.5, 9"       "truck bays + manoeuvring apron"                         "yes"
Write-TraceRow $t 14 "R10" "Heat treat + sandblast spaces"                    "Supplier-class oven + booth area"                          "=Space_Summary!B6"         "6.5"          "heat treat / sandblast block"                           "yes"
Write-TraceRow $t 15 "R11" "At least 3 alternatives, weighted evaluation"     "Linear, U-shape, parallel-branch; weighted scores"         "=Evaluation!F11"           "7, 8"         "alternative block-layout figures"                       "yes"
Write-TraceRow $t 16 "R12" "MFP with workstations, MH, storage, R&D, personnel" "Complete MFP, scaled, with flow arrows + dimensions"     "=Space_Summary!B16"        "9"            "whole MFP"                                              "yes"
Write-TraceRow $t 17 "R13" "Personnel + parking + amenities"                  "60 headcount; 70 car bays + 6 truck bays; amenities sized" "=Personnel!B18"            "6.5, 9"       "employee + visitor + truck parking; amenities block"    "yes"
Write-TraceRow $t 18 "R14" "UK English; no AI references; assumptions labelled" "Style and integrity rules applied through report"        "-"                         "whole report" "-"                                                       "yes"
Write-TraceRow $t 19 "R15" "Two MFP files uploaded (drawio source + PDF)"     "Draw.io source kept; PDF exported; A2 colour print"        "-"                         "submission"   "-"                                                       "pending upload"

# Column widths
$t.Columns.Item(1).ColumnWidth = 6
$t.Columns.Item(2).ColumnWidth = 42
$t.Columns.Item(3).ColumnWidth = 50
$t.Columns.Item(4).ColumnWidth = 16
$t.Columns.Item(5).ColumnWidth = 14
$t.Columns.Item(6).ColumnWidth = 38
$t.Columns.Item(7).ColumnWidth = 14
$t.Rows.Item("1:19").WrapText = $true

$wb.Save() | Out-Null
$wb.Close($false) | Out-Null
$xl.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
Write-Host "Patched."
