# Build a single combined PDF:
#   Page 1: MFP (landscape, full-bleed)
#   Pages 2..14: each workstation C1..C13 (portrait) with caption + description + drawing
# Uses Word COM to compose, then SaveAs2 with wdFormatPDF = 17.

$wsDir = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\workstations'
$mfp   = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_Final.png'
$outPdf  = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_and_Workstations.pdf'
$outDocx = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_and_Workstations.docx'

# Workstation metadata: number, file pattern, title, description (from Appendix C)
$stations = @(
    @{ N = 1;  File = 'C1_Tube_Cutting.png';        Title = 'Tube Cutting Workstation';
       Dim = '3 cells x 9.0 m x 2.0 m';
       Desc = 'Three parallel cells. The automatic saw is fed directly from the 6 m tube rack face; the operator stands on the loading side and transfers cut sections to a labelled back / middle bin. A scrap bin sits at the saw outfeed. Forklift access is from the rack face only; the operator aisle is clear of forklift traffic.' }
    @{ N = 2;  File = 'C2_Internal_Threading.png';  Title = 'Internal Threading Workstation';
       Dim = '2 cells x 3.0 m x 2.0 m';
       Desc = 'Two bench cells. The tapping machine is operated with a reaction arm. A swarf bin sits beside the machine; WIP-in and WIP-out bins are at bench height on either side. Task lighting supplements the overhead light.' }
    @{ N = 3;  File = 'C3_Grip_End_Forming.png';    Title = 'Grip-End Forming Workstation';
       Dim = '1 cell x 3.0 m x 2.0 m';
       Desc = 'Single cell. The tube end former narrows one end of the back-handle section. Two-position loading reduces the operator reach; a guarded forming area protects the operator.' }
    @{ N = 4;  File = 'C4_Knurling_Bank.png';       Title = 'Knurling and External Threading Bank';
       Dim = '5 machines, 8.4 m x 4.4 m bank';
       Desc = 'Five thread-rolling machines arranged in a row. A full-length inbound buffer protects the bank from starvation (99.7 % utilisation - binding constraint). Elbow-height loading reduces fatigue; coolant/mist extraction runs across the back of the bank.' }
    @{ N = 5;  File = 'C5_Press_Cell.png';          Title = 'Sheet-Metal Press Cell';
       Dim = '2 presses, 6.4 m x 4.0 m';
       Desc = 'Two gap-frame presses sharing one sheet-staging area. Each press has its own blank-out bin (head-blank and hinge-blank). One skeleton-scrap bin is shared. Light curtains guard the operator; a die-change access aisle is provided behind.' }
    @{ N = 6;  File = 'C6_Hinge_Bending.png';       Title = 'Hinge Bending Workstation';
       Dim = '1 cell x 3.4 m x 2.5 m';
       Desc = 'Single cell. A small electric press brake bends the hinge connector to the riveting geometry. WIP-in is fed directly from the press cell; WIP-out feeds the riveting station.' }
    @{ N = 7;  File = 'C7_Head_Shaping.png';        Title = 'Shovel-Head Shaping Workstation';
       Dim = '1 cell x 3.0 m x 2.0 m';
       Desc = 'Single cell. A forming press shapes the stamped shovel head to its final form before sharpening.' }
    @{ N = 8;  File = 'C8_Riveting.png';            Title = 'Riveting Workstation';
       Dim = '1 cell x 3.7 m x 2.6 m';
       Desc = 'Single cell. The radial riveting machine joins the bent hinge connector to the shaped shovel head. Two WIP-in bins (head + hinge) sit on either side of the operator; the WIP-out bin holds the assembled head sub-assembly. Two-hand control protects the operator.' }
    @{ N = 9;  File = 'C9_Sharpening_Bank.png';     Title = 'Blade Sharpening Bank';
       Dim = '10 grinders in 2 rows of 5, 8.4 m x 7.4 m';
       Desc = 'Ten pedestal belt grinders in two rows of five. Operators face a central WIP lane. Dust extraction runs along the back wall of each row. This is the binding bottleneck (94.7 % utilisation, 3 638 min/day workload).' }
    @{ N = 10; File = 'C10_Serrating_Row.png';      Title = 'Blade Serrating Row';
       Dim = '5 stations, 8.4 m x 3.5 m';
       Desc = 'Five profiled-abrasive stations in-line after sharpening. Each station has its own WIP-in tray; the WIP-out trays feed directly into the polishing row.' }
    @{ N = 11; File = 'C11_Polishing_Row.png';      Title = 'Hand Polishing Row';
       Dim = '5 benches, 8.4 m x 3.5 m';
       Desc = 'Five manual benches with extraction. Operators face the polishing arbor; the WIP-in bin is on the left, the WIP-out bin (clean / deburred) is on the right, in the direction of flow toward the powder-coating line.' }
    @{ N = 12; File = 'C12_Final_Assembly.png';     Title = 'Final Assembly Cell';
       Dim = '3 benches x 4.4 m x 3.1 m';
       Desc = 'Three assembly benches. Three inbound flows converge: powder-coated handle sections, powder-coated head sub-assemblies, and bagged rivets / hardware. Each bench holds the matching fixtures for handle-to-head clamping.' }
    @{ N = 13; File = 'C13_Packaging.png';          Title = 'Packaging Cell';
       Dim = '3 benches x 6.6 m x 3.0 m';
       Desc = 'Three packing benches. Bagging is followed by carton-pack; the carton is the final visual-check point. A quarantine bin sits between the benches and the pallet-build position. The packed pallet is moved by hand pallet truck to finished-goods storage.' }
)

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

