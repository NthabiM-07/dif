# DigMore Master Facility Plan (A2 portrait, drawn to scale)
# Page A2 portrait 1654 x 2339 px.  Scale: 22 px = 1 m.
# Site 78 m x 51 m = 3 978 m^2.  Building 60 m x 31 m = 1 860 m^2.

$out = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_A2.drawio"

$SCALE = 22
function Px { param([double]$m) return [int]($m * $SCALE) }
function XmlEsc { param([string]$s)
    if ($null -eq $s) { return '' }
    return ($s -replace '&','&amp;' -replace '<','&lt;' -replace '>','&gt;' -replace '"','&quot;')
}

$script:id = 100
function NextId { $script:id++; return $script:id }

$cells = New-Object System.Collections.Generic.List[string]
$cells.Add('<mxCell id="0"/>')
$cells.Add('<mxCell id="1" parent="0"/>')

function Add-Vertex {
    param([string]$Value,[int]$X,[int]$Y,[int]$W,[int]$H,[string]$Style)
    $i = NextId
    $v = XmlEsc $Value
    $s = XmlEsc $Style
    $line = '<mxCell id="{0}" value="{1}" style="{2}" vertex="1" parent="1"><mxGeometry x="{3}" y="{4}" width="{5}" height="{6}" as="geometry"/></mxCell>' -f $i,$v,$s,$X,$Y,$W,$H
    $script:cells.Add($line)
    return $i
}

# ----------- page constants ------------
$M = 40

# ----------- title block ---------------
$titleY = $M
Add-Vertex -Value '' -X $M -Y $titleY -W 1574 -H 90 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#1F4E79;strokeColor=#1F4E79;' | Out-Null
Add-Vertex -Value 'Master Facility Plan - DigMore Folding Mini Shovel' -X ($M+10) -Y ($titleY+8) -W 1554 -H 38 -Style 'text;html=1;fontColor=#FFFFFF;fontSize=26;fontStyle=1;align=center;verticalAlign=middle;strokeColor=none;fillColor=none;' | Out-Null
Add-Vertex -Value 'Project: INGB 417 GA3  |  Scale: 1 : 50  |  Drawing No. MFP-01  |  Date: 12 June 2026' -X ($M+10) -Y ($titleY+50) -W 1554 -H 30 -Style 'text;html=1;fontColor=#FFFFFF;fontSize=12;align=center;verticalAlign=middle;strokeColor=none;fillColor=none;' | Out-Null

# ----------- info strip ---------------
$infoY = $titleY + 100
Add-Vertex -Value '' -X $M -Y $infoY -W 1574 -H 60 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#F2F2F2;strokeColor=#1F4E79;' | Out-Null
$infoText = 'Total site area: 3 977 m^2  |  Building footprint: 1 867 m^2  |  Production: 400 000 shovels/yr (1 819/day @ 15.83 s takt)  |  Headcount: 60'
Add-Vertex -Value $infoText -X ($M+10) -Y ($infoY+10) -W 1554 -H 40 -Style 'text;html=1;fontSize=12;fontStyle=1;align=center;verticalAlign=middle;strokeColor=none;fillColor=none;' | Out-Null

# ----------- scale bar ----------------
$sbX = $M + 20
$sbY = $infoY + 80
$sb5 = Px 5
$sb10 = Px 10
Add-Vertex -Value '' -X $sbX -Y $sbY -W $sb10 -H 14 -Style 'rounded=0;html=1;fillColor=#000000;strokeColor=#000000;' | Out-Null
Add-Vertex -Value '' -X ($sbX + $sb5) -Y $sbY -W $sb5 -H 14 -Style 'rounded=0;html=1;fillColor=#FFFFFF;strokeColor=#000000;' | Out-Null
Add-Vertex -Value '0 m'  -X ($sbX - 15)        -Y ($sbY+16) -W 30 -H 16 -Style 'text;html=1;fontSize=10;align=center;' | Out-Null
Add-Vertex -Value '5 m'  -X ($sbX + $sb5 - 12) -Y ($sbY+16) -W 30 -H 16 -Style 'text;html=1;fontSize=10;align=center;' | Out-Null
Add-Vertex -Value '10 m' -X ($sbX + $sb10- 12) -Y ($sbY+16) -W 30 -H 16 -Style 'text;html=1;fontSize=10;align=center;' | Out-Null
Add-Vertex -Value 'Scale 1:50 (22 px = 1 m)' -X ($sbX + $sb10 + 30) -Y ($sbY-2) -W 220 -H 20 -Style 'text;html=1;fontSize=11;fontStyle=2;align=left;' | Out-Null

