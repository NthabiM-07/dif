# Generate DigMore_MFP.drawio with 4 pages:
#  1. ARC (Activity Relationship Chart)
#  2. Alternatives summary (3 block layouts side-by-side)
#  3. Alternative 1 detail (Linear spine - selected)
#  4. Final MFP (selected layout, scaled, dimensioned)
#
# All dimensions and quantities are from 417.xlsx; integrity rules per CLAUDE.md.

$ErrorActionPreference = 'Stop'
$out = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP.drawio"

# --- Style palette (Drawio standard tile colours) ---
$styleProd     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#DAE8FC;strokeColor=#6C8EBF;strokeWidth=1;fontSize=11;"
$styleProdBig  = "rounded=0;whiteSpace=wrap;html=1;fillColor=#DAE8FC;strokeColor=#6C8EBF;strokeWidth=2;fontSize=13;fontStyle=1;"
$styleStor     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFE6CC;strokeColor=#D79B00;strokeWidth=1;fontSize=11;"
$styleHaz      = "rounded=0;whiteSpace=wrap;html=1;fillColor=#F8CECC;strokeColor=#B85450;strokeWidth=2;fontSize=12;fontStyle=1;fillStyle=hatch;"
$styleSupp     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#D5E8D4;strokeColor=#82B366;strokeWidth=1;fontSize=11;"
$styleDock     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFF2CC;strokeColor=#D6B656;strokeWidth=1;fontSize=11;"
$styleExp      = "rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;strokeWidth=2;dashed=1;fontSize=11;fontStyle=2;"
$styleSite     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#F0F8E8;strokeColor=#82B366;strokeWidth=2;fillStyle=cross-hatch;fontSize=10;"
$styleBldg     = "rounded=0;whiteSpace=wrap;html=1;fillColor=none;strokeColor=#000000;strokeWidth=3;fontSize=12;"
$styleTitle    = "text;html=1;align=center;verticalAlign=middle;fontSize=20;fontStyle=1;"
$styleLabel    = "text;html=1;align=left;verticalAlign=middle;fontSize=11;"
$styleArrow    = "endArrow=classic;html=1;rounded=0;strokeColor=#0066CC;strokeWidth=3;exitX=1;exitY=0.5;entryX=0;entryY=0.5;"
$styleArrowR   = "endArrow=classic;html=1;rounded=0;strokeColor=#CC0000;strokeWidth=2;"   # rework / hazard
$stylePedestr  = "endArrow=none;html=1;rounded=0;strokeColor=#009900;strokeWidth=2;dashed=1;"
$styleLegend   = "rounded=0;whiteSpace=wrap;html=1;fillColor=none;strokeColor=#666666;strokeWidth=1;fontSize=10;align=left;verticalAlign=top;"
$styleARCcell  = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#333333;fontSize=11;fontStyle=1;"
$styleARChead  = "rounded=0;whiteSpace=wrap;html=1;fillColor=#333333;strokeColor=#333333;fontSize=11;fontColor=#FFFFFF;fontStyle=1;"

# --- Helpers ---
$cellId = 1000
function NextId { $script:cellId++; return "c$script:cellId" }
function XmlEsc([string]$s) {
    if ($null -eq $s) { return "" }
    return $s.Replace('&','&amp;').Replace('<','&lt;').Replace('>','&gt;').Replace('"','&quot;')
}
function Cell([string]$style, [string]$value, [int]$x, [int]$y, [int]$w, [int]$h) {
    $id = NextId
    $v = XmlEsc $value
    return '        <mxCell id="' + $id + '" value="' + $v + '" style="' + $style + '" vertex="1" parent="1"><mxGeometry x="' + $x + '" y="' + $y + '" width="' + $w + '" height="' + $h + '" as="geometry" /></mxCell>'
}
function Edge([string]$style, [int]$x1, [int]$y1, [int]$x2, [int]$y2, [string]$label) {
    $id = NextId
    $v = XmlEsc $label
    return '        <mxCell id="' + $id + '" value="' + $v + '" style="' + $style + '" edge="1" parent="1"><mxGeometry relative="1" as="geometry"><mxPoint x="' + $x1 + '" y="' + $y1 + '" as="sourcePoint" /><mxPoint x="' + $x2 + '" y="' + $y2 + '" as="targetPoint" /></mxGeometry></mxCell>'
}
function Page([string]$id, [string]$name, [int]$w, [int]$h, [string]$body) {
    return '  <diagram id="' + $id + '" name="' + $name + '">' + "`r`n" +
           '    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="' + $w + '" pageHeight="' + $h + '" math="0" shadow="0">' + "`r`n" +
           '      <root>' + "`r`n" +
           '        <mxCell id="0" />' + "`r`n" +
           '        <mxCell id="1" parent="0" />' + "`r`n" +
           $body + "`r`n" +
           '      </root>' + "`r`n" +
           '    </mxGraphModel>' + "`r`n" +
           '  </diagram>'
}

