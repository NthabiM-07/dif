# Fix structural flaws in DigMore_Process_Flow_v4_1.drawio
$f = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\DigMore_Process_Flow_v4_1.drawio"
$bak = $f + ".bak"
Copy-Item $f $bak -Force

$t = Get-Content $f -Raw -Encoding UTF8

# --- 1) Fix head-finishing sequence ---------------------------------------
# Geometry order (left to right): head1, head2, head3, head4
# Required process order:         Stamp -> Shape -> Sharpen -> Serrate
# Current labels are              Stamp -> Sharpen -> Serrate -> Shape  (WRONG)
# So we need head2 = Shape, head3 = Sharpen, head4 = Serrate

$old_head2 = '<mxCell id="head2" value="Sharpen blade edge&#10;(2 min per shovel)"'
$new_head2 = '<mxCell id="head2" value="Shape / bend shovel head&#10;(2 s per head)"'

$old_head3 = '<mxCell id="head3" value="Serrate blade edge&#10;(1 min per shovel)"'
$new_head3 = '<mxCell id="head3" value="Sharpen blade edge&#10;(2 min per shovel)"'

$old_head4 = '<mxCell id="head4" value="Shape / bend shovel head&#10;(2 s per head)"'
$new_head4 = '<mxCell id="head4" value="Serrate blade edge&#10;(1 min per shovel)"'

# The file uses literal "\n" newline char (chr 10) inside value="...". Try both.
function TrySwap([string]$content, [string]$old, [string]$new, [string]$tag) {
    if ($content.Contains($old)) {
        Write-Host "OK swap: $tag"
        return $content.Replace($old, $new)
    }
    # try with explicit LF char swap
    $oldNL = $old.Replace('&#10;', "`n")
    $newNL = $new.Replace('&#10;', "`n")
    if ($content.Contains($oldNL)) {
        Write-Host "OK swap (LF): $tag"
        return $content.Replace($oldNL, $newNL)
    }
    Write-Host "MISS: $tag"
    return $content
}

$t = TrySwap $t $old_head2 $new_head2 "head2 -> Shape"
$t = TrySwap $t $old_head3 $new_head3 "head3 -> Sharpen"
$t = TrySwap $t $old_head4 $new_head4 "head4 -> Serrate"

# --- 2) Resize the page so content fits ----------------------------------
# Original: pageWidth="1169" pageHeight="826"
# New:      pageWidth="4500" pageHeight="900"
$t = $t.Replace('pageWidth="1169" pageHeight="826"', 'pageWidth="4500" pageHeight="900"')
Write-Host "OK page resized to 4500x900"

# --- 3) Add missing START -> in_raw connector ----------------------------
# Find the existing 'start' text cell and add a connector edge to in_raw.
# Insert a new edge cell just before the in_raw cell.
$startEdge = '<mxCell id="e_start" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#000000;strokeWidth=1.4;endArrow=classic;endFill=1;exitX=0.5;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="start" target="in_raw"><mxGeometry relative="1" as="geometry"/></mxCell>'

# Insert the new edge right before the <mxCell id="rms" cell, so it sits next
# to the START + in_raw nodes in the XML.
$anchor = '<mxCell id="rms"'
if ($t.Contains($anchor)) {
    $t = $t.Replace($anchor, $startEdge + $anchor)
    Write-Host "OK START->in_raw connector inserted"
} else {
    Write-Host "MISS: rms anchor not found"
}

# --- 4) Move 'start' text closer to in_raw so the new edge looks tidy ---
# Original: x="40" y="150" width="80" height="24"
# in_raw is at x="80" y="282" w="28" h="28" (centre x ~= 94)
# Place START centred above in_raw: x=54 y=240 w=80 h=24, centre 94 - good.
$t = $t.Replace('<mxCell id="start" value="START" style="text;html=1;align=center;fontSize=14;fontStyle=1;fontColor=#000000;" vertex="1" parent="1"><mxGeometry x="40" y="150" width="80" height="24" as="geometry"/></mxCell>',
                '<mxCell id="start" value="START" style="text;html=1;align=center;fontSize=14;fontStyle=1;fontColor=#000000;" vertex="1" parent="1"><mxGeometry x="54" y="240" width="80" height="24" as="geometry"/></mxCell>')
Write-Host "OK START text repositioned above in_raw"

# --- Save and validate ---------------------------------------------------
Set-Content -Path $f -Value $t -Encoding UTF8 -NoNewline
Write-Host ""
Write-Host "Saved: $f"
Write-Host "Backup: $bak"

try {
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($f)
    $cells = $doc.SelectNodes('//mxCell')
    $edges = $doc.SelectNodes("//mxCell[@edge='1']")
    $vertices = $doc.SelectNodes("//mxCell[@vertex='1']")
    Write-Host ("XML OK. cells=" + $cells.Count + " vertices=" + $vertices.Count + " edges=" + $edges.Count)
} catch {
    Write-Host ("XML ERR: " + $_.Exception.Message)
}