# ----------- SITE ----------------------
$siteX = $M
$siteY = $infoY + 130
$siteW = Px 78
$siteH = Px 51
Add-Vertex -Value '' -X $siteX -Y $siteY -W $siteW -H $siteH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#C5E1A5;strokeColor=#33691E;strokeWidth=2;' | Out-Null
Add-Vertex -Value 'SITE BOUNDARY  -  78 m x 51 m  =  3 978 m^2 (lawn / paving)' -X ($siteX+10) -Y ($siteY+10) -W 600 -H 22 -Style 'text;html=1;fontSize=11;fontStyle=2;fontColor=#33691E;align=left;' | Out-Null

# North arrow
$naX = $siteX + $siteW - 70
$naY = $siteY + 10
Add-Vertex -Value '' -X $naX -Y $naY -W 60 -H 60 -Style 'shape=callout;html=1;fillColor=#FFFFFF;strokeColor=#000000;' | Out-Null
Add-Vertex -Value 'N' -X ($naX+22) -Y ($naY+10) -W 16 -H 20 -Style 'text;html=1;fontSize=18;fontStyle=1;align=center;' | Out-Null

# Parking + Security
$parkX = $siteX + (Px 2)
$parkY = $siteY + (Px 2)
$parkW = Px 12
$parkH = Px 5
Add-Vertex -Value 'PARKING (12 x 5 m = 60 m^2 staff + visitor)' -X $parkX -Y $parkY -W $parkW -H $parkH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#BDBDBD;strokeColor=#424242;fontSize=11;fontStyle=1;verticalAlign=middle;align=center;' | Out-Null

$secX = $parkX + (Px 14)
$secW = Px 4
$secH = Px 4
Add-Vertex -Value 'SECURITY GATEHOUSE (4 x 4 m = 16 m^2)' -X $secX -Y $parkY -W $secW -H $secH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFE0B2;strokeColor=#E65100;fontSize=9;fontStyle=1;verticalAlign=middle;align=center;' | Out-Null

# Loading bay
$lbX = $siteX + (Px 60)
$lbY = $siteY + (Px 8)
$lbW = Px 16
$lbH = Px 18
Add-Vertex -Value 'TRUCK LOADING BAY + MANOEUVRING YARD (16 x 18 m = 288 m^2)' -X $lbX -Y $lbY -W $lbW -H $lbH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#90CAF9;strokeColor=#0D47A1;fontSize=11;fontStyle=1;verticalAlign=middle;align=center;' | Out-Null

# Fire assembly point
$faX = $siteX + (Px 60)
$faY = $siteY + (Px 30)
$faW = Px 16
$faH = Px 8
Add-Vertex -Value 'FIRE ASSEMBLY POINT' -X $faX -Y $faY -W $faW -H $faH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFCDD2;strokeColor=#B71C1C;fontSize=11;fontStyle=1;verticalAlign=middle;align=center;dashed=1;dashPattern=8 4;' | Out-Null

# BUILDING
$bX = $siteX + (Px 2) + 4
$bY = $siteY + (Px 8)
$bW = Px 60
$bH = Px 31
Add-Vertex -Value '' -X $bX -Y $bY -W $bW -H $bH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FAFAFA;strokeColor=#212121;strokeWidth=4;' | Out-Null
Add-Vertex -Value 'DigMore PRODUCTION BUILDING  -  60 m x 31 m  =  1 860 m^2' -X ($bX+10) -Y ($bY+6) -W ($bW-20) -H 22 -Style 'text;html=1;fontSize=12;fontStyle=1;fontColor=#212121;align=left;' | Out-Null