# ============================================================
# PAGE 1: Activity Relationship Chart (ARC)
# ============================================================
$arcRows = @(
    "Receiving","Raw stores","Tube fabrication","Sheet fabrication",
    "Head finishing spine","Heat treat + sandblast","Powder coat (enclosed)",
    "Final assembly","Packaging","Finished goods","Dispatch",
    "Offices","Amenities","Parking"
)
# Symmetric upper-triangle codes: row x col
# Codes: A=red, E=orange, I=yellow, O=blue, U=white, X=black
$arcCodes = @{
    "0,1"="A"; "0,2"="E"; "0,3"="E"; "0,4"="U"; "0,5"="U"; "0,6"="U"; "0,7"="U"; "0,8"="U"; "0,9"="U"; "0,10"="O"; "0,11"="O"; "0,12"="U"; "0,13"="O";
    "1,2"="A"; "1,3"="A"; "1,4"="O"; "1,5"="O"; "1,6"="O"; "1,7"="U"; "1,8"="U"; "1,9"="U"; "1,10"="U"; "1,11"="U"; "1,12"="U"; "1,13"="U";
    "2,3"="I"; "2,4"="E"; "2,5"="O"; "2,6"="A"; "2,7"="I"; "2,8"="O"; "2,9"="U"; "2,10"="U"; "2,11"="U"; "2,12"="U"; "2,13"="U";
    "3,4"="A"; "3,5"="E"; "3,6"="E"; "3,7"="I"; "3,8"="O"; "3,9"="U"; "3,10"="U"; "3,11"="U"; "3,12"="U"; "3,13"="U";
    "4,5"="A"; "4,6"="A"; "4,7"="I"; "4,8"="O"; "4,9"="U"; "4,10"="U"; "4,11"="U"; "4,12"="U"; "4,13"="U";
    "5,6"="A"; "5,7"="I"; "5,8"="O"; "5,9"="U"; "5,10"="U"; "5,11"="X"; "5,12"="X"; "5,13"="U";
    "6,7"="A"; "6,8"="I"; "6,9"="O"; "6,10"="O"; "6,11"="X"; "6,12"="X"; "6,13"="U";
    "7,8"="A"; "7,9"="E"; "7,10"="O"; "7,11"="U"; "7,12"="O"; "7,13"="U";
    "8,9"="A"; "8,10"="E"; "8,11"="U"; "8,12"="O"; "8,13"="U";
    "9,10"="A"; "9,11"="U"; "9,12"="U"; "9,13"="U";
    "10,11"="E"; "10,12"="U"; "10,13"="A";
    "11,12"="E"; "11,13"="A";
    "12,13"="E"
}
$arcColor = @{ "A"="#E51400"; "E"="#FA6800"; "I"="#FFC700"; "O"="#60A917"; "U"="#FFFFFF"; "X"="#000000" }
$arcFont  = @{ "A"="#FFFFFF"; "E"="#FFFFFF"; "I"="#000000"; "O"="#FFFFFF"; "U"="#999999"; "X"="#FFFFFF" }

$body = ""
$body += Cell $styleTitle "Activity Relationship Chart - DigMore Folding Mini Shovel Facility" 200 30 1200 40
$body += "`r`n"

# Row labels (left column), 14 rows, each 40 high, starting y=120
$rowH = 38
$rowLabelW = 220
$colW = 70
$startX = 280
$startY = 120

# Row labels
for ($i = 0; $i -lt $arcRows.Count; $i++) {
    $y = $startY + $i * $rowH
    $body += Cell $styleARChead $arcRows[$i] 50 $y $rowLabelW $rowH
    $body += "`r`n"
}

# Codes matrix (upper triangle staircase from row 0 column 0)
for ($i = 0; $i -lt ($arcRows.Count - 1); $i++) {
    for ($j = $i + 1; $j -lt $arcRows.Count; $j++) {
        $key = "" + $i + "," + $j
        $code = $arcCodes[$key]
        if (-not $code) { $code = "U" }
        $col = $j - $i - 1
        $x = $startX + $col * $colW
        $y = $startY + $i * $rowH + ($j - $i - 1) * 0
        # Place along a diagonal stair: each row i, column for relation with j is offset
        # We use a parallelogram: row i has $arcRows.Count - 1 - i cells; cell c shows relation with row i+1+c
        # x position = startX + c * colW; y = startY + i * rowH + (i+1+c -i-1)*0  -- but to keep a triangle, offset y by i*rowH/2
        # For readability we'll arrange as a strict upper-triangle table where col header is the destination row label vertical
        $x = $startX + ($j - 1) * $colW
        $y = $startY + $i * $rowH
        $styleC = "rounded=0;whiteSpace=wrap;html=1;fillColor=" + $arcColor[$code] + ";strokeColor=#333333;fontSize=12;fontStyle=1;fontColor=" + $arcFont[$code] + ";"
        $body += Cell $styleC $code $x $y $colW $rowH
        $body += "`r`n"
    }
}

