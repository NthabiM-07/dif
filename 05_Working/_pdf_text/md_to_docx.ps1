# Build the consolidated Section 8-12 + Appendix C report as a DOCX using Word COM.
# Renders the markdown manually (headings, paragraphs, tables) and embeds C1-C13 PNGs.

param(
    [string]$Src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.2_Report\Section8_to_12_Consolidated.md",
    [string]$Dst = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.2_Report\DigMore_Section_8-12_Consolidated.docx",
    [string]$ImgDir = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\workstations"
)

if (-not (Test-Path $Src)) { Write-Error "Source not found: $Src"; exit 1 }

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

# Page setup
$ps = $doc.PageSetup
$ps.TopMargin    = 56.7   # 2.0 cm
$ps.BottomMargin = 56.7
$ps.LeftMargin   = 56.7
$ps.RightMargin  = 56.7

$sel = $word.Selection

function Add-Heading($text, $level) {
    $sel.Style = $doc.Styles.Item("Heading $level")
    $sel.TypeText($text)
    $sel.TypeParagraph()
}

function Add-Para($text, $bold = $false, $italic = $false) {
    $sel.Style = $doc.Styles.Item("Normal")
    $sel.Font.Bold = if ($bold) { $true } else { $false }
    $sel.Font.Italic = if ($italic) { $true } else { $false }
    $sel.TypeText($text)
    $sel.Font.Bold = $false
    $sel.Font.Italic = $false
    $sel.TypeParagraph()
}

function Add-InlineFormatted($line) {
    # Parse inline **bold** and `code` and *italic*
    $sel.Style = $doc.Styles.Item("Normal")
    $pos = 0
    $i = 0
    while ($i -lt $line.Length) {
        # bold **...**
        if ($line.Substring($i).StartsWith('**')) {
            $end = $line.IndexOf('**', $i + 2)
            if ($end -gt 0) {
                if ($i -gt $pos) { $sel.TypeText($line.Substring($pos, $i - $pos)) }
                $sel.Font.Bold = $true
                $sel.TypeText($line.Substring($i + 2, $end - $i - 2))
                $sel.Font.Bold = $false
                $i = $end + 2; $pos = $i; continue
            }
        }
        # code `...`
        if ($line[$i] -eq '`') {
            $end = $line.IndexOf('`', $i + 1)
            if ($end -gt 0) {
                if ($i -gt $pos) { $sel.TypeText($line.Substring($pos, $i - $pos)) }
                $sel.Font.Name = 'Consolas'
                $sel.TypeText($line.Substring($i + 1, $end - $i - 1))
                $sel.Font.Name = 'Calibri'
                $i = $end + 1; $pos = $i; continue
            }
        }
        $i++
    }
    if ($pos -lt $line.Length) { $sel.TypeText($line.Substring($pos)) }
    $sel.TypeParagraph()
}

function Add-Table($lines) {
    # lines = array of markdown table lines
    # Parse header, separator, body
    $rows = @()
    foreach ($l in $lines) {
        if ($l -match '^\s*\|?\s*[:\-\s\|]+\s*\|?\s*$') { continue }
        $cells = $l -replace '^\s*\|','' -replace '\|\s*$','' -split '\|'
        $rows += ,@($cells | ForEach-Object { $_.Trim() })
    }
    if ($rows.Count -lt 1) { return }
    $cols = $rows[0].Count
    $rng = $sel.Range
    $tbl = $doc.Tables.Add($rng, $rows.Count, $cols)
    $tbl.Borders.Enable = $true
    $tbl.Range.Font.Size = 9
    $tbl.Range.Font.Name = 'Calibri'
    for ($r = 0; $r -lt $rows.Count; $r++) {
        for ($c = 0; $c -lt $cols; $c++) {
            $cell = $tbl.Cell($r + 1, $c + 1)
            $cell.Range.Text = $rows[$r][$c] -replace '\*\*',''
            if ($r -eq 0) {
                $cell.Range.Font.Bold = $true
                $cell.Shading.BackgroundPatternColor = 15131600  # light purple-grey
            }
        }
    }
    # Move selection past the table
    $sel.EndKey(6) | Out-Null    # 6 = wdStory
    $sel.TypeParagraph()
}

