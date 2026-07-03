# Wrap the MFP PNG into a one-page landscape DOCX.
$png  = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_Final.png'
$docx = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_Final.docx'

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

$ps = $doc.PageSetup
$ps.Orientation = 1                  # wdOrientLandscape
$ps.PaperSize   = 1                  # wdPaperLetter (= A4 landscape works for both)
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

$shape = $sel.InlineShapes.AddPicture($png, $false, $true)
# Fit to landscape A4 minus margins (about 10.0 inches wide)
$shape.Width = 10.0 * 72
$shape.Height = $shape.Width * (1474.0 / 2120.0)

$sel.TypeParagraph()
$sel.ParagraphFormat.Alignment = 1
$sel.Font.Bold = $true
$sel.Font.Size = 9
$sel.TypeText("Figure 11.1: DigMore Master Facility Plan - U-flow layout on a 80.0 x 52.0 m site (4 160 m^2), with a 50.0 x 40.0 m building envelope (~2 000 m^2 internal).")

$doc.SaveAs2($docx, 16)
$doc.Close()
$word.Quit()
[Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
[gc]::Collect(); [gc]::WaitForPendingFinalizers()
Write-Host "Saved: $docx"
Write-Host "Size:  $((Get-Item $docx).Length / 1KB) KB"
