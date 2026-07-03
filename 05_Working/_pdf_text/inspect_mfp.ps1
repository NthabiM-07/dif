$f = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\INGB417-20251029T124012Z-1-001\INGB417\INGB417\GA3\GA Drawings.drawio"
$out = "C:\temp\ga_mfp_structure.txt"
[xml]$d = Get-Content $f -Raw
$mfp = $d.SelectSingleNode("//diagram[@name='MFP']")
$m = $mfp.SelectSingleNode('mxGraphModel')

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("MFP page: $($m.GetAttribute('pageWidth')) x $($m.GetAttribute('pageHeight'))")
$lines.Add("")

# Group A: cells with non-empty label (zones / titles / annotations)
$lines.Add("=== LABELLED VERTICES (value != '') ===")
$labelled = $mfp.SelectNodes(".//mxCell[@vertex='1' and string(@value) != '']")
$lines.Add("count: $($labelled.Count)")
foreach ($c in $labelled) {
    $g = $c.SelectSingleNode('mxGeometry')
    if (-not $g) { continue }
    $x = [int]([double]($g.GetAttribute('x') -as [string]))
    $y = [int]([double]($g.GetAttribute('y') -as [string]))
    $w = [int]([double]($g.GetAttribute('width') -as [string]))
    $h = [int]([double]($g.GetAttribute('height') -as [string]))
    $v = ($c.GetAttribute('value') -replace '<[^>]+>',' ' -replace '\s+',' ').Trim()
    if ($v.Length -gt 90) { $v = $v.Substring(0,90)+'...' }
    $lines.Add(("({0,5},{1,5}) {2,5}x{3,-5}  {4}" -f $x,$y,$w,$h,$v))
}

$lines.Add("")
$lines.Add("=== LARGE UNLABELLED RECTS (w>=300 and h>=200, no label) ===")
$big = $mfp.SelectNodes(".//mxCell[@vertex='1' and (not(@value) or @value='')]") | Where-Object {
    $g = $_.SelectSingleNode('mxGeometry')
    if (-not $g) { return $false }
    $w = [double]($g.GetAttribute('width')); $h = [double]($g.GetAttribute('height'))
    ($w -ge 300 -and $h -ge 200)
}
foreach ($c in $big) {
    $g = $c.SelectSingleNode('mxGeometry')
    $x = [int]([double]$g.GetAttribute('x'))
    $y = [int]([double]$g.GetAttribute('y'))
    $w = [int]([double]$g.GetAttribute('width'))
    $h = [int]([double]$g.GetAttribute('height'))
    $s = $c.GetAttribute('style')
    if ($s -and $s.Length -gt 70) { $s = $s.Substring(0,70)+'...' }
    $lines.Add(("({0,5},{1,5}) {2,5}x{3,-5}  style={4}" -f $x,$y,$w,$h,$s))
}

$lines.Add("")
$lines.Add("=== DISTINCT FILL COLOURS USED ===")
$fills = @{}
$mfp.SelectNodes(".//mxCell[@vertex='1']") | ForEach-Object {
    $s = $_.GetAttribute('style')
    if ($s -match 'fillColor=([^;]+)') {
        $key = $matches[1]
        if (-not $fills.ContainsKey($key)) { $fills[$key] = 0 }
        $fills[$key]++
    }
}
$fills.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object {
    $lines.Add(("  {0,-10}  used {1} times" -f $_.Key, $_.Value))
}

Set-Content -Path $out -Value $lines -Encoding UTF8
"wrote $out -- $($lines.Count) lines"
