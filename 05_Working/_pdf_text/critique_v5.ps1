$f = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_v5.drawio"
[xml]$d = Get-Content $f -Raw
$m = $d.SelectSingleNode('//mxGraphModel')
"page: $($m.GetAttribute('pageWidth')) x $($m.GetAttribute('pageHeight'))"
$v = $d.SelectNodes("//mxCell[@vertex='1']").Count
$e = $d.SelectNodes("//mxCell[@edge='1']").Count
$orphan = $d.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]")
"vertices=$v  edges=$e  orphan-edges=$($orphan.Count)"

# Find duplicate-target edges
$tgts = @{}
$d.SelectNodes("//mxCell[@edge='1' and @target]") | ForEach-Object {
    $k = "$($_.GetAttribute('source')) -> $($_.GetAttribute('target'))"
    if ($tgts.ContainsKey($k)) { $tgts[$k]++ } else { $tgts[$k] = 1 }
}
"`nduplicate src->tgt pairs:"
$tgts.GetEnumerator() | Where-Object { $_.Value -gt 1 } | ForEach-Object { "  $($_.Key)  x$($_.Value)" }

"`norphan edges:"
foreach ($o in $orphan) {
    "  id=$($o.GetAttribute('id'))  src='$($o.GetAttribute('source'))'  tgt='$($o.GetAttribute('target'))'  lbl='$($o.GetAttribute('value'))'"
}
