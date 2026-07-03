$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_IE.drawio"
[xml]$doc = Get-Content $src -Raw
$m = $doc.SelectSingleNode('//mxGraphModel')
$m.SetAttribute('pageWidth','4700')
$m.SetAttribute('pageHeight','1150')
$doc.Save($src)
"Page now $($m.GetAttribute('pageWidth')) x $($m.GetAttribute('pageHeight'))"
