# Normalise every edge in DigMore_Process_Flow_IE.drawio (IE-style horizontal flow).
# Same treatment as v5: orthogonal routing, filled arrowheads, clean stroke, edges-behind-vertices.
# This file's IDs are STRINGS (recv, cut, head1...) not prefixed, so we operate on every edge.

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_IE.drawio"
$bak = $src + ".bak_arrows"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw

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

    # Stroke
    # Detect existing purple/orange accent edges and route them through NWU purple
    $existingColour = $h['strokeColor']
    $isAccent = $false
    if ($existingColour -ne $null -and ($existingColour -match '#(ED7D31|FF8C00|FFA500|7030A0|4F2D7F|9966CC)')) { $isAccent = $true }

    if ($isAccent) {
        $h['strokeColor'] = $nwuPurple
        $h['fontColor']   = $nwuPurple
        $h['strokeWidth'] = '2.4'
    } else {
        $h['strokeColor'] = $nwuDark
        $h['fontColor']   = $nwuDark
        $h['strokeWidth'] = '2'
    }

    # Labels
    $h['labelBackgroundColor'] = '#FFFFFF'
    $h['fontSize']  = '10'
    $h['fontStyle'] = '1'

    foreach ($k in 'exitDx','exitDy','entryDx','entryDy') {
        if ($h.Contains($k)) { $h[$k] = '0' }
    }

    $e.SetAttribute('style',(BuildStyle $h))

    # Reset geometry
    $g = $e.SelectSingleNode('mxGeometry')
    if ($g -ne $null) {
        $g.SetAttribute('relative','1')
        $g.SetAttribute('as','geometry')
        $arrs = $g.SelectNodes("Array[@as='points']")
        foreach ($a in $arrs) { $g.RemoveChild($a) | Out-Null }
    }

    $count++
}

# Push edges to render BEHIND vertices
$root = $doc.SelectSingleNode('//root')
$edgeNodes = @($root.SelectNodes("mxCell[@edge='1']"))
foreach ($en in $edgeNodes) { $root.RemoveChild($en) | Out-Null }
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