# Column headers (rotated short labels) along the top of columns 1..13
for ($j = 1; $j -lt $arcRows.Count; $j++) {
    $x = $startX + ($j - 1) * $colW
    $y = $startY - 110
    $shortLbl = $arcRows[$j]
    $styleH = "text;html=1;align=center;verticalAlign=bottom;fontSize=10;fontStyle=1;rotation=-60;"
    $body += Cell $styleH $shortLbl $x $y $colW 100
    $body += "`r`n"
}

# Legend
$lx = 50; $ly = 720
$body += Cell $styleTitle "Legend (closeness rating)" $lx $ly 400 30
$body += "`r`n"
$codes = @("A","E","I","O","U","X")
$desc  = @("Absolutely necessary","Especially important","Important","Ordinary","Unimportant","Must be separated")
for ($k = 0; $k -lt 6; $k++) {
    $y = $ly + 40 + $k * 36
    $styleC = "rounded=0;whiteSpace=wrap;html=1;fillColor=" + $arcColor[$codes[$k]] + ";strokeColor=#333333;fontSize=14;fontStyle=1;fontColor=" + $arcFont[$codes[$k]] + ";"
    $body += Cell $styleC $codes[$k] $lx $y 40 30
    $body += "`r`n"
    $body += Cell $styleLabel $desc[$k] ($lx + 50) $y 300 30
    $body += "`r`n"
}

# Reasoning note
$reason = "Reasoning codes drawn from process flow (Ch 6.3), material handling routes (Ch 6.5 to 6.6) and hazard isolation (powder coat enclosure). Source: 417.xlsx + Sections_5_to_10_DRAFT.md Ch 7.1."
$body += Cell $styleLegend $reason 500 720 900 100
$body += "`r`n"

$page1 = Page "arc01" "ARC" 1684 1191 $body

# ============================================================
# PAGE 2: Alternatives summary (3 block layouts side-by-side)
# ============================================================
$body = ""
$body += Cell $styleTitle "Layout Alternatives - Block Diagrams" 200 30 1280 40
$body += "`r`n"

# Building outline reference: 60 m x 32 m at 5 px/m = 300 x 160 px per alternative
$altW = 360
$altH = 200
$gap = 60
$xs = @(60, (60 + $altW + $gap), (60 + 2*($altW + $gap)))
$names = @("Alt 1 - Linear spine (selected, 4.45)", "Alt 2 - U-shape (3.90)", "Alt 3 - Parallel-branch T (4.35)")