# --- Section 1: Landscape MFP page ---
$ps = $doc.PageSetup
$ps.Orientation = 1                  # wdOrientLandscape
$ps.TopMargin    = 36
$ps.BottomMargin = 36
$ps.LeftMargin   = 36
$ps.RightMargin  = 36

$sel = $word.Selection
$sel.Font.Name = 'Calibri'
$sel.Font.Size = 14
$sel.Font.Bold = $true
$sel.TypeText("Master Facility Plan - DigMore Folding Mini Shovel")
$sel.TypeParagraph()
$sel.Font.Size = 10
$sel.Font.Bold = $false
$sel.Font.Italic = $true
$sel.TypeText("Section 8 space basis  |  Alternative 2 (U-flow)  |  All dimensions in metres  |  12 June 2026")
$sel.TypeParagraph()
$sel.Font.Italic = $false

$shape = $sel.InlineShapes.AddPicture($mfp, $false, $true)
$shape.Width = 10.0 * 72
$shape.Height = $shape.Width * (1474.0 / 2120.0)

$sel.TypeParagraph()
$sel.ParagraphFormat.Alignment = 1
$sel.Font.Bold = $true
$sel.Font.Size = 9
$sel.TypeText("Figure 11.1: DigMore Master Facility Plan - U-flow layout on a 80.0 x 52.0 m site (4 160 m^2), with a 50.0 x 40.0 m building envelope (~2 000 m^2 internal).")
$sel.Font.Bold = $false

# --- Section break to portrait for workstations ---
$sel.EndKey(6) | Out-Null    # wdStory = 6
$sel.InsertBreak(2)          # wdSectionBreakNextPage = 2
$sel2 = $word.Selection
$sec2 = $doc.Sections.Item($doc.Sections.Count).PageSetup
$sec2.Orientation = 0        # wdOrientPortrait
$sec2.TopMargin    = 54
$sec2.BottomMargin = 54
$sec2.LeftMargin   = 54
$sec2.RightMargin  = 54

# Cover heading for workstation section
$sel2.ParagraphFormat.Alignment = 0
$sel2.Font.Size = 16
$sel2.Font.Bold = $true
$sel2.TypeText("Appendix C - Workstation Layouts")
$sel2.TypeParagraph()
$sel2.Font.Size = 10
$sel2.Font.Bold = $false
$sel2.Font.Italic = $true
$sel2.TypeText("Top-down plan view of each production cell with operator position, WIP-in / WIP-out, machine footprint, safety clearance and main material-flow direction. Not to scale; dimensions reference Table 8.5 (workstation roll-up).")
$sel2.TypeParagraph()
$sel2.Font.Italic = $false
$sel2.TypeParagraph()

foreach ($s in $stations) {
    if ($s.N -gt 1) {
        $sel2.InsertBreak(7)     # wdPageBreak = 7
    }
    # Heading
    $sel2.ParagraphFormat.Alignment = 0
    $sel2.Font.Size = 14
    $sel2.Font.Bold = $true
    $sel2.TypeText("Figure C{0}: {1}" -f $s.N, $s.Title)
    $sel2.TypeParagraph()
    # Dimension line
    $sel2.Font.Size = 10
    $sel2.Font.Bold = $false
    $sel2.Font.Italic = $true
    $sel2.TypeText("Footprint: " + $s.Dim)
    $sel2.Font.Italic = $false
    $sel2.TypeParagraph()
    # Description
    $sel2.Font.Size = 10
    $sel2.TypeText($s.Desc)
    $sel2.TypeParagraph()
    $sel2.TypeParagraph()
    # Image
    $imgPath = Join-Path $wsDir $s.File
    if (Test-Path $imgPath) {
        $sh = $sel2.InlineShapes.AddPicture($imgPath, $false, $true)
        $maxW = 6.5 * 72
        if ($sh.Width -gt $maxW) {
            $ratio = $sh.Height / $sh.Width
            $sh.Width = $maxW
            $sh.Height = $maxW * $ratio
        }
        $sel2.TypeParagraph()
        $sel2.ParagraphFormat.Alignment = 1
        $sel2.Font.Italic = $true
        $sel2.Font.Size = 9
        $cap = "Figure C" + $s.N + ": " + $s.Title + " (" + $s.Dim + ")."
        $sel2.TypeText($cap)
        $sel2.Font.Italic = $false
        $sel2.ParagraphFormat.Alignment = 0
        $sel2.TypeParagraph()
    }
}

# Save DOCX (backup) and PDF (primary deliverable)
$doc.SaveAs2($outDocx, 16)        # wdFormatDocumentDefault = 16
$doc.SaveAs2($outPdf, 17)         # wdFormatPDF = 17
$doc.Close()
$word.Quit()
[Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
[gc]::Collect(); [gc]::WaitForPendingFinalizers()

Write-Host "PDF:   $outPdf"
Write-Host "DOCX:  $outDocx"
Write-Host "PDF size:  $([Math]::Round((Get-Item $outPdf).Length / 1KB,1)) KB"
Write-Host "DOCX size: $([Math]::Round((Get-Item $outDocx).Length / 1KB,1)) KB"
