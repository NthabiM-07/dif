# Build a detailed Tube Cutting Workstation drawio (single page, A3 landscape)
# Visual style follows the laser-cutting reference figure: colour-coded zones,
# dimension lines on top + left + right, rack icons, operator aisle.
#
# Scale: 30 px = 1 m. Workstation envelope = 19.5 m x 7.7 m -> 585 x 231 px.
# Place at origin (140, 140) to leave room for top + left dimensions.

$out = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\Tube_Cutting_Workstation.drawio"

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

# ---------- Style palette ----------
$styleRack    = "rounded=0;whiteSpace=wrap;html=1;fillColor=#F8CECC;strokeColor=#B85450;strokeWidth=1.5;fontSize=12;fontStyle=1;align=center;verticalAlign=bottom;"
$styleMachine = "rounded=0;whiteSpace=wrap;html=1;fillColor=#D5E8D4;strokeColor=#82B366;strokeWidth=1.5;fontSize=12;fontStyle=1;align=center;verticalAlign=top;"
$styleLoad    = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFE6CC;strokeColor=#D79B00;strokeWidth=1.2;fontSize=11;fontStyle=1;align=center;verticalAlign=middle;"
$styleCtrl    = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFB366;strokeColor=#D79B00;strokeWidth=1.5;fontSize=10;fontStyle=1;align=center;verticalAlign=middle;"
$styleAisle   = "rounded=0;whiteSpace=wrap;html=1;fillColor=#999999;strokeColor=#666666;strokeWidth=1;fontSize=11;fontStyle=1;fontColor=#FFFFFF;align=center;verticalAlign=middle;"
$styleWIP     = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFF2CC;strokeColor=#D6B656;strokeWidth=1.5;fontSize=11;fontStyle=1;align=center;verticalAlign=middle;"
$styleScrap   = "rounded=0;whiteSpace=wrap;html=1;fillColor=#F8CECC;strokeColor=#B85450;strokeWidth=1.2;fontSize=9;fontStyle=1;align=center;verticalAlign=middle;"
$styleTitle   = "text;html=1;align=center;verticalAlign=middle;fontSize=18;fontStyle=1;fontColor=#4C0099;"
$styleSubt    = "text;html=1;align=center;verticalAlign=middle;fontSize=11;fontStyle=2;fontColor=#666666;"
$styleDimTxt  = "text;html=1;align=center;verticalAlign=middle;fontSize=11;fontStyle=0;"
$styleDimLine = "endArrow=classic;startArrow=classic;html=1;rounded=0;endSize=8;startSize=8;strokeColor=#000000;strokeWidth=1;"
$styleRackIcn = "shape=mscae/Toolbox;html=1;fillColor=#B85450;strokeColor=#B85450;rotation=0;"
$styleTubeIcn = "rounded=0;whiteSpace=wrap;html=1;fillColor=#888888;strokeColor=#555555;strokeWidth=0.6;"
$styleLegBox  = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#333333;strokeWidth=1;fontSize=10;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;"
$styleLegItem = "rounded=0;whiteSpace=wrap;html=1;strokeColor=#333333;strokeWidth=1;fontSize=10;"
$styleNote    = "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#999999;strokeWidth=1;fontSize=10;fontStyle=2;align=left;verticalAlign=top;spacingLeft=6;spacingTop=4;dashed=1;"

# ---------- Geometry (scale 30 px/m) ----------
$ox = 140
$oy = 160
$s  = 30  # px per metre

# Real-world dimensions (m)
# Top row (machine row): rack 7m + bar feeder 6m + saw 1.5m + ctrl 0.5m + WIP-collect 2.5m = 17.5m
# But ctrl panel sits on top of saw bed, so logical width = rack + feeder + saw + WIP = 17m
# Plus visible margins
$rackW  = 7.0;  $rackH = 2.0      # cantilever rack 7m wide x 2m deep (raw tube store)
$feedW  = 6.0;  $feedH = 1.0      # bar feeder envelope 6m x 1m
$sawW   = 1.8;  $sawH  = 2.5      # cold saw bed
$wipcW  = 2.0;  $wipcH = 1.5      # cut-tube WIP collection chute
$ctrlW  = 0.9;  $ctrlH = 0.6      # operator HMI panel
$aisleW = 17.0; $aisleH = 1.5     # operator aisle 17m x 1.5m
$wipW   = 4.0;  $wipH  = 3.0      # WIP area for cut sections
$scrapW = 1.0;  $scrapH = 1.0     # 5% scrap bin