for ($a = 0; $a -lt 3; $a++) {
    $x0 = $xs[$a]
    $y0 = 130
    $body += Cell ($styleTitle.Replace("fontSize=20","fontSize=14")) $names[$a] $x0 $y0 $altW 30
    $body += "`r`n"
    $bx = $x0
    $by = $y0 + 40
    $body += Cell $styleBldg "" $bx $by $altW $altH
    $body += "`r`n"
    if ($a -eq 0) {
        # Linear spine: west-east strip
        $w = [int]($altW/8)
        $body += Cell $styleDock "Recv" $bx ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleStor "RM" ($bx+$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleProd "Fab" ($bx+2*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleProd "Finish" ($bx+3*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleHaz "Coat" ($bx+4*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleProd "Asm+Pk" ($bx+5*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleStor "FG" ($bx+6*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleDock "Disp" ($bx+7*$w) ($by+50) $w ($altH-100)
        $body += "`r`n"
        $body += Cell $styleSupp "Offices + amenities (N face)" $bx ($by+5) $altW 40
        $body += "`r`n"
        $body += Cell $styleExp "Expansion (S, adj. bottleneck)" $bx ($by+$altH-45) $altW 40
        $body += "`r`n"
    } elseif ($a -eq 1) {
        # U-shape: receiving + dispatch on same face (top); U goes around
        $w = [int]($altW/3)
        $body += Cell $styleDock "Recv" $bx ($by+5) $w 35
        $body += "`r`n"
        $body += Cell $styleSupp "Service core" ($bx+$w) ($by+5) $w 35
        $body += "`r`n"
        $body += Cell $styleDock "Disp" ($bx+2*$w) ($by+5) $w 35
        $body += "`r`n"
        $body += Cell $styleStor "RM" $bx ($by+45) $w 50
        $body += "`r`n"
        $body += Cell $styleStor "FG" ($bx+2*$w) ($by+45) $w 50
        $body += "`r`n"
        $body += Cell $styleProd "Sheet fab" $bx ($by+95) $w 50
        $body += "`r`n"
        $body += Cell $styleProd "Asm + Pack" ($bx+$w) ($by+95) $w 50
        $body += "`r`n"
        $body += Cell $styleProd "Tube fab" ($bx+2*$w) ($by+95) $w 50
        $body += "`r`n"
        $body += Cell $styleHaz "Powder coat (central, constrained)" $bx ($by+145) $altW 50
        $body += "`r`n"
    } else {
        # Parallel-branch T: two halls feed perpendicular finishing spine; powder coat annexe
        $w = [int]($altW/2)
        $body += Cell $styleDock "Receiving (N face)" $bx ($by+5) $altW 30
        $body += "`r`n"
        $body += Cell $styleStor "RM tube" $bx ($by+35) $w 30
        $body += "`r`n"
        $body += Cell $styleStor "RM sheet" ($bx+$w) ($by+35) $w 30
        $body += "`r`n"
        $body += Cell $styleProd "Tube fab hall" $bx ($by+65) $w 60
        $body += "`r`n"
        $body += Cell $styleProd "Sheet fab hall" ($bx+$w) ($by+65) $w 60
        $body += "`r`n"
        $body += Cell $styleProd "Finishing spine (sharpen + serrate + polish) E-W" $bx ($by+125) $altW 30
        $body += "`r`n"
        $body += Cell $styleProd "Asm + Pack" $bx ($by+155) $w 30
        $body += "`r`n"
        $body += Cell $styleStor "FG + Disp" ($bx+$w) ($by+155) $w 30
        $body += "`r`n"
        # Annexe
        $body += Cell $styleHaz "Powder coat (annexe)" ($bx+$altW+5) ($by+125) 80 60
        $body += "`r`n"
    }
}

# Scoring summary table at bottom
$ty = 420
$body += Cell $styleTitle "Weighted evaluation (from Evaluation sheet of 417.xlsx)" 60 $ty 1280 30
$body += "`r`n"
$cw = 220
$th = 32
$headerY = $ty + 50
$body += Cell $styleARChead "Criterion" 60 $headerY $cw $th
$body += "`r`n"
$body += Cell $styleARChead "Weight" (60+$cw) $headerY 80 $th
$body += "`r`n"
$body += Cell $styleARChead "Alt 1" (60+$cw+80) $headerY 100 $th
$body += "`r`n"
$body += Cell $styleARChead "Alt 2" (60+$cw+180) $headerY 100 $th
$body += "`r`n"
$body += Cell $styleARChead "Alt 3" (60+$cw+280) $headerY 100 $th
$body += "`r`n"
$crit = @(
    @("Meets demand 400 000/yr", "0.20", "5", "5", "5"),
    @("Logical material flow", "0.20", "5", "4", "4"),
    @("Powder coat hazard separation", "0.15", "3", "3", "5"),
    @("Storage and material handling", "0.15", "4", "5", "4"),
    @("Pedestrian / vehicle safety", "0.10", "5", "3", "4"),
    @("10% expansion provision", "0.10", "4", "2", "5"),
    @("Ease of construction", "0.10", "5", "4", "3"),
    @("WEIGHTED TOTAL", "1.00", "4.45", "3.90", "4.35")
)
$rY = $headerY + $th
for ($r = 0; $r -lt $crit.Count; $r++) {
    $row = $crit[$r]
    $st = $styleARCcell
    if ($r -eq $crit.Count - 1) { $st = $styleARChead }
    $body += Cell $st $row[0] 60 $rY $cw $th
    $body += "`r`n"
    $body += Cell $st $row[1] (60+$cw) $rY 80 $th
    $body += "`r`n"
    $body += Cell $st $row[2] (60+$cw+80) $rY 100 $th
    $body += "`r`n"
    $body += Cell $st $row[3] (60+$cw+180) $rY 100 $th
    $body += "`r`n"
    $body += Cell $st $row[4] (60+$cw+280) $rY 100 $th
    $body += "`r`n"
    $rY += $th
}

# Note
$noteY = $rY + 30
$note = "Alternative 1 (Linear spine) selected: highest weighted total, simplest construction, cleanest pedestrian / vehicle separation. Alternative 3 retained as contingency if powder-coat permit tightens. See Sections_5_to_10_DRAFT Ch 8."
$body += Cell $styleLegend $note 60 $noteY 1280 80
$body += "`r`n"

$page2 = Page "alts02" "Alternatives" 1684 1191 $body

# ============================================================
# PAGE 3: Alternative 1 detail (Linear spine block layout)
# ============================================================
# Scale: 14 px / m. Building 60 m x 32 m = 840 x 448 px. Site 90 m x 55 m = 1260 x 770 px.
# Place site at (200, 200)
$body = ""
$body += Cell $styleTitle "Alternative 1 - Linear Spine (Selected) - Block Layout" 200 30 1280 40
$body += "`r`n"

$pxm = 14
$siteX = 200; $siteY = 200; $siteW = 90*$pxm; $siteH = 55*$pxm
$body += Cell $styleSite "" $siteX $siteY $siteW $siteH
$body += "`r`n"
$body += Cell $styleLabel ("Site footprint " + 90 + " m x " + 55 + " m approx (3 977 m2)") ($siteX+10) ($siteY+10) 400 20
$body += "`r`n"

# Building inside site
$bX = $siteX + 130; $bY = $siteY + 110; $bW = 60*$pxm; $bH = 32*$pxm
$body += Cell $styleBldg ("Building 60 m x 32 m approx (1 867 m2 incl. 10% expansion)") $bX ($bY-25) $bW 20
$body += "`r`n"
$body += Cell $styleBldg "" $bX $bY $bW $bH
$body += "`r`n"

# North office strip (60 m x 10 m = 600 m^2 split into reception/offices/amenities)
$oH = 10*$pxm
$body += Cell $styleSupp "Reception" $bX $bY (10*$pxm) $oH
$body += "`r`n"
$body += Cell $styleSupp "Offices (260 m2, per role)" ($bX+10*$pxm) $bY (25*$pxm) $oH
$body += "`r`n"
$body += Cell $styleSupp "Amenities (240 m2, lockers / restrooms / cafeteria)" ($bX+35*$pxm) $bY (25*$pxm) $oH
$body += "`r`n"

# Production hall (south part of building) -- below office strip
$pY = $bY + $oH
$pH = $bH - $oH  # 22 m * 14 = 308 px
$pH_m = 22

# Lay out west-to-east zones with widths in metres
$zones = @(
    @{ name="Receiving + dock"; w_m=9; style=$styleDock },
    @{ name="RM tube (cantilever)"; w_m=5; style=$styleStor; full=$false; half="top" },
    @{ name="RM sheet"; w_m=3; style=$styleStor; full=$false; half="top" },
    @{ name="Tube fab cells (cut, thread, narrow, knurl)"; w_m=8; style=$styleProd },
    @{ name="Sheet fab cells (stamp, bend, rivet)"; w_m=6; style=$styleProd; full=$false; half="top" },
    @{ name="Sharpen bank (8 grinders)"; w_m=6; style=$styleProdBig },
    @{ name="Serrate (4) + Polish (4)"; w_m=6; style=$styleProdBig },
    @{ name="HT + Sandblast"; w_m=4; style=$styleProd },
    @{ name="Powder coat enclosure (2 lines, 120 m2)"; w_m=8; style=$styleHaz },
    @{ name="Final assembly + Packaging"; w_m=4; style=$styleProd },
    @{ name="FG store + Dispatch"; w_m=7; style=$styleStor }
)
$cx = $bX
$totalW_m = 0
foreach ($z in $zones) {
    $w_px = $z.w_m * $pxm
    if ($z.full -eq $false -and $z.half -eq "top") {
        # Half height on top (e.g. RM stores share width with main aisle below)
        $body += Cell $z.style $z.name $cx $pY $w_px ([int]($pH/2))
        $body += "`r`n"
    } else {
        $body += Cell $z.style $z.name $cx $pY $w_px $pH
        $body += "`r`n"
    }
    $cx += $w_px
    $totalW_m += $z.w_m
}

# Expansion strip along south side of finishing spine (sharpen + serrate + polish + assembly area)
# That is roughly from x=bX + (9+5+3+8+6)*pxm to +12 m wide, h = 4 m
$expX = $bX + (9+5+3+8+6)*$pxm
$expW = (6+6+4+4)*$pxm  # span finishing + HT + powder + asm
$expH = 4*$pxm
$expY = $bY + $bH - $expH - 5
$body += Cell $styleExp "10% expansion strip (170 m2, +1 grinder / +1 roller / +1 polish under +10% demand)" $expX $expY $expW $expH
$body += "`r`n"

# Flow arrows (single direction along the spine)
$ay = $pY + [int]($pH/2)
$body += Edge $styleArrow ($bX+5) $ay ($bX + $bW - 10) $ay "Material flow W -> E"
$body += "`r`n"

# Parking around site
# Employee car park on north
$pkX = $siteX + 20; $pkY = $siteY + 20; $pkW = $siteW - 40; $pkH = 60
$body += Cell $styleSupp "Employee car park (60 bays + 10 visitor = 70 bays, 1750 m2)" $pkX $pkY $pkW $pkH
$body += "`r`n"
# Truck bays on east (dispatch face)
$trX = $siteX + $siteW - 100; $trY = $bY + 20; $trW = 90; $trH = $bH - 40
$body += Cell $styleDock "Truck fleet bays (6 + apron, 360 m2)" $trX $trY $trW $trH
$body += "`r`n"
# Customer collection on south (off dispatch end)
$ccX = $siteX + $siteW - 220; $ccY = $bY + $bH + 20; $ccW = 200; $ccH = 60
$body += Cell $styleDock "Customer collection window + visitor parking" $ccX $ccY $ccW $ccH
$body += "`r`n"
# Waste / scrap zone on south near cut + stamp
$wsX = $siteX + 100; $wsY = $bY + $bH + 20; $wsW = 200; $wsH = 60
$body += Cell $styleStor "Scrap / waste zone (40 m2) - adj. cut + stamp" $wsX $wsY $wsW $wsH
$body += "`r`n"

# Compass + scale
$body += Cell ($styleTitle.Replace("fontSize=20","fontSize=14")) "N up" 60 200 80 30
$body += "`r`n"
$body += Cell $styleLabel ("Scale 1 m = " + $pxm + " px") 60 250 200 30
$body += "`r`n"

# Legend
$lgY = 1000
$lg = @(
    @("Receiving / dispatch", $styleDock),
    @("Storage (RM / FG / waste)", $styleStor),
    @("Production cells", $styleProd),
    @("Bottleneck banks (>=90% util)", $styleProdBig),
    @("Hazardous (powder coat, enclosed)", $styleHaz),
    @("Support (offices / amenities / parking)", $styleSupp),
    @("Expansion provision (10%)", $styleExp),
    @("Site grounds", $styleSite)
)
for ($k = 0; $k -lt $lg.Count; $k++) {
    $col = $k % 4
    $row = [int]([math]::Floor($k / 4))
    $lx = 60 + $col * 380
    $ly = $lgY + $row * 40
    $body += Cell $lg[$k][1] "" $lx $ly 40 28
    $body += "`r`n"
    $body += Cell $styleLabel $lg[$k][0] ($lx+50) $ly 320 28
    $body += "`r`n"
}

$page3 = Page "alt1det03" "Alt 1 Detail" 1684 1191 $body

# ============================================================
# PAGE 4: Final MFP (selected layout, detailed with equipment counts)
# ============================================================
$body = ""
$body += Cell $styleTitle "Master Facility Plan - DigMore Folding Mini Shovel Facility" 100 30 1500 40
$body += "`r`n"
$body += Cell ($styleTitle.Replace("fontSize=20","fontSize=12")) "Linear spine (Alternative 1, weighted score 4.45) | Building 1 867 m2 | Site 3 977 m2 | 60 headcount | All figures from 417.xlsx" 100 75 1500 25
$body += "`r`n"

# Larger scale for MFP detail: 18 px/m. Building 60x32 -> 1080 x 576 px
$pxm = 18
$siteX = 80; $siteY = 130; $siteW = 90*$pxm; $siteH = 55*$pxm
$body += Cell $styleSite "" $siteX $siteY $siteW $siteH
$body += "`r`n"

# Building
$bX = $siteX + (15*$pxm); $bY = $siteY + (12*$pxm); $bW = 60*$pxm; $bH = 32*$pxm
$body += Cell $styleBldg "" $bX $bY $bW $bH
$body += "`r`n"

# North office strip
$oH = 10*$pxm
$body += Cell $styleSupp "Reception" $bX $bY (10*$pxm) $oH
$body += "`r`n"
$body += Cell $styleSupp "Offices (260 m2) - Plant Mgr, Ops Mgr, Inventory, Sales x2, Purchasing, Finance, HR, Marketing, Supervisors" ($bX+10*$pxm) $bY (25*$pxm) $oH
$body += "`r`n"
$body += Cell $styleSupp "Amenities (240 m2) - changing rooms (M/F), restrooms, cafeteria, first-aid" ($bX+35*$pxm) $bY (25*$pxm) $oH
$body += "`r`n"

# Production hall - detailed
$pY = $bY + $oH
$pH = $bH - $oH  # 22 m * 18 = 396 px

# Define detailed zones with explicit widths in metres
# zone: name, w_m, h_m (if partial), y_offset_m (from $pY), style
$cx = $bX
$y0 = $pY

# 1. Receiving zone (9 m wide x 22 m deep)
$body += Cell $styleDock "Receiving dock + inspection bay (125 m2)" $cx $y0 (9*$pxm) (22*$pxm)
$body += "`r`n"
$cx += 9*$pxm

# 2. Raw tube cantilever store (5 m wide x 12 m deep) on south side
$body += Cell $styleStor ("RM tube (cantilever, 4 racks, 960 tubes, 38 m2)") $cx ($y0+(10*$pxm)) (5*$pxm) (12*$pxm)
$body += "`r`n"

# 3. Raw sheet store (5 m wide x 10 m deep) on north side
$body += Cell $styleStor "RM sheet (2 pallet racks, 240 sheets, 10 m2)" $cx $y0 (5*$pxm) (10*$pxm)
$body += "`r`n"
$cx += 5*$pxm

# 4. Tube stream (cut + thread + narrow + knurl) - 8 m wide
# Sub-cells stacked vertically: top = cut + thread, bottom = narrow + knurl bank
$body += Cell $styleProd ("Cut (2) + Internal thread (2)") $cx $y0 (8*$pxm) (10*$pxm)
$body += "`r`n"
$body += Cell $styleProdBig ("Narrow (1) + Knurl + ext. thread (4)`n99.7% util - constraint") $cx ($y0+(10*$pxm)) (8*$pxm) (12*$pxm)
$body += "`r`n"
$cx += 8*$pxm

# 5. Sheet stream (stamp head + stamp hinge + shape + bend + rivet) - 6 m wide
$body += Cell $styleProd ("Sheet stamp (head + hinge) `n+ shape + bend (4 cells)") $cx $y0 (6*$pxm) (12*$pxm)
$body += "`r`n"
$body += Cell $styleProd "Rivet hinge to head (1)" $cx ($y0+(12*$pxm)) (6*$pxm) (10*$pxm)
$body += "`r`n"
$cx += 6*$pxm

# 6. Sharpen bank (8 grinders) - 6 m wide x 22 m deep
$body += Cell $styleProdBig "Sharpen bank`n8 grinders`n94.7% util" $cx $y0 (6*$pxm) (22*$pxm)
$body += "`r`n"
$cx += 6*$pxm

# 7. Serrate + Polish - 6 m wide
$body += Cell $styleProdBig "Serrate (4)`n94.7%" $cx $y0 (6*$pxm) (11*$pxm)
$body += "`r`n"
$body += Cell $styleProdBig "Polish (4)`n94.7%" $cx ($y0+(11*$pxm)) (6*$pxm) (11*$pxm)
$body += "`r`n"
$cx += 6*$pxm

# 8. HT + Sandblast - 4 m wide
$body += Cell $styleProd "T6 ageing`noven (1)" $cx $y0 (4*$pxm) (11*$pxm)
$body += "`r`n"
$body += Cell $styleProd "Sandblast`nbooth (1)" $cx ($y0+(11*$pxm)) (4*$pxm) (11*$pxm)
$body += "`r`n"
$cx += 4*$pxm

# 9. Powder coat enclosure - 8 m wide x 22 m deep
$body += Cell $styleHaz "POWDER COAT ENCLOSURE`n2 conveyorised lines`n600 parts/h each`nFume extraction + air lock`n120 m2" $cx $y0 (8*$pxm) (22*$pxm)
$body += "`r`n"
$cx += 8*$pxm

# 10. Final assembly + packaging - 4 m wide
$body += Cell $styleProdBig "Final assy (2)`n94.7%" $cx $y0 (4*$pxm) (11*$pxm)
$body += "`r`n"
$body += Cell $styleProdBig "Packaging (2)`n94.7%" $cx ($y0+(11*$pxm)) (4*$pxm) (11*$pxm)
$body += "`r`n"
$cx += 4*$pxm

# 11. FG store + Dispatch - rest of width (60 - 9 - 5 - 8 - 6 - 6 - 6 - 4 - 8 - 4 = 4 m left; expand to 7 in zone but here is leftover)
$leftover = 60 - (9+5+8+6+6+6+4+8+4)
$body += Cell $styleStor "FG store`n31 rack pos.`n91 pallets`n59.5 m2" $cx $y0 ($leftover*$pxm) (11*$pxm)
$body += "`r`n"
$body += Cell $styleDock "Dispatch`ndock + loading`n125 m2" $cx ($y0+(11*$pxm)) ($leftover*$pxm) (11*$pxm)
$body += "`r`n"

# Expansion strip along south edge of finishing spine
$expX = $bX + (9+5+8+6)*$pxm
$expW = (6+6+4+8+4)*$pxm
$expH = 3*$pxm
$expY = $bY + $bH - $expH - 3
$body += Cell $styleExp "10% EXPANSION STRIP (170 m2) - +1 grinder / +1 thread roller / +1 polish under +10% demand growth" $expX $expY $expW $expH
$body += "`r`n"

# Flow arrow along the spine
$ay = $pY + [int]($pH/2)
$body += Edge $styleArrow ($bX+5) $ay ($bX + $bW - 10) $ay "Material flow W -> E"
$body += "`r`n"

# Pedestrian routes
$body += Edge $stylePedestr ($bX+5) ($bY+5) ($bX+$bW-5) ($bY+5) "Pedestrian (N wall)"
$body += "`r`n"
$body += Edge $stylePedestr ($bX+5) ($bY+$bH-5) ($bX+$bW-5) ($bY+$bH-5) "Pedestrian (S wall)"
$body += "`r`n"

# Site features
# Employee car park (north, on full site width)
$pkX = $siteX + 20; $pkY = $siteY + 20; $pkW = $siteW - 40; $pkH = (10*$pxm) - 30
$body += Cell $styleSupp "Employee car park (60 bays, 1500 m2)" $pkX $pkY $pkW $pkH
$body += "`r`n"
# Visitor + customer collection on south face
$ccX = $bX + $bW - (12*$pxm); $ccY = $bY + $bH + 10; $ccW = (12*$pxm); $ccH = (8*$pxm)
$body += Cell $styleDock "Customer collection window`n+ 10 visitor bays (250 m2)" $ccX $ccY $ccW $ccH
$body += "`r`n"
# Scrap / waste south near cut
$wsX = $bX + (2*$pxm); $wsY = $bY + $bH + 10; $wsW = (8*$pxm); $wsH = (8*$pxm)
$body += Cell $styleStor "Scrap / waste zone (40 m2)`nadj. cut + stamp" $wsX $wsY $wsW $wsH
$body += "`r`n"
# Truck fleet (east of building)
$trX = $bX + $bW + 10; $trY = $bY + (2*$pxm); $trW = (12*$pxm); $trH = (28*$pxm)
$body += Cell $styleDock "Truck fleet`n6 bays + apron`n360 m2" $trX $trY $trW $trH
$body += "`r`n"

# Compass
$body += Cell ($styleTitle.Replace("fontSize=20","fontSize=18")) "N up" 80 130 80 40
$body += "`r`n"

# Scale bar (50 m = 50 * 18 = 900 px wide too big; use 10 m bar)
$scX = 80; $scY = 1100; $scLen = 10*$pxm
$body += Cell "rounded=0;whiteSpace=wrap;html=1;fillColor=#000000;strokeColor=#000000;" "" $scX $scY $scLen 6
$body += "`r`n"
$body += Cell $styleLabel "0      10 m" $scX ($scY+10) $scLen 20
$body += "`r`n"

# Headline plant inventory table (right of building)
$ix = $siteX + $siteW + 30; $iy = $siteY
$body += Cell ($styleTitle.Replace("fontSize=20","fontSize=14")) "Headline plant inventory" $ix $iy 320 30
$body += "`r`n"
$iy += 40
$inv = @(
    @("Annual demand", "400 000 shovels"),
    @("Daily demand", "1 819 shovels"),
    @("Takt time", "15.83 s"),
    @("Line machines", "34 (14 process types)"),
    @("Line operators", "34"),
    @("Avg machine utilisation", "62.5%"),
    @("Bottleneck count (>=90%)", "7 stations"),
    @("Powder coat lines", "2 (enclosed)"),
    @("Ageing oven / sandblast booth", "1 each"),
    @("Total headcount", "60"),
    @("Car bays / truck bays", "70 / 6"),
    @("Forklifts (3 t)", "3"),
    @("Building footprint", "1 867 m2"),
    @("Site footprint", "3 977 m2"),
    @("Total capex (indicative)", "R 35.9 M")
)
foreach ($r in $inv) {
    $body += Cell $styleARCcell $r[0] $ix $iy 200 26
    $body += "`r`n"
    $body += Cell $styleARCcell $r[1] ($ix+200) $iy 120 26
    $body += "`r`n"
    $iy += 26
}

# Legend
$lgY = 870
$lg = @(
    @("Receiving / dispatch / customer", $styleDock),
    @("Storage (RM / FG / waste)", $styleStor),
    @("Production cells (<90% util)", $styleProd),
    @("Bottleneck banks (>=90% util)", $styleProdBig),
    @("Hazardous, enclosed (powder coat)", $styleHaz),
    @("Support (offices / amenities / parking)", $styleSupp),
    @("Expansion provision (10%)", $styleExp),
    @("Site grounds", $styleSite)
)
for ($k = 0; $k -lt $lg.Count; $k++) {
    $col = $k % 4
    $row = [int]([math]::Floor($k / 4))
    $lx = 80 + $col * 380
    $ly = $lgY + $row * 38
    $body += Cell $lg[$k][1] "" $lx $ly 40 28
    $body += "`r`n"
    $body += Cell $styleLabel $lg[$k][0] ($lx+50) $ly 320 28
    $body += "`r`n"
}

# Flow arrow legend
$arX = 80; $arY = 970
$body += Edge $styleArrow $arX ($arY+10) ($arX+80) ($arY+10) ""
$body += "`r`n"
$body += Cell $styleLabel "Material flow (forklift / trolley)" ($arX+90) $arY 320 28
$body += "`r`n"
$body += Edge $stylePedestr $arX ($arY+40) ($arX+80) ($arY+40) ""
$body += "`r`n"
$body += Cell $styleLabel "Pedestrian route (painted)" ($arX+90) ($arY+30) 320 28
$body += "`r`n"

$page4 = Page "mfp04" "Final MFP" 1684 1191 $body

# ============================================================
# Assemble file
# ============================================================
$header = '<mxfile host="Drawio" modified="' + (Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ") + '" agent="DigMore generator" version="23.1.5" type="device" pages="4">'
$xml = $header + "`r`n" + $page1 + "`r`n" + $page2 + "`r`n" + $page3 + "`r`n" + $page4 + "`r`n" + '</mxfile>'

Set-Content -Path $out -Value $xml -Encoding UTF8
Write-Host ("Wrote: " + $out)
Write-Host ("Size: " + (Get-Item $out).Length + " bytes")