# Internal zones
$bxM = $bX + 4
$byM = $bY + 30

function Add-Zone {
    param([string]$Name,[int]$MX,[int]$MY,[int]$MW,[int]$MH,[string]$Fill,[string]$Stroke)
    $x = $script:bxM + (Px $MX)
    $y = $script:byM + (Px $MY)
    $w = Px $MW
    $h = Px $MH
    $area = $MW * $MH
    $label = "$Name`n$MW m x $MH m  =  $area m^2"
    $style = "rounded=0;whiteSpace=wrap;html=1;fillColor=$Fill;strokeColor=$Stroke;strokeWidth=1.5;fontSize=11;fontStyle=1;verticalAlign=middle;align=center;"
    [void](Add-Vertex -Value $label -X $x -Y $y -W $w -H $h -Style $style)
}

# Row 1
Add-Zone -Name 'RECEIVING & INSPECTION'        -MX 0  -MY 0  -MW 10 -MH 6 -Fill '#FFE0B2' -Stroke '#E65100'
Add-Zone -Name 'RAW MATERIAL STORE'            -MX 10 -MY 0  -MW 12 -MH 6 -Fill '#FFCC80' -Stroke '#E65100'
Add-Zone -Name 'POWDER COATING (enclosed)'     -MX 34 -MY 0  -MW 16 -MH 8 -Fill '#CE93D8' -Stroke '#4A148C'
Add-Zone -Name 'FINISHED GOODS STORE'          -MX 50 -MY 0  -MW 10 -MH 6 -Fill '#80CBC4' -Stroke '#004D40'

# Row 2
Add-Zone -Name 'HANDLE (tube) PRODUCTION CELL' -MX 0  -MY 6  -MW 16 -MH 8 -Fill '#FFF59D' -Stroke '#F57F17'
Add-Zone -Name 'SHEET (head + hinge) CELL'     -MX 16 -MY 6  -MW 18 -MH 8 -Fill '#FFF176' -Stroke '#F57F17'
Add-Zone -Name 'DISPATCH BAY'                  -MX 50 -MY 6  -MW 10 -MH 4 -Fill '#B2DFDB' -Stroke '#004D40'

# Row 3
Add-Zone -Name 'SUBASSEMBLY FINISHING (heat-treat, sandblast, polish, rivet)' -MX 0  -MY 14 -MW 34 -MH 4 -Fill '#A5D6A7' -Stroke '#1B5E20'
Add-Zone -Name 'ASSEMBLY + PACKAGING'          -MX 34 -MY 14 -MW 16 -MH 6 -Fill '#81C784' -Stroke '#1B5E20'
Add-Zone -Name 'SCRAP / WASTE'                 -MX 50 -MY 14 -MW 10 -MH 4 -Fill '#EF9A9A' -Stroke '#B71C1C'

# Row 4 (ancillary)
Add-Zone -Name 'OFFICES + RECEPTION'           -MX 0  -MY 18 -MW 14 -MH 4 -Fill '#90CAF9' -Stroke '#0D47A1'
Add-Zone -Name 'CAFETERIA / BREAK ROOM'        -MX 14 -MY 18 -MW 10 -MH 4 -Fill '#9FA8DA' -Stroke '#1A237E'
Add-Zone -Name 'TOILETS + LOCKERS'             -MX 24 -MY 18 -MW 10 -MH 4 -Fill '#B39DDB' -Stroke '#311B92'
Add-Zone -Name 'MAINTENANCE / TOOLING'         -MX 50 -MY 18 -MW 10 -MH 4 -Fill '#CFD8DC' -Stroke '#37474F'

# Main aisle marker
$aisleY = $byM + (Px 13)
$aisleW = Px 50
Add-Vertex -Value '' -X $bxM -Y $aisleY -W $aisleW -H 4 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFE082;strokeColor=#FF6F00;' | Out-Null
Add-Vertex -Value 'MAIN AISLE  (3 m wide, forklift / tugger)' -X ($bxM+6) -Y ($aisleY-18) -W 400 -H 16 -Style 'text;html=1;fontSize=10;fontStyle=2;fontColor=#FF6F00;align=left;' | Out-Null

