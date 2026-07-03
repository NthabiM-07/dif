# Fix Untitled Diagram.drawio -> ready for report Section 7 (Process Flow)
# Issues found:
#   1. Head finishing sequence is WRONG: cells label order is Stamp -> Sharpen -> Serrate -> Shape.
#      Per report 6.3.5-6.3.10 + workbook Capacity sheet rows 5-8, it must be:
#      Stamp -> Shape -> Sharpen -> Serrate.  Fix by swapping the labels in cells 32, 34, 36.
#   2. Edge 81 (5% scrap from Cut handle) has no target -> orphan arrow.  Wire it to cell 27 (Scrap storage in Handle lane).
#   3. Edge 99 connects from the SWIM-LANE container (cell 5) to the Rivet station (cell 44) -- meaningless;
#      a proper edge already exists (edge 98: WIP shaped heads -> Rivet).  Delete edge 99.
#   4. Page is 850 x 1100 (A4 portrait) but content spans 1900 x 1800.  Resize page so the diagram fits one page.
#   5. Cosmetic: rename diagram tab from "Page-1" to "Process Flow" and rename the file to "Process_Flow_v5.drawio".

$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\Untitled Diagram.drawio"
$dst = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.3_Process_Flow\DigMore_Process_Flow_v5.drawio"
$bak = $src + ".bak"
Copy-Item $src $bak -Force

[xml]$doc = Get-Content $src -Raw

# Helper: find cell by id suffix (full id is 3NLaLxYXOWkIVqMw16MR-NN)
$prefix = "3NLaLxYXOWkIVqMw16MR-"
function GetCell($n) {
    return $doc.SelectSingleNode("//mxCell[@id='$prefix$n']")
}

# --- Fix 1: head finishing sequence -----------------------------------
# Current labels (left to right by geometric x):
#   32 (x=850) = "Sharpen blade (2 min per shovel)"
#   34 (x=1100) = "Serrate blade edge (1 min per shovel)"
#   36 (x=1350) = "Shape / bend head (2 s per head)"
# Required labels at the same positions:
#   32 -> "Shape / bend head (2 s per head)"
#   34 -> "Sharpen blade (2 min per shovel)"
#   36 -> "Serrate blade edge (1 min per shovel)"
#
# Also rename the WIP buffers downstream of each so they match:
#   33 "WIP sharpened heads"  -> "WIP shaped heads"
#   35 "WIP serrated heads"   -> "WIP sharpened heads"
#   37 "WIP shaped heads"     -> "WIP serrated heads"

(GetCell 32).SetAttribute('value', 'Shape / bend head<br>(2 s per head)')
(GetCell 34).SetAttribute('value', 'Sharpen blade<br>(2 min per shovel)')
(GetCell 36).SetAttribute('value', 'Serrate blade edge<br>(1 min per shovel)')
(GetCell 33).SetAttribute('value', 'WIP shaped<br>heads')
(GetCell 35).SetAttribute('value', 'WIP sharpened<br>heads')
(GetCell 37).SetAttribute('value', 'WIP serrated<br>heads')
Write-Host "OK: head finishing sequence relabelled (Stamp -> Shape -> Sharpen -> Serrate)"

# --- Fix 2: wire orphan scrap edge -----------------------------------
$e81 = GetCell 81
if ($e81 -and (-not $e81.HasAttribute('target') -or [string]::IsNullOrEmpty($e81.GetAttribute('target')))) {
    $e81.SetAttribute('target', "$prefix" + '27')
    Write-Host "OK: edge 81 (5% scrap from Cut handle) wired to Scrap storage (cell 27)"
} else {
    Write-Host "SKIP: edge 81 already wired"
}

# --- Fix 3: remove duplicate/meaningless edge 99 (lane container -> Rivet) ---
$e99 = GetCell 99
if ($e99) {
    $e99.ParentNode.RemoveChild($e99) | Out-Null
    Write-Host "OK: edge 99 (lane-container -> Rivet) removed"
}

# --- Fix 4: resize page ----------------------------------------------
$model = $doc.SelectSingleNode('//mxGraphModel')
$model.SetAttribute('pageWidth', '1920')
$model.SetAttribute('pageHeight', '1800')
Write-Host "OK: page resized to 1920 x 1800"

# --- Fix 5: tidy diagram name ----------------------------------------
$d = $doc.SelectSingleNode('//diagram')
$d.SetAttribute('name', 'Process Flow')

# --- Save to new path (do not clobber the user's Untitled Diagram source) ---
$dstDir = Split-Path $dst -Parent
if (-not (Test-Path $dstDir)) { New-Item -Path $dstDir -ItemType Directory | Out-Null }
$doc.Save($dst)
Write-Host ""
Write-Host ("Saved: " + $dst)
Write-Host ("Backup of original: " + $bak)

# --- Validate --------------------------------------------------------
try {
    $doc2 = New-Object System.Xml.XmlDocument
    $doc2.Load($dst)
    $cells = $doc2.SelectNodes('//mxCell')
    $edges = $doc2.SelectNodes("//mxCell[@edge='1']")
    $vertices = $doc2.SelectNodes("//mxCell[@vertex='1']")
    $orphans = $doc2.SelectNodes("//mxCell[@edge='1' and (not(@source) or not(@target) or @source='' or @target='')]")
    Write-Host ("XML OK. cells=" + $cells.Count + " vertices=" + $vertices.Count + " edges=" + $edges.Count + " orphan-edges=" + $orphans.Count)
} catch {
    Write-Host ("XML ERR: " + $_.Exception.Message)
}
