# Restore the immediate predecessor of Process.drawio (= v5.drawio.bak_arrows snapshot)
# as Process_PREV.drawio, then run the arrow-normalisation pass so arrows show clearly.

$dir = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow"
$src = Join-Path $dir "DigMore_Process_Flow_v5.drawio.bak_arrows"
$dst = Join-Path $dir "Process_PREV.drawio"

Copy-Item -LiteralPath $src -Destination $dst -Force
Write-Host "Copied predecessor -> $dst"

$prefix    = "3NLaLxYXOWkIVqMw16MR-"
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

[xml]$doc = Get-Content -LiteralPath $dst -Raw
$edges = $doc.SelectNodes("//mxCell[@edge='1']")
$count = 0

foreach ($e in $edges) {
    $id = $e.GetAttribute('id')
    $isAccent = ($id -eq "${prefix}71")

    $h = ParseStyle ($e.GetAttribute('style'))

    $h['edgeStyle']       = 'orthogonalEdgeStyle'
    $h['rounded']         = '0'
    $h['html']            = '1'
    $h['jettySize']       = 'auto'
    $h['orthogonalLoop']  = '1'

    $h['endArrow']        = 'classic'
    $h['endFill']         = '1'
    $h['endSize']         = '12'
    $h['startArrow']      = 'none'
    $h['startFill']       = '0'

    if ($isAccent) {
        $h['strokeColor'] = $nwuPurple
        $h['fontColor']   = $nwuPurple
        $h['strokeWidth'] = '2.4'
    } else {
        $h['strokeColor'] = $nwuDark
        $h['fontColor']   = $nwuDark
        $h['strokeWidth'] = '2'
    }

    $h['labelBackgroundColor'] = '#FFFFFF'
    $h['fontSize']  = '10'
    $h['fontStyle'] = '1'

    foreach ($k in 'exitDx','exitDy','entryDx','entryDy') {
        if ($h.Contains($k)) { $h[$k] = '0' }
    }

    $e.SetAttribute('style',(BuildStyle $h))

    $g = $e.SelectSingleNode('mxGeometry')
    if ($g -ne $null) {
        $g.SetAttribute('relative','1')
        $g.SetAttribute('as','geometry')
        $arrs = $g.SelectNodes("Array[@as='points']")
        foreach ($a in $arrs) { $g.RemoveChild($a) | Out-Null }
    }
    $count++
}

# Push edges behind vertices: drawio renders later-appended cells on top.
$root = $doc.SelectSingleNode('//root')
$edgeNodes = @($root.SelectNodes("mxCell[@edge='1']"))
foreach ($en in $edgeNodes) { $root.RemoveChild($en) | Out-Null }
$parentCell = $root.SelectSingleNode("mxCell[@id='1']")
$insertAfter = $parentCell
foreach ($en in $edgeNodes) {
    $root.InsertAfter($en,$insertAfter) | Out-Null
    $insertAfter = $en
}

$doc.Save($dst)

$check = New-Object System.Xml.XmlDocument
$check.Load($dst)
$v = $check.SelectNodes("//mxCell[@vertex='1']").Count
$eC = $check.SelectNodes("//mxCell[@edge='1']").Count
$orph = $check.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]").Count
Write-Host "OK. edges-normalised=$count  vertices=$v  edges=$eC  orphan=$orph"
Write-Host "Output: $dst"
