# Fix arrows/pointers in DigMore_Process_Flow_IE.drawio
# Root cause: while editing, several edges got reattached to the big invisible
# "border" rectangle, two duplicate arrows were created, and colours got
# inconsistent (green / blue / black mixed).
#
# Fixes applied:
#   1. e7  ("middle"): source border -> tubedec   (restore correct origin)
#   2. e11 ("head"  ): source border -> sheetdec  (restore correct origin)
#   3. Delete duplicate strays DaoX9zk54HpWAwACf5M0-1 and -2 (both target border)
#   4. Delete the giant "border" rectangle entirely - it's an invisible click
#      magnet causing arrows to snap to it.  The page outline frames the diagram.
#   5. Normalise every edge stroke colour to black #000 (was green / blue / mixed)
#      and remove the stray fillColor attributes that don't apply to lines.

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_IE.drawio"
$bak = $src + ".bak2"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw
$root = $doc.SelectSingleNode('//root')

function Cell($id) { $doc.SelectSingleNode("//mxCell[@id='$id']") }

# --- 1 + 2. Restore broken sources ---------------------------------
$e7 = Cell 'e7'
if ($e7 -and $e7.GetAttribute('source') -eq 'border') { $e7.SetAttribute('source','tubedec'); Write-Host "OK: e7 source border -> tubedec" }
$e11 = Cell 'e11'
if ($e11 -and $e11.GetAttribute('source') -eq 'border') { $e11.SetAttribute('source','sheetdec'); Write-Host "OK: e11 source border -> sheetdec" }

# --- 3. Delete stray duplicate edges --------------------------------
foreach ($id in @('DaoX9zk54HpWAwACf5M0-1','DaoX9zk54HpWAwACf5M0-2')) {
    $c = Cell $id
    if ($c) { $c.ParentNode.RemoveChild($c) | Out-Null; Write-Host "OK: removed stray edge $id" }
}

# --- 4. Delete the invisible "border" rectangle ---------------------
$b = Cell 'border'
if ($b) { $b.ParentNode.RemoveChild($b) | Out-Null; Write-Host "OK: removed invisible 'border' rectangle" }

# --- 5. Normalise edge colours to black, drop bogus fillColor on edges ---
$edges = $doc.SelectNodes("//mxCell[@edge='1']")
$colourFixed = 0
foreach ($e in $edges) {
    $style = $e.GetAttribute('style')
    if ([string]::IsNullOrEmpty($style)) { continue }
    $orig = $style
    # any strokeColor -> #000
    $style = [regex]::Replace($style, 'strokeColor=#[0-9A-Fa-f]{3,8}', 'strokeColor=#000')
    # drop fillColor= (irrelevant to lines, was bleeding into arrowheads)
    $style = [regex]::Replace($style, 'fillColor=#[0-9A-Fa-f]{3,8};?', '')
    # drop fillColor=none too on edges
    $style = [regex]::Replace($style, 'fillColor=none;?', '')
    if ($style -ne $orig) {
        $e.SetAttribute('style', $style)
        $colourFixed++
    }
}
Write-Host ("OK: normalised colour on $colourFixed edges (all strokes now #000, fillColor removed)")

# --- Save ----------------------------------------------------------
$doc.Save($src)

# --- Validate ------------------------------------------------------
try {
    $d2 = New-Object System.Xml.XmlDocument; $d2.Load($src)
    $v = $d2.SelectNodes("//mxCell[@vertex='1']").Count
    $eAll = $d2.SelectNodes("//mxCell[@edge='1']").Count
    $bad = $d2.SelectNodes("//mxCell[@edge='1' and (@source='border' or @target='border')]").Count
    Write-Host ""
    Write-Host ("XML OK.  vertices=$v  edges=$eAll  edges-touching-border=$bad")
    Write-Host ("Saved:  $src")
    Write-Host ("Backup: $bak")
} catch {
    Write-Host ("XML ERR: " + $_.Exception.Message)
}