# Layout (top -> bottom):
# Band 1 (machine row, height = rackH = 2.0m, but saw is taller -> 2.5m): y=0..3.2m
# Band 2 (operator aisle): y=3.2..4.7m
# Band 3 (WIP area): y=4.7..7.7m

# Convert to pixels and absolute coords
function Px([double]$m) { return [int]([Math]::Round($m * $s)) }
function Ax([double]$m) { return $ox + (Px $m) }
function Ay([double]$m) { return $oy + (Px $m) }

$cells = New-Object System.Collections.ArrayList

# --- Title ---
[void]$cells.Add((Cell $styleTitle "FIGURE X: Tube Cutting Workstation (DigMore)" ($ox-20) ($oy-100) ($s*20) 30))
[void]$cells.Add((Cell $styleSubt "Scale 1 : 50  -  station footprint 17.5 m x 7.7 m  -  process: cut 6 m Al tube to length, 15 s per cut" ($ox-20) ($oy-72) ($s*20) 20))

# ----------------- BAND 1: machine row -----------------
# Cantilever rack (raw tube store), pink
$rackX = 0.0; $rackY = 0.0
[void]$cells.Add((Cell $styleRack "Raw Tube Cantilever Rack" (Ax $rackX) (Ay $rackY) (Px $rackW) (Px $rackH)))

# Rack icons (six H-shapes) inside the rack
$icnH = 22; $icnW = 22; $icnY = (Ay 0.4); $count = 8; $startX = (Ax 0.5); $stepX = ((Px $rackW) - ($icnW * $count) - 30) / ($count-1) + $icnW
for ($i=0; $i -lt $count; $i++) {
    $ix = $startX + ($i * $stepX)
    # Vertical bar (post)
    [void]$cells.Add((Cell "rounded=0;fillColor=#B85450;strokeColor=#B85450;" "" $ix $icnY 4 28))
    # Top arm
    [void]$cells.Add((Cell "rounded=0;fillColor=#B85450;strokeColor=#B85450;" "" ($ix-7) $icnY 18 4))
    # Bottom arm
    [void]$cells.Add((Cell "rounded=0;fillColor=#B85450;strokeColor=#B85450;" "" ($ix-7) ($icnY+24) 18 4))
}

# Bar feeder + cold saw + WIP chute (green band running across)
$mbY = $rackY + 0.0
$mbW = $feedW + $sawW + $wipcW + 0.5
[void]$cells.Add((Cell $styleMachine "Cold Saw + Bar Feeder (1 machine, 99.7% util)" (Ax $rackW) (Ay $mbY) (Px $mbW) (Px 2.6)))

# Bar feeder (loading area) - orange band inside
$feedX = $rackW + 0.2; $feedYp = $mbY + 1.3
[void]$cells.Add((Cell $styleLoad "Bar Feeder (loads 6 m tube)" (Ax $feedX) (Ay $feedYp) (Px $feedW) (Px 0.9)))

# A 6m tube graphic inside the feeder
[void]$cells.Add((Cell $styleTubeIcn "" (Ax ($feedX+0.1)) (Ay ($feedYp+0.35)) (Px ($feedW-0.2)) 6))

# Cold saw bed - darker green block
$sawX = $rackW + $feedW + 0.3; $sawY = $mbY + 0.4
$styleSawBed = "rounded=0;whiteSpace=wrap;html=1;fillColor=#9CBF8A;strokeColor=#3F7B33;strokeWidth=1.5;fontSize=10;fontStyle=1;align=center;verticalAlign=middle;"
[void]$cells.Add((Cell $styleSawBed "Saw Bed" (Ax $sawX) (Ay $sawY) (Px $sawW) (Px $sawH)))

# Saw blade graphic (circle on top edge of bed)
$styleBlade = "ellipse;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#000000;strokeWidth=1.2;"
[void]$cells.Add((Cell $styleBlade "" (Ax ($sawX+0.4)) (Ay ($sawY+0.7)) (Px 1.0) (Px 1.0)))

# Operator HMI / computer interface
$ctrlX = $sawX + $sawW + 0.1; $ctrlY = $mbY + 0.7
[void]$cells.Add((Cell $styleCtrl "Operator HMI" (Ax $ctrlX) (Ay $ctrlY) (Px 1.4) (Px 0.8)))