# Roller door
$ldX = $bX + $bW
$ldY = $bY + (Px 6)
$ldH = Px 6
Add-Vertex -Value 'ROLLER DOOR' -X ($ldX-90) -Y ($ldY-14) -W 90 -H 14 -Style 'text;html=1;fontSize=10;fontStyle=2;align=right;' | Out-Null
Add-Vertex -Value '' -X $ldX -Y $ldY -W 14 -H $ldH -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#000000;strokeWidth=2;dashed=1;dashPattern=4 4;' | Out-Null

# Personnel entrance
$peX = $bX + (Px 30)
$peY = $bY + $bH
$peW = Px 2
Add-Vertex -Value '' -X $peX -Y $peY -W $peW -H 12 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#000000;strokeWidth=2;' | Out-Null
Add-Vertex -Value 'Personnel entrance' -X ($peX-20) -Y ($peY+12) -W 120 -H 16 -Style 'text;html=1;fontSize=10;fontStyle=2;align=center;' | Out-Null

# LEGEND
$lgY = $siteY + $siteH + 30
Add-Vertex -Value '' -X $M -Y $lgY -W 1574 -H 380 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#1F4E79;strokeWidth=2;' | Out-Null
Add-Vertex -Value 'LEGEND' -X ($M+12) -Y ($lgY+8) -W 200 -H 24 -Style 'text;html=1;fontSize=14;fontStyle=1;fontColor=#1F4E79;align=left;' | Out-Null

$col1 = $M + 20
$col2 = $M + 520
$col3 = $M + 1050
$rowY = $lgY + 44
$rowH = 30

function Add-LegRow {
    param([int]$Cx,[int]$Ry,[string]$Fill,[string]$Stroke,[string]$Text)
    [void](Add-Vertex -Value '' -X $Cx -Y $Ry -W 40 -H 22 -Style "rounded=0;whiteSpace=wrap;html=1;fillColor=$Fill;strokeColor=$Stroke;strokeWidth=1.5;")
    [void](Add-Vertex -Value $Text -X ($Cx+50) -Y $Ry -W 420 -H 22 -Style 'text;html=1;fontSize=11;align=left;verticalAlign=middle;')
}

Add-Vertex -Value 'Zone colour key' -X $col1 -Y ($rowY-26) -W 300 -H 22 -Style 'text;html=1;fontSize=12;fontStyle=1;fontColor=#1F4E79;' | Out-Null
Add-LegRow -Cx $col1 -Ry  $rowY            -Fill '#FFE0B2' -Stroke '#E65100' -Text 'Receiving / raw material'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH)     -Fill '#FFF59D' -Stroke '#F57F17' -Text 'Production cells (tube + sheet)'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*2)   -Fill '#A5D6A7' -Stroke '#1B5E20' -Text 'Subassembly finishing / assembly'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*3)   -Fill '#CE93D8' -Stroke '#4A148C' -Text 'Powder coating (enclosed)'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*4)   -Fill '#80CBC4' -Stroke '#004D40' -Text 'Finished goods / dispatch'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*5)   -Fill '#EF9A9A' -Stroke '#B71C1C' -Text 'Scrap / waste'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*6)   -Fill '#90CAF9' -Stroke '#0D47A1' -Text 'Offices / reception'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*7)   -Fill '#9FA8DA' -Stroke '#1A237E' -Text 'Cafeteria / break room'
Add-LegRow -Cx $col1 -Ry ($rowY+$rowH*8)   -Fill '#B39DDB' -Stroke '#311B92' -Text 'Toilets / lockers'

