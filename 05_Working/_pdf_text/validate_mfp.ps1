$f = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP.drawio"
try {
    [xml]$x = Get-Content $f -Raw
    Write-Host "XML OK"
    Write-Host ("Pages: " + $x.mxfile.diagram.Count)
    foreach ($d in $x.mxfile.diagram) {
        $cellCount = $d.mxGraphModel.root.mxCell.Count
        Write-Host ("  - " + $d.name + " size=" + $d.mxGraphModel.pageWidth + "x" + $d.mxGraphModel.pageHeight + " cells=" + $cellCount)
    }
} catch {
    Write-Host ("XML ERROR: " + $_.Exception.Message)
}