# WIP collection chute (orange)
$wipcX = $sawX + $sawW + 0.1; $wipcY = $mbY + 1.7
[void]$cells.Add((Cell $styleLoad "WIP Collection" (Ax $wipcX) (Ay $wipcY) (Px ($wipcW-0.4)) (Px 0.7)))

# ----------------- BAND 2: operator aisle -----------------
$aisleY = 3.4
[void]$cells.Add((Cell $styleAisle "Operator Aisle (1.5 m wide)" (Ax 0) (Ay $aisleY) (Px ($rackW + $mbW)) (Px $aisleH)))

# ----------------- BAND 3: WIP area for cut sections -----------------
$wipX = 7.5; $wipY = 5.0
[void]$cells.Add((Cell $styleWIP "WIP AREA`n(cut tube sections)" (Ax $wipX) (Ay $wipY) (Px $wipW) (Px $wipH)))

# 2x2 rack icons inside WIP area
$wipIcnSx = (Ax ($wipX + 0.5))
$wipIcnSy = (Ay ($wipY + 0.5))
$step = 50
for ($r=0; $r -lt 2; $r++) {
    for ($c=0; $c -lt 2; $c++) {
        $ix = $wipIcnSx + ($c * $step)
        $iy = $wipIcnSy + ($r * $step)
        # Tube section sitting on rack (green outline)
        [void]$cells.Add((Cell "rounded=0;fillColor=#FFFFFF;strokeColor=#4C7A36;strokeWidth=1.8;" "" $ix $iy 38 24))
        # cross arm
        [void]$cells.Add((Cell "rounded=0;fillColor=#4C7A36;strokeColor=#4C7A36;" "" ($ix+4) ($iy+10) 30 4))
    }
}

# Scrap bin (5% scrap) - small red square just off the saw, into the aisle
$scrapX = 7.0; $scrapY = 3.5
[void]$cells.Add((Cell $styleScrap "Scrap Bin`n(5%)" (Ax $scrapX) (Ay $scrapY) (Px 1.2) (Px 1.2)))

# ----------------- Dimension lines -----------------
# Top horizontal dimensions: rack 7m, machine row 10.5m
$dimY1 = $oy - 25
$dimY2 = $oy - 8
# Rack width 7m
[void]$cells.Add((Edge $styleDimLine (Ax 0) $dimY1 (Ax $rackW) $dimY1 ""))
[void]$cells.Add((Cell $styleDimTxt "7 m" ((Ax 0)) ($dimY1 - 22) (Px $rackW) 18))
# Machine row width (feeder + saw + wip) ~10.5m
[void]$cells.Add((Edge $styleDimLine (Ax $rackW) $dimY1 (Ax ($rackW + $mbW)) $dimY1 ""))
[void]$cells.Add((Cell $styleDimTxt "10.5 m" ((Ax $rackW)) ($dimY1 - 22) (Px $mbW) 18))

# Right-hand vertical dimensions
$dimXrt = (Ax ($rackW + $mbW)) + 25
# Band 1 height 2.6m
[void]$cells.Add((Edge $styleDimLine $dimXrt (Ay 0) $dimXrt (Ay 2.6) ""))
[void]$cells.Add((Cell $styleDimTxt "2.6 m" ($dimXrt + 4) ((Ay 0)) 36 (Px 2.6)))
# Aisle 1.5m
[void]$cells.Add((Edge $styleDimLine $dimXrt (Ay 3.4) $dimXrt (Ay 4.9) ""))
[void]$cells.Add((Cell $styleDimTxt "1.5 m" ($dimXrt + 4) ((Ay 3.4)) 36 (Px 1.5)))
# WIP 3m
[void]$cells.Add((Edge $styleDimLine $dimXrt (Ay 5.0) $dimXrt (Ay 8.0) ""))
[void]$cells.Add((Cell $styleDimTxt "3 m" ($dimXrt + 4) ((Ay 5.0)) 36 (Px 3.0)))

# Left-hand vertical dimension: rack depth 2m
$dimXlt = $ox - 35
[void]$cells.Add((Edge $styleDimLine $dimXlt (Ay 0) $dimXlt (Ay 2.0) ""))
[void]$cells.Add((Cell $styleDimTxt "2 m" ($dimXlt - 40) ((Ay 0)) 36 (Px 2.0)))

