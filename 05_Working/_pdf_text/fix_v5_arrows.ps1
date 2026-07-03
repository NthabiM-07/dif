# Normalise every edge in DigMore_Process_Flow_v5.drawio:
#   - edgeStyle=orthogonalEdgeStyle
#   - endArrow=classic, endFill=1, endSize=12   (proper filled arrowheads)
#   - startArrow=none
#   - strokeWidth=2 (accent edge -71 keeps 2.4)
#   - strokeColor=NWU dark (purple for accent edge -71)
#   - rounded=0, html=1, jettySize=auto, exitDx/exitDy/entryDx/entryDy=0
#   - labelBackgroundColor=#FFFFFF, fontSize=10, fontStyle=1
#   - drop edges behind vertices so arrowheads sit cleanly on the box border
#
# Also: force every edge's mxGeometry to relative=1 (drawio default for proper routing)
# and clear any stale absolute waypoints that may be making arrows look weird.

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_v5.drawio"
$bak = $src + ".bak_arrows"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw
$prefix = "3NLaLxYXOWkIVqMw16MR-"

$nwuPurple = '#4F2D7F'
$nwuDark   = '#231F20'

function ParseStyle([string]$s) {
    $h = [ordered]@{}
    foreach ($kv in ($s -split ';' | Where-Object { $_ -ne '' })) {
        $p = $kv -split '=',2
        if ($p.Count -eq 2) { $h[$p[0]] = $p[1] } else { $h[$p[0]] = '' }
    }
    return $h
}
function BuildStyle($h) {
    ($h.GetEnumerator() | ForEach-Object {
        if ($_.Value -eq '') { $_.Key } else { "$($_.Key)=$($_.Value)" }
    }) -join ';'
}

$edges = $doc.SelectNodes("//mxCell[@edge='1']")
$count = 0
foreach ($e in $edges) {
    $id = $e.GetAttribute('id')
    $isAccent = ($id -eq "${prefix}71")     # sheet/coil branch

    $h = ParseStyle ($e.GetAttribute('style'))

    # Routing
    $h['edgeStyle']  = 'orthogonalEdgeStyle'
    $h['rounded']    = '0'
    $h['html']       = '1'
    $h['jettySize']  = 'auto'
    $h['orthogonalLoop'] = '1'

    # Arrowheads
    $h['endArrow']   = 'classic'
    $h['endFill']    = '1'
    $h['endSize']    = '12'
    $h['startArrow'] = 'none'
    $h['startFill']  = '0'

    # Stroke / colour
    if ($isAccent) {
        $h['strokeColor'] = $nwuPurple
        $h['fontColor']   = $nwuPurple
        $h['strokeWidth'] = '2.4'
    } else {
        $h['strokeColor'] = $nwuDark
        $h['fontColor']   = $nwuDark
        $h['strokeWidth'] = '2'
    }

    # Labels readable
    $h['labelBackgroundColor'] = '#FFFFFF'
    $h['fontSize']  = '10'
    $h['fontStyle'] = '1'

    # Connection-point dx/dy = 0 (clean snap)
    foreach ($k in 'exitDx','exitDy','entryDx','entryDy') {
        if ($h.Contains($k)) { $h[$k] = '0' }
    }

    $e.SetAttribute('style',(BuildStyle $h))

    # Ensure relative geometry, drop any cached absolute points/array waypoints
    $g = $e.SelectSingleNode('mxGeometry')
    if ($g -ne $null) {
        $g.SetAttribute('relative','1')
        $g.SetAttribute('as','geometry')
        # Strip waypoint Arrays (cached bends) so router re-computes cleanly
        $arrs = $g.SelectNodes("Array[@as='points']")
        foreach ($a in $arrs) { $g.RemoveChild($a) | Out-Null }
    }

    $count++
}

# Push edges to render BEHIND vertices: in drawio, later-appended cells render on top,
# so move every edge cell to the FRONT of <root> (rendered first = behind).
$root = $doc.SelectSingleNode('//root')
$edgeNodes = @($root.SelectNodes("mxCell[@edge='1']"))
# Find first vertex cell to insert edges before
$firstVertex = $root.SelectSingleNode("mxCell[@vertex='1']")
foreach ($en in $edgeNodes) {
    $root.RemoveChild($en) | Out-Null
}
# Re-insert edges right after id=1 (the default parent) so they sit before vertices
$parentCell = $root.SelectSingleNode("mxCell[@id='1']")
$insertAfter = $parentCell
foreach ($en in $edgeNodes) {
    $root.InsertAfter($en,$insertAfter) | Out-Null
    $insertAfter = $en
}

$doc.Save($src)

try {
    $c = New-Object System.Xml.XmlDocument; $c.Load($src)
    $v = $c.SelectNodes("//mxCell[@vertex='1']").Count
    $eC = $c.SelectNodes("//mxCell[@edge='1']").Count
    $orph = $c.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]").Count
    "OK.  edges-normalised=$count  vertices=$v  edges=$eC  orphan=$orph"
    "Saved : $src"
    "Backup: $bak"
} catch { "XML ERR: $($_.Exception.Message)" }
