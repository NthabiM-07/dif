# Recolour DigMore_Process_Flow_v5.drawio to North-West University (NWU) palette:
#   Primary  Purple : #4F2D7F   (NWU corporate purple)
#   Light    Purple : #E6E0EC   (lane tint / pale background)
#   Mid      Purple : #B8A6CC   (secondary accent)
#   Dark            : #231F20   (NWU "off-black")
#   Mid-grey        : #6E6E6E
#   Light-grey      : #D9D9D9
#   Page bg         : #FFFFFF
#
# What this does:
#   1. Repaint all 5 swim-lane background rectangles with NWU purple tints (-3 -5 -7 -9; lane -1 = title bar -> stays dark)
#   2. Repaint title-bar dark rectangle and title block stroke -> NWU purple
#   3. Repaint info-box stroke + heading -> NWU purple
#   4. Repaint all task / decision / inventory shapes -> white fill, NWU-purple stroke
#   5. Repaint all edges -> NWU dark grey
#   6. Keep "sheet/coil" branch edge as accent purple (so the choice still pops)
#   7. Keep scrap-removal black dots black (universal scrap convention)

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_v5.drawio"
$bak = $src + ".bak_nwu"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw
$prefix = "3NLaLxYXOWkIVqMw16MR-"

# NWU palette
$nwuPurple    = '#4F2D7F'
$nwuPurpleMid = '#B8A6CC'
$nwuPurpleLt  = '#E6E0EC'
$nwuDark      = '#231F20'
$nwuMidGrey   = '#6E6E6E'
$nwuLightGrey = '#D9D9D9'

# Lane tints (5 swimlanes, alternating to keep band-distinction)
$laneTints = @{
    '3' = '#F0EBF5'   # Receiving + raw storage (very pale purple)
    '5' = '#E6E0EC'   # Handle production (pale purple)
    '7' = '#F0EBF5'   # Head & hinge production
    '9' = '#E6E0EC'   # Subassembly finishing
}
# lane -1 is the dark navy title strip on left -> recolour to NWU purple
# powder-coat outline (-11) is the dashed rectangle around powder coat group

function SetStyle([string]$id,[string]$style) {
    $n = $doc.SelectSingleNode("//mxCell[@id='$prefix$id']")
    if ($n -ne $null) { $n.SetAttribute('style',$style) }
}

# --- 1. Lane backgrounds ---
SetStyle '1'  "rounded=1;arcSize=4;html=1;fillColor=$nwuPurple;strokeColor=$nwuDark;fontColor=#ffffff;"
SetStyle '3'  "rounded=1;arcSize=4;html=1;fillColor=$($laneTints['3']);strokeColor=none;fontColor=default;"
SetStyle '5'  "rounded=1;arcSize=4;html=1;fillColor=$($laneTints['5']);strokeColor=none;"
SetStyle '7'  "rounded=1;arcSize=4;html=1;fillColor=$($laneTints['7']);strokeColor=none;"
SetStyle '9'  "rounded=1;arcSize=4;html=1;fillColor=$($laneTints['9']);strokeColor=none;"

# Powder-coat enclosure outline -> NWU purple dashed
SetStyle '11' "rounded=0;html=1;dashed=1;dashPattern=7 4;fillColor=none;strokeColor=$nwuPurple;fontColor=$nwuPurple;strokeWidth=1.6;verticalAlign=bottom;align=left;spacingLeft=5;spacingBottom=2;fontStyle=2;fontSize=10;"

# --- 4. Repaint all tasks / decisions / inventory triangles / supplier circles ---
# Walk every vertex in the original ID range -12 .. -65 and rewrite stroke/fill consistently.
# Keep cells that should stay black-fill (scrap removal, dispatch small/large dots): -28 -43 -64 -65

$blackDots = @('28','43','64','65')