Add-Vertex -Value 'Site features' -X $col2 -Y ($rowY-26) -W 300 -H 22 -Style 'text;html=1;fontSize=12;fontStyle=1;fontColor=#1F4E79;' | Out-Null
Add-LegRow -Cx $col2 -Ry  $rowY            -Fill '#C5E1A5' -Stroke '#33691E' -Text 'Lawn / landscaped border'
Add-LegRow -Cx $col2 -Ry ($rowY+$rowH)     -Fill '#BDBDBD' -Stroke '#424242' -Text 'Parking (paved)'
Add-LegRow -Cx $col2 -Ry ($rowY+$rowH*2)   -Fill '#90CAF9' -Stroke '#0D47A1' -Text 'Truck loading bay / yard'
Add-LegRow -Cx $col2 -Ry ($rowY+$rowH*3)   -Fill '#FFE0B2' -Stroke '#E65100' -Text 'Security gatehouse'
Add-LegRow -Cx $col2 -Ry ($rowY+$rowH*4)   -Fill '#FFCDD2' -Stroke '#B71C1C' -Text 'Fire assembly point (dashed)'
Add-LegRow -Cx $col2 -Ry ($rowY+$rowH*5)   -Fill '#FFE082' -Stroke '#FF6F00' -Text 'Main aisle (3 m wide)'

Add-Vertex -Value 'Area summary (DigMore capacity model)' -X $col3 -Y ($rowY-26) -W 500 -H 22 -Style 'text;html=1;fontSize=12;fontStyle=1;fontColor=#1F4E79;' | Out-Null
$sumLines = @(
  'Total site area (boundary):            3 978 m^2'
  'Building footprint:                    1 860 m^2'
  '  - Production cells (tube + sheet):     272 m^2'
  '  - Subassembly finishing:               136 m^2'
  '  - Assembly + packaging:                 96 m^2'
  '  - Powder coating (enclosed):           128 m^2'
  '  - Raw + finished goods storage:        132 m^2'
  '  - Offices / cafeteria / amenities:     136 m^2'
  '  - Aisles + ancillary:                  remainder'
  'Throughput:  400 000 shovels / yr  (1 819 / day)'
  'Takt time:   15.83 s   |   Headcount: 60'
)
for ($k=0; $k -lt $sumLines.Count; $k++) {
    [void](Add-Vertex -Value $sumLines[$k] -X $col3 -Y ($rowY + $k*22) -W 530 -H 22 -Style 'text;html=1;fontSize=11;align=left;verticalAlign=middle;fontFamily=Consolas;')
}

# Drawn-by box
$tbX = $M + 1574 - 320
$tbY = $lgY + 380 + 10
Add-Vertex -Value '' -X $tbX -Y $tbY -W 320 -H 80 -Style 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#1F4E79;strokeWidth=2;' | Out-Null
Add-Vertex -Value 'Drawn by: B. Smit (37300938)'              -X ($tbX+10) -Y ($tbY+6)  -W 300 -H 22 -Style 'text;html=1;fontSize=11;fontStyle=1;align=left;' | Out-Null
Add-Vertex -Value 'Module:   INGB 417 - Facility Design GA3'  -X ($tbX+10) -Y ($tbY+28) -W 300 -H 22 -Style 'text;html=1;fontSize=11;align=left;' | Out-Null
Add-Vertex -Value 'Date:     12 June 2026   |   Sheet 1 of 1' -X ($tbX+10) -Y ($tbY+50) -W 300 -H 22 -Style 'text;html=1;fontSize=11;align=left;' | Out-Null

# write file
$cellsXml = ($cells -join "`n        ")
$xml = @"
<mxfile host="Electron" type="device">
  <diagram name="MFP" id="digmore-mfp-a2">
    <mxGraphModel dx="2364" dy="1200" grid="1" gridSize="22" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1654" pageHeight="2339" math="0" shadow="0">
      <root>
        $cellsXml
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
"@

if (Test-Path $out) { Copy-Item $out ($out + '.bak') -Force }
Set-Content -Path $out -Value $xml -Encoding UTF8

try {
    $check = New-Object System.Xml.XmlDocument
    $check.Load($out)
    $v = $check.SelectNodes("//mxCell[@vertex='1']").Count
    $e = $check.SelectNodes("//mxCell[@edge='1']").Count
    Write-Host "OK.  Saved: $out"
    Write-Host "Cells: vertices=$v  edges=$e"
} catch {
    Write-Host "XML ERROR: $($_.Exception.Message)"
}