# WIP width dimension below the WIP block
$dimYb = (Ay 8.2)
[void]$cells.Add((Edge $styleDimLine (Ax $wipX) $dimYb (Ax ($wipX + $wipW)) $dimYb ""))
[void]$cells.Add((Cell $styleDimTxt "4 m" ((Ax $wipX)) ($dimYb + 4) (Px $wipW) 18))

# ----------------- Legend (right side) -----------------
$legX = (Ax ($rackW + $mbW)) + 90
$legY = $oy + 10
$legW = 220; $legH = 220
[void]$cells.Add((Cell $styleLegBox "Legend" $legX $legY $legW $legH))

$items = @(
    @{Color="#F8CECC"; Stroke="#B85450"; Label="Raw material rack"},
    @{Color="#D5E8D4"; Stroke="#82B366"; Label="Machine envelope"},
    @{Color="#FFE6CC"; Stroke="#D79B00"; Label="Loading / WIP chute"},
    @{Color="#FFB366"; Stroke="#D79B00"; Label="Operator HMI"},
    @{Color="#999999"; Stroke="#666666"; Label="Operator aisle"},
    @{Color="#FFF2CC"; Stroke="#D6B656"; Label="WIP area"}
)
$yIt = $legY + 30
foreach ($it in $items) {
    $st = "rounded=0;whiteSpace=wrap;html=1;fillColor=" + $it.Color + ";strokeColor=" + $it.Stroke + ";strokeWidth=1;"
    [void]$cells.Add((Cell $st "" ($legX + 10) $yIt 28 18))
    [void]$cells.Add((Cell "text;html=1;align=left;verticalAlign=middle;fontSize=10;" $it.Label ($legX + 46) $yIt 170 18))
    $yIt += 28
}

# ----------------- Notes box (below legend) -----------------
$noteY = $legY + $legH + 14
$noteText = "Notes" + [char]10 + 
            "- Workstation supports cycle 15 s per 6 m tube; 2 such cells run in parallel (Capacity sheet row 1)." + [char]10 +
            "- Forklift access from main aisle to cantilever rack (side-load 6 m tubes)." + [char]10 +
            "- Cut sections move by trolley from WIP collection to the WIP area, then to next op." + [char]10 +
            "- Scrap (5%, brief C4) collected at bin; emptied daily into central scrap store."
[void]$cells.Add((Cell $styleNote $noteText $legX $noteY $legW 130))

# ----------------- North arrow / orientation -----------------
$narX = $legX + 10; $narY = $noteY + 150
[void]$cells.Add((Cell "shape=mxgraph.arrows2.arrow;dy=0.6;dx=40;notch=0;html=1;fillColor=#FFFFFF;strokeColor=#000000;rotation=-90;" "" $narX $narY 40 22))
[void]$cells.Add((Cell "text;html=1;align=center;verticalAlign=middle;fontSize=10;fontStyle=1;" "N" ($narX + 50) $narY 20 22))

# ----------------- Page wrapper -----------------
$body = ($cells -join "`r`n")

$xml = '<mxfile host="app.diagrams.net" type="device">' + "`r`n" +
       '  <diagram id="tube-cut-ws" name="Tube Cutting Workstation">' + "`r`n" +
       '    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1169" pageHeight="826" math="0" shadow="0">' + "`r`n" +
       '      <root>' + "`r`n" +
       '        <mxCell id="0" />' + "`r`n" +
       '        <mxCell id="1" parent="0" />' + "`r`n" +
       $body + "`r`n" +
       '      </root>' + "`r`n" +
       '    </mxGraphModel>' + "`r`n" +
       '  </diagram>' + "`r`n" +
       '</mxfile>'

[System.IO.File]::WriteAllText($out, $xml, [System.Text.UTF8Encoding]::new($false))
Write-Host ("Wrote: " + $out)
Write-Host ("Size: " + (Get-Item $out).Length + " bytes")

# Validate
try {
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($out)
    $diags = $doc.SelectNodes('//diagram')
    $cellNodes = $doc.SelectNodes('//mxCell')
    Write-Host ("XML OK. pages=" + $diags.Count + " cells=" + $cellNodes.Count)
} catch {
    Write-Host ("XML ERR: " + $_.Exception.Message)
}