for ($i = 12; $i -le 65; $i++) {
    $cell = $doc.SelectSingleNode("//mxCell[@id='$prefix$i']")
    if ($cell -eq $null) { continue }
    $style = $cell.GetAttribute('style')
    if ([string]::IsNullOrEmpty($style)) { continue }

    if ($blackDots -contains "$i") {
        # Solid black scrap / dispatch dots
        if ($style -like '*ellipse*') {
            $cell.SetAttribute('style',"ellipse;whiteSpace=wrap;html=1;fillColor=$nwuDark;strokeColor=$nwuDark;fontColor=$nwuDark;strokeWidth=1.5;fontSize=10;verticalLabelPosition=bottom;verticalAlign=top;")
        }
        continue
    }

    # Build a new style preserving shape kind
    if ($style -like '*ellipse*') {
        # Supplier circles (-12 -13 -45 -58 -61) -> white fill, purple stroke
        $vlPos = 'top';   $vAlign = 'bottom'
        if ($style -like '*verticalLabelPosition=bottom*') { $vlPos='bottom'; $vAlign='top' }
        $new = "ellipse;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=$nwuPurple;fontColor=$nwuDark;strokeWidth=1.8;fontSize=10;verticalLabelPosition=$vlPos;verticalAlign=$vAlign;"
        $cell.SetAttribute('style',$new)
    }
    elseif ($style -like '*rhombus*') {
        $cell.SetAttribute('style',"rhombus;whiteSpace=wrap;html=1;fillColor=$nwuPurpleLt;strokeColor=$nwuPurple;fontColor=$nwuDark;strokeWidth=1.8;fontSize=11;fontStyle=1;")
    }
    elseif ($style -like '*triangle*') {
        # Inventory triangles
        $cell.SetAttribute('style',"triangle;direction=south;verticalLabelPosition=bottom;verticalAlign=top;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=$nwuMidGrey;fontColor=$nwuDark;strokeWidth=1.5;fontSize=10;")
    }
    elseif ($style -like '*rounded=0*' -and $style -notlike '*dashed=1*') {
        # Process tasks -> white card with NWU purple border + bold dark text
        $cell.SetAttribute('style',"rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=$nwuPurple;fontColor=$nwuDark;strokeWidth=1.8;fontSize=11;fontStyle=1;")
    }
}

# Lane labels (text overlays) -2 -4 -6 -8 -10 -> white if on dark lane (-2), else NWU purple
SetStyle '2'  "text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#FFFFFF;"
SetStyle '4'  "text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=$nwuPurple;"
SetStyle '6'  "text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=$nwuPurple;"
SetStyle '8'  "text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=$nwuPurple;"
SetStyle '10' "text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=$nwuPurple;"

# --- 5. Recolour every edge to NWU dark grey ---
$edges = $doc.SelectNodes("//mxCell[@edge='1']")
foreach ($e in $edges) {
    $s = $e.GetAttribute('style')
    if ([string]::IsNullOrEmpty($s)) { continue }

    # The "sheet/coil" diversion edge (id -71) keeps NWU purple accent
    if ($e.GetAttribute('id') -eq "${prefix}71") {
        $new = $s -replace 'strokeColor=#[0-9A-Fa-f]{6}',"strokeColor=$nwuPurple"
        $new = $new -replace 'fontColor=#[0-9A-Fa-f]{6}',"fontColor=$nwuPurple"
        $new = $new -replace 'strokeWidth=[\d\.]+','strokeWidth=2.2'
        $e.SetAttribute('style',$new)
        continue
    }

    $new = $s -replace 'strokeColor=#[0-9A-Fa-f]{6}',"strokeColor=$nwuDark"
    $new = $new -replace 'fontColor=#[0-9A-Fa-f]{6}',"fontColor=$nwuDark"
    $e.SetAttribute('style',$new)
}

# --- 2. Title bar + 3. Title block + 4. Info box repaint ---
# Title bar bg + texts (we know IDs from polish_v5.ps1 starting at 200):
#   200 = navy bar          -> NWU purple bar
#   201 = title text white  -> keep white
#   202 = subtitle white    -> keep white
#   203 = info box bg       -> light grey
#   204 = info heading      -> NWU purple
#   208 = title-block bg    -> white, NWU purple stroke
#   209 = "TITLE BLOCK"     -> NWU purple
SetStyle '200' "rounded=0;whiteSpace=wrap;html=1;fillColor=$nwuPurple;strokeColor=$nwuPurple;"
SetStyle '203' "rounded=0;whiteSpace=wrap;html=1;fillColor=$nwuLightGrey;strokeColor=$nwuPurple;strokeWidth=1.5;"
SetStyle '204' "text;html=1;fontSize=12;fontStyle=1;fontColor=$nwuPurple;align=left;"
SetStyle '208' "rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=$nwuPurple;strokeWidth=2;"
SetStyle '209' "text;html=1;fontSize=10;fontStyle=1;fontColor=$nwuPurple;align=left;"

# --- Save + validate ---
$doc.Save($src)

try {
    $c = New-Object System.Xml.XmlDocument; $c.Load($src)
    $v = $c.SelectNodes("//mxCell[@vertex='1']").Count
    $eC = $c.SelectNodes("//mxCell[@edge='1']").Count
    $orph = $c.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]").Count
    "OK.  vertices=$v  edges=$eC  orphan=$orph"
    "Saved : $src"
    "Backup: $bak"
} catch { "XML ERR: $($_.Exception.Message)" }