function Add-Image($path, $widthInches = 6.3) {
    if (-not (Test-Path $path)) { return }
    $shape = $sel.InlineShapes.AddPicture($path, $false, $true)
    # Scale to width
    $widthPts = $widthInches * 72.0
    if ($shape.Width -gt $widthPts) {
        $scale = $widthPts / $shape.Width
        $shape.Width = $widthPts
        $shape.Height = $shape.Height * $scale
    }
    $sel.TypeParagraph()
}

# ---------- Parse markdown ----------
$md = Get-Content -LiteralPath $Src -Encoding UTF8
$i = 0
$tableBuf = @()
$inTable = $false

function Flush-Table() {
    if ($script:tableBuf.Count -gt 0) {
        Add-Table $script:tableBuf
        $script:tableBuf = @()
    }
}

while ($i -lt $md.Count) {
    $line = $md[$i]

    # Table detection
    if ($line -match '^\s*\|.*\|\s*$') {
        $script:tableBuf += $line
        $i++; continue
    } else {
        if ($script:tableBuf.Count -gt 0) { Flush-Table }
    }

    if ([string]::IsNullOrWhiteSpace($line)) { $sel.TypeParagraph(); $i++; continue }

    # Headings
    if ($line -match '^#\s+(.+)$')   { Add-Heading $matches[1] 1; $i++; continue }
    if ($line -match '^##\s+(.+)$')  { Add-Heading $matches[1] 2; $i++; continue }
    if ($line -match '^###\s+(.+)$') { Add-Heading $matches[1] 3; $i++; continue }
    if ($line -match '^####\s+(.+)$'){ Add-Heading $matches[1] 4; $i++; continue }
    if ($line -match '^---\s*$') { $sel.InsertParagraph(); $i++; continue }

    # Math block $$...$$
    if ($line -match '^\$\$') {
        $sel.Font.Italic = $true
        $sel.TypeText($line.Trim('$').Trim())
        $sel.TypeParagraph()
        $sel.Font.Italic = $false
        $i++; continue
    }

    # Bullet
    if ($line -match '^\s*-\s+(.+)$') {
        $sel.Style = $doc.Styles.Item("List Bullet")
        Add-InlineFormatted $matches[1]
        $sel.Style = $doc.Styles.Item("Normal")
        $i++; continue
    }

    # Figure caption + image embed
    if ($line -match '^\*\*Figure C(\d+):\s+(.+?)\.\*\*\s*(.*)$') {
        $num = $matches[1]; $title = $matches[2]; $rest = $matches[3]
        # Insert image first
        $imgPath = Join-Path $ImgDir "C${num}_*.png"
        $imgFile = Get-ChildItem $imgPath -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($imgFile) {
            Add-Image $imgFile.FullName 6.3
        }
        # Then caption
        $sel.Style = $doc.Styles.Item("Normal")
        $sel.ParagraphFormat.Alignment = 1   # centred
        $sel.Font.Italic = $true
        $sel.Font.Bold = $true
        $sel.TypeText("Figure C${num}: $title.")
        $sel.Font.Bold = $false
        if ($rest) { $sel.TypeText(" $rest") }
        $sel.Font.Italic = $false
        $sel.TypeParagraph()
        $sel.ParagraphFormat.Alignment = 0
        $i++; continue
    }

    # Regular paragraph (with inline formatting)
    Add-InlineFormatted $line
    $i++
}
Flush-Table

# Save
$doc.SaveAs2($Dst, 16)   # wdFormatDocumentDefault = 16
$doc.Close()
$word.Quit()
[Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
[gc]::Collect(); [gc]::WaitForPendingFinalizers()

Write-Host "Saved $Dst"
Write-Host "Size: $((Get-Item $Dst).Length / 1KB) KB"
