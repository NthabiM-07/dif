# Polish DigMore_Process_Flow_v5.drawio:
#   1. Resize page to A2 landscape (3300 x 2339)
#   2. Add navy title bar (top)
#   3. Add title block (bottom-right)
#   4. Add throughput / takt info box
#   5. Move the 2 supplier circles outside the Receiving lane
#   6. Bump dispatch black-dot sinks to 40 px

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_v5.drawio"
$bak = $src + ".bak2"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw
$prefix = "3NLaLxYXOWkIVqMw16MR-"
function Cell([string]$n) { return $doc.SelectSingleNode("//mxCell[@id='$prefix$n']") }

# --- 1. Resize page ---
$m = $doc.SelectSingleNode('//mxGraphModel')
$m.SetAttribute('pageWidth','3300')
$m.SetAttribute('pageHeight','2339')

# --- 5. Move supplier circles outside the lane ---
# Lane 1 starts at x=330; circles were at x=367. Move to x=240 (outside).
$tube  = Cell '12'
$sheet = Cell '13'
$gT = $tube.SelectSingleNode('mxGeometry');  $gT.SetAttribute('x','240')
$gS = $sheet.SelectSingleNode('mxGeometry'); $gS.SetAttribute('x','240')

# --- 6. Resize dispatch dots ---
foreach ($n in '64','65') {
    $c = Cell $n
    $g = $c.SelectSingleNode('mxGeometry')
    $g.SetAttribute('width','40')
    $g.SetAttribute('height','40')
}

# --- Helper to append a new vertex ---
$root = $doc.SelectSingleNode('//root')
$nextN = 200
function Add-V([string]$value,[int]$x,[int]$y,[int]$w,[int]$h,[string]$style) {
    $id = "$prefix$($script:nextN)"; $script:nextN++
    $e = $doc.CreateElement('mxCell')
    $e.SetAttribute('id',$id)
    $e.SetAttribute('value',$value)
    $e.SetAttribute('style',$style)
    $e.SetAttribute('vertex','1')
    $e.SetAttribute('parent','1')
    $g = $doc.CreateElement('mxGeometry')
    $g.SetAttribute('x',"$x"); $g.SetAttribute('y',"$y")
    $g.SetAttribute('width',"$w"); $g.SetAttribute('height',"$h")
    $g.SetAttribute('as','geometry')
    $e.AppendChild($g) | Out-Null
    $script:root.AppendChild($e) | Out-Null
}

# --- 2. Navy title bar (top, full width) ---
Add-V '' 40 30 3220 90 'rounded=0;whiteSpace=wrap;html=1;fillColor=#1F4E79;strokeColor=#1F4E79;'
Add-V 'DigMore Folding Mini Shovel - Process Flow Chart' 60 40 3180 38 'text;html=1;fontColor=#FFFFFF;fontSize=24;fontStyle=1;align=center;verticalAlign=middle;strokeColor=none;fillColor=none;'
Add-V 'Figure 7.1  |  Project: INGB 417 GA3  |  Drawing No. PFC-01  |  Sheet 1 of 1' 60 82 3180 28 'text;html=1;fontColor=#FFFFFF;fontSize=12;align=center;verticalAlign=middle;strokeColor=none;fillColor=none;'

# --- 4. Throughput info box (top-left of plan area, below title) ---
Add-V '' 40 140 540 90 'rounded=0;whiteSpace=wrap;html=1;fillColor=#F2F2F2;strokeColor=#1F4E79;strokeWidth=1.5;'
Add-V 'Throughput & balancing' 50 144 520 22 'text;html=1;fontSize=12;fontStyle=1;fontColor=#1F4E79;align=left;'
Add-V '400 000 shovels / year   |   1 819 / day' 50 168 520 20 'text;html=1;fontSize=11;align=left;fontFamily=Consolas;'
Add-V 'Takt time: 15.83 s   |   Headcount: 60' 50 188 520 20 'text;html=1;fontSize=11;align=left;fontFamily=Consolas;'
Add-V 'Bottleneck: Blade sharpening (2 min / shovel) - 8 grinders' 50 208 520 20 'text;html=1;fontSize=11;align=left;fontFamily=Consolas;'

# --- 3. Title block (bottom-right) ---
$tbX = 2940; $tbY = 2200
Add-V '' $tbX $tbY 320 110 'rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#1F4E79;strokeWidth=2;'
Add-V 'TITLE BLOCK' ($tbX+10) ($tbY+6) 300 18 'text;html=1;fontSize=10;fontStyle=1;fontColor=#1F4E79;align=left;'
Add-V 'Drawn by:    B. Smit (37300938)'              ($tbX+10) ($tbY+26) 300 20 'text;html=1;fontSize=11;fontStyle=1;align=left;'
Add-V 'Module:      INGB 417 - Facility Design GA3'  ($tbX+10) ($tbY+46) 300 20 'text;html=1;fontSize=11;align=left;'
Add-V 'Date:        12 June 2026'                    ($tbX+10) ($tbY+66) 300 20 'text;html=1;fontSize=11;align=left;'
Add-V 'Scale: NTS  |  Sheet 1 of 1  |  Rev: A'       ($tbX+10) ($tbY+86) 300 20 'text;html=1;fontSize=11;align=left;'

# --- Save ---
$doc.Save($src)

try {
    $c = New-Object System.Xml.XmlDocument; $c.Load($src)
    $v = $c.SelectNodes("//mxCell[@vertex='1']").Count
    $e = $c.SelectNodes("//mxCell[@edge='1']").Count
    $orph = $c.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]").Count
    "OK.  page=$($m.GetAttribute('pageWidth')) x $($m.GetAttribute('pageHeight'))  vertices=$v  edges=$e  orphan=$orph"
    "Saved:  $src"
    "Backup: $bak"
} catch { "XML ERR: $($_.Exception.Message)" }
