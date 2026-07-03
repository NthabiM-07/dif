$f = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\INGB417-20251029T124012Z-1-001\INGB417\INGB417\GA3\GA Drawings.drawio"
"size: $((Get-Item $f).Length) bytes"
[xml]$d = Get-Content $f -Raw
"pages:"
$d.SelectNodes('//diagram') | ForEach-Object {
    $m = $_.SelectSingleNode('mxGraphModel')
    $w = if ($m) { $m.GetAttribute('pageWidth') } else { '?' }
    $h = if ($m) { $m.GetAttribute('pageHeight') } else { '?' }
    $cells = $_.SelectNodes('.//mxCell').Count
    "  id={0}  name='{1}'  page={2}x{3}  cells={4}" -f $_.id,$_.name,$w,$h,$cells
}
