# Flip z-order on Process_PREV.drawio: move all edges AFTER the vertices
# so drawio renders arrows ON TOP of the boxes.

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\Process_PREV.drawio"

[xml]$doc = Get-Content -LiteralPath $src -Raw
$root = $doc.SelectSingleNode('//root')
$edges = @($root.SelectNodes("mxCell[@edge='1']"))

# Remove all edges then append them at the end (rendered last = on top)
foreach ($e in $edges) { $root.RemoveChild($e) | Out-Null }
foreach ($e in $edges) { $root.AppendChild($e) | Out-Null }

$doc.Save($src)
Write-Host ("Z-order flipped on {0} edges -> arrows now on top." -f $edges.Count)
