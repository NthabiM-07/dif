# Build 13 workstation layout PNGs (top-down plan view, labelled like Benchmark B).
# Pure System.Drawing - no internet, no drawio dependency.
# Drawings are illustrative / not to scale; dimensions are written on the figures.

Add-Type -AssemblyName System.Drawing

$outDir = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\workstations"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

# ---- Palette (NWU) ----
$nwuPurple   = [System.Drawing.ColorTranslator]::FromHtml('#4F2D7F')
$nwuPurpleL  = [System.Drawing.ColorTranslator]::FromHtml('#E6E0EC')
$nwuPurpleVL = [System.Drawing.ColorTranslator]::FromHtml('#F0EBF5')
$nwuDark     = [System.Drawing.ColorTranslator]::FromHtml('#231F20')
$nwuGrey     = [System.Drawing.ColorTranslator]::FromHtml('#6E6E6E')
$nwuLightGrey= [System.Drawing.ColorTranslator]::FromHtml('#D9D9D9')
$wipFill     = [System.Drawing.ColorTranslator]::FromHtml('#FFF4D6')
$wipStroke   = [System.Drawing.ColorTranslator]::FromHtml('#B58900')
$scrapFill   = [System.Drawing.ColorTranslator]::FromHtml('#FBE3E4')
$scrapStroke = [System.Drawing.ColorTranslator]::FromHtml('#A82828')
$opFill      = [System.Drawing.ColorTranslator]::FromHtml('#CFE3FA')
$opStroke    = [System.Drawing.ColorTranslator]::FromHtml('#1F4E8C')
$safetyStroke= [System.Drawing.ColorTranslator]::FromHtml('#8C8C8C')

function New-Canvas($w, $h, $title, $dims) {
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $g.Clear([System.Drawing.Color]::White)
    # Title bar
    $tbBrush = New-Object System.Drawing.SolidBrush $nwuPurple
    $g.FillRectangle($tbBrush, 0, 0, $w, 60)
    $tf = New-Object System.Drawing.Font 'Segoe UI', 16, [System.Drawing.FontStyle]::Bold
    $tb = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $rect = New-Object System.Drawing.RectangleF 0, 0, $w, 60
    $g.DrawString($title, $tf, $tb, $rect, $sf)
    $tbBrush.Dispose(); $tf.Dispose(); $tb.Dispose()
    # Dims footer
    $df = New-Object System.Drawing.Font 'Segoe UI', 11, [System.Drawing.FontStyle]::Italic
    $dbrush = New-Object System.Drawing.SolidBrush $nwuGrey
    $drect = New-Object System.Drawing.RectangleF 0, ($h - 35), $w, 30
    $g.DrawString("Dimensions: $dims  |  Not to scale  |  Top-down plan view", $df, $dbrush, $drect, $sf)
    $df.Dispose(); $dbrush.Dispose(); $sf.Dispose()
    return @{ Bmp = $bmp; G = $g; W = $w; H = $h }
}

function Save-Canvas($canvas, $path) {
    $canvas.G.Dispose()
    $canvas.Bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $canvas.Bmp.Dispose()
    Write-Host "Saved $path"
}

function Draw-Box($g, $x, $y, $w, $h, $fill, $stroke, $thick = 2, $label = $null, $fontSize = 11, $bold = $true) {
    if ($fill -ne $null) {
        $b = New-Object System.Drawing.SolidBrush $fill
        $g.FillRectangle($b, $x, $y, $w, $h)
        $b.Dispose()
    }
    if ($stroke -ne $null) {
        $p = New-Object System.Drawing.Pen $stroke, ([single]$thick)
        $g.DrawRectangle($p, $x, $y, $w, $h)
        $p.Dispose()
    }
    if ($label) {
        $fs = if ($bold) { [System.Drawing.FontStyle]::Bold } else { [System.Drawing.FontStyle]::Regular }
        $f = New-Object System.Drawing.Font 'Segoe UI', ([single]$fontSize), $fs
        $b = New-Object System.Drawing.SolidBrush $nwuDark
        $sf = New-Object System.Drawing.StringFormat
        $sf.Alignment = [System.Drawing.StringAlignment]::Center
        $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
        $r = New-Object System.Drawing.RectangleF $x, $y, $w, $h
        $g.DrawString($label, $f, $b, $r, $sf)
        $f.Dispose(); $b.Dispose(); $sf.Dispose()
    }
}

function Draw-DashedBox($g, $x, $y, $w, $h, $stroke, $label = $null) {
    $p = New-Object System.Drawing.Pen $stroke, ([single]1.5)
    $p.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
    $g.DrawRectangle($p, $x, $y, $w, $h)
    $p.Dispose()
    if ($label) {
        $f = New-Object System.Drawing.Font 'Segoe UI', 9, [System.Drawing.FontStyle]::Italic
        $b = New-Object System.Drawing.SolidBrush $stroke
        $g.DrawString($label, $f, $b, ([single]($x + 5)), ([single]($y + 3)))
        $f.Dispose(); $b.Dispose()
    }
}

function Draw-Op($g, $cx, $cy, $r = 22, $label = "OP") {
    $b = New-Object System.Drawing.SolidBrush $opFill
    $g.FillEllipse($b, ($cx - $r), ($cy - $r), ($r * 2), ($r * 2))
    $b.Dispose()
    $p = New-Object System.Drawing.Pen $opStroke, 2
    $g.DrawEllipse($p, ($cx - $r), ($cy - $r), ($r * 2), ($r * 2))
    $p.Dispose()
    $f = New-Object System.Drawing.Font 'Segoe UI', 10, [System.Drawing.FontStyle]::Bold
    $tb = New-Object System.Drawing.SolidBrush $opStroke
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $rect = New-Object System.Drawing.RectangleF ($cx - $r), ($cy - $r), ($r * 2), ($r * 2)
    $g.DrawString($label, $f, $tb, $rect, $sf)
    $f.Dispose(); $tb.Dispose(); $sf.Dispose()
}

function Draw-Arrow($g, $x1, $y1, $x2, $y2, $color = $null, $thick = 2.5) {
    if ($color -eq $null) { $color = $nwuDark }
    $p = New-Object System.Drawing.Pen $color, ([single]$thick)
    $p.CustomEndCap = New-Object System.Drawing.Drawing2D.AdjustableArrowCap 6, 8, $true
    $g.DrawLine($p, ([single]$x1), ([single]$y1), ([single]$x2), ([single]$y2))
    $p.Dispose()
}

function Draw-Label($g, $x, $y, $text, $size = 11, $bold = $false, $color = $null) {
    if ($color -eq $null) { $color = $nwuDark }
    $fs = if ($bold) { [System.Drawing.FontStyle]::Bold } else { [System.Drawing.FontStyle]::Regular }
    $f = New-Object System.Drawing.Font 'Segoe UI', ([single]$size), $fs
    $b = New-Object System.Drawing.SolidBrush $color
    $g.DrawString($text, $f, $b, ([single]$x), ([single]$y))
    $f.Dispose(); $b.Dispose()
}

function Draw-Legend($canvas, $items) {
    # items: array of @{Fill=...;Stroke=...;Label='...'}
    $x = 40; $y = $canvas.H - 110
    Draw-Label $canvas.G $x ($y - 22) "Legend:" 10 $true
    foreach ($it in $items) {
        Draw-Box $canvas.G $x $y 22 16 $it.Fill $it.Stroke 1.5
        Draw-Label $canvas.G ($x + 28) ($y - 2) $it.Label 9 $false
        $x += 175
    }
}

# ============================================================
# Figure C1 - Tube Cutting Workstation (3 saws)
# ============================================================
$c = New-Canvas 1100 750 "Figure C1 - Tube Cutting Workstation" "9.0 m x 2.0 m per cell, 3 cells"
$g = $c.G
# 6 m tube rack along the top
Draw-Box $g 80 100 940 60 $nwuPurpleVL $nwuPurple 2 "6 m Aluminium Tube Rack (cantilever)" 12
# Three saw cells
$cellW = 300; $cellH = 380; $startX = 100; $startY = 220
for ($i = 0; $i -lt 3; $i++) {
    $x = $startX + $i * ($cellW + 10)
    Draw-DashedBox $g $x $startY $cellW $cellH $safetyStroke "Cell boundary"
    # Saw
    Draw-Box $g ($x + 60) ($startY + 30) 180 120 $nwuLightGrey $nwuDark 2 "Automatic Saw" 11
    # Operator
    Draw-Op $g ($x + $cellW / 2) ($startY + 200) 22 ("OP$($i + 1)")
    # WIP bins
    Draw-Box $g ($x + 30) ($startY + 270) 100 50 $wipFill $wipStroke 1.5 "Back-handle bin" 9 $false
    Draw-Box $g ($x + 170) ($startY + 270) 100 50 $wipFill $wipStroke 1.5 "Middle-handle bin" 9 $false
    # Scrap
    Draw-Box $g ($x + 100) ($startY + 335) 100 35 $scrapFill $scrapStroke 1.5 "Scrap" 9 $false
    # Arrows: rack -> saw -> bins
    Draw-Arrow $g ($x + $cellW / 2) 160 ($x + $cellW / 2) ($startY + 30)
    Draw-Arrow $g ($x + $cellW / 2) ($startY + 150) ($x + $cellW / 2) ($startY + 170)
    Draw-Arrow $g ($x + $cellW / 2 - 30) ($startY + 230) ($x + 90) ($startY + 270)
    Draw-Arrow $g ($x + $cellW / 2 + 30) ($startY + 230) ($x + 210) ($startY + 270)
}
# Annotations
Draw-Label $g 70 75 "Forklift access from rack face only" 10 $true $nwuGrey
Draw-Label $g 70 615 "Operator aisle (no forklift)" 10 $true $nwuGrey
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Machine'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'},
    @{Fill=$scrapFill;Stroke=$scrapStroke;Label='Scrap bin'}
)
Save-Canvas $c (Join-Path $outDir "C1_Tube_Cutting.png")

# ============================================================
# Figure C2 - Internal Threading Workstation
# ============================================================
$c = New-Canvas 1100 700 "Figure C2 - Internal Threading Workstation" "3.0 m x 2.0 m per cell, 2 cells"
$g = $c.G
$startY = 120
for ($i = 0; $i -lt 2; $i++) {
    $x = 150 + $i * 430
    Draw-DashedBox $g $x $startY 380 460 $safetyStroke "Cell boundary"
    # WIP-in
    Draw-Box $g ($x + 30) ($startY + 50) 100 80 $wipFill $wipStroke 1.5 "WIP-in`n(middle handles)" 10 $false
    # Tapping machine
    Draw-Box $g ($x + 140) ($startY + 40) 140 110 $nwuLightGrey $nwuDark 2 "Tapping Machine" 11
    # Operator
    Draw-Op $g ($x + 210) ($startY + 230) 24 ("OP$($i + 1)")
    # Swarf bin
    Draw-Box $g ($x + 290) ($startY + 60) 60 60 $scrapFill $scrapStroke 1.5 "Swarf" 9 $false
    # WIP-out
    Draw-Box $g ($x + 140) ($startY + 330) 140 80 $wipFill $wipStroke 1.5 "WIP-out`n(threaded)" 10 $false
    # Arrows
    Draw-Arrow $g ($x + 130) ($startY + 90) ($x + 140) ($startY + 90)
    Draw-Arrow $g ($x + 210) ($startY + 150) ($x + 210) ($startY + 200)
    Draw-Arrow $g ($x + 210) ($startY + 260) ($x + 210) ($startY + 325)
}
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Machine'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'},
    @{Fill=$scrapFill;Stroke=$scrapStroke;Label='Swarf'}
)
Save-Canvas $c (Join-Path $outDir "C2_Internal_Threading.png")

# ============================================================
# Figure C3 - Grip-End Forming Workstation
# ============================================================
$c = New-Canvas 900 600 "Figure C3 - Grip-End Forming Workstation" "3.0 m x 2.0 m, 1 cell"
$g = $c.G
Draw-DashedBox $g 200 110 500 400 $safetyStroke "Cell boundary"
Draw-Box $g 230 150 120 100 $wipFill $wipStroke 1.5 "WIP-in`n(back handle)" 10 $false
Draw-Box $g 370 140 180 120 $nwuLightGrey $nwuDark 2 "Tube End Former" 11
Draw-Op $g 450 340 24 "OP"
Draw-Box $g 570 150 100 100 $wipFill $wipStroke 1.5 "WIP-out`n(narrowed)" 10 $false
Draw-Arrow $g 350 200 370 200
Draw-Arrow $g 550 200 570 200
Draw-Arrow $g 460 260 450 315
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Machine'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'}
)
Save-Canvas $c (Join-Path $outDir "C3_Grip_End_Forming.png")

# ============================================================
# Figure C4 - Knurling + External Threading Bank (5 machines)
# ============================================================
$c = New-Canvas 1300 750 "Figure C4 - Knurling + External Threading Bank (BOTTLENECK 99.7%)" "8.4 m x 4.4 m bank, 5 machines"
$g = $c.G
Draw-DashedBox $g 60 100 1180 470 $safetyStroke "Bank boundary"
# Inbound buffer
Draw-Box $g 80 130 1140 70 $wipFill $wipStroke 1.5 "Full-length inbound buffer (protects bank from starvation)" 11
# 5 machines
$mw = 200; $mh = 130; $sx = 90
for ($i = 0; $i -lt 5; $i++) {
    $x = $sx + $i * 220
    Draw-Box $g $x 230 $mw $mh $nwuLightGrey $nwuDark 2 "Thread Roll`nMachine $($i + 1)" 11
    Draw-Op $g ($x + $mw / 2) 430 22 ("OP$($i + 1)")
    Draw-Arrow $g ($x + $mw / 2) 200 ($x + $mw / 2) 230
    Draw-Arrow $g ($x + $mw / 2) 360 ($x + $mw / 2) 410
}
# Outbound buffer
Draw-Box $g 80 490 1140 70 $wipFill $wipStroke 1.5 "Outbound buffer (to powder coating)" 11
# Coolant/mist arrow
Draw-Label $g 80 75 "Coolant/mist extraction along back wall" 11 $true $nwuGrey
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Thread roller'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='Buffer'}
)
Save-Canvas $c (Join-Path $outDir "C4_Knurling_Bank.png")

# ============================================================
# Figure C5 - Sheet-Metal Press Cell (2 presses)
# ============================================================
$c = New-Canvas 1200 750 "Figure C5 - Sheet-Metal Press Cell" "6.4 m x 4.0 m, 2 presses"
$g = $c.G
Draw-DashedBox $g 80 100 1040 510 $safetyStroke "Cell boundary"
# Shared sheet staging
Draw-Box $g 110 130 980 90 $nwuPurpleVL $nwuPurple 2 "Shared sheet-pack staging (palletised, forklift-fed)" 12
# 2 presses
Draw-Box $g 150 270 350 180 $nwuLightGrey $nwuDark 2 "Press 1`n(Shovel Head)" 12
Draw-Box $g 700 270 350 180 $nwuLightGrey $nwuDark 2 "Press 2`n(Hinge Connector)" 12
Draw-Op $g 325 510 24 "OP1"
Draw-Op $g 875 510 24 "OP2"
# Blank bins
Draw-Box $g 150 555 200 50 $wipFill $wipStroke 1.5 "Head blanks" 10 $false
Draw-Box $g 700 555 200 50 $wipFill $wipStroke 1.5 "Hinge blanks" 10 $false
# Skeleton scrap
Draw-Box $g 950 555 150 50 $scrapFill $scrapStroke 1.5 "Skeleton scrap" 10 $false
# Arrows
Draw-Arrow $g 325 220 325 270
Draw-Arrow $g 875 220 875 270
Draw-Arrow $g 325 450 325 488
Draw-Arrow $g 875 450 875 488
Draw-Label $g 90 615 "Light curtains; die-change access aisle behind presses" 10 $true $nwuGrey
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Press'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='Blank bin'},
    @{Fill=$scrapFill;Stroke=$scrapStroke;Label='Skeleton scrap'}
)
Save-Canvas $c (Join-Path $outDir "C5_Press_Cell.png")

# ============================================================
# Figure C6 - Hinge Bending Workstation
# ============================================================
$c = New-Canvas 900 600 "Figure C6 - Hinge Bending Workstation" "3.4 m x 2.5 m, 1 cell"
$g = $c.G
Draw-DashedBox $g 200 110 500 400 $safetyStroke "Cell boundary"
Draw-Box $g 230 150 100 100 $wipFill $wipStroke 1.5 "WIP-in`n(stamped hinges)" 9 $false
Draw-Box $g 350 130 220 150 $nwuLightGrey $nwuDark 2 "Electric Press Brake" 12
Draw-Op $g 460 360 24 "OP"
Draw-Box $g 590 160 90 100 $wipFill $wipStroke 1.5 "WIP-out`n(bent)" 10 $false
Draw-Arrow $g 330 200 350 200
Draw-Arrow $g 570 200 590 200
Draw-Arrow $g 460 280 460 335
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Press brake'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'}
)
Save-Canvas $c (Join-Path $outDir "C6_Hinge_Bending.png")

# ============================================================
# Figure C7 - Shovel-Head Shaping Workstation
# ============================================================
$c = New-Canvas 900 600 "Figure C7 - Shovel-Head Shaping Workstation" "3.0 m x 2.0 m, 1 cell"
$g = $c.G
Draw-DashedBox $g 200 110 500 400 $safetyStroke "Cell boundary"
Draw-Box $g 230 150 100 100 $wipFill $wipStroke 1.5 "WIP-in`n(stamped heads)" 9 $false
Draw-Box $g 350 130 220 150 $nwuLightGrey $nwuDark 2 "Forming Press`n(shaping fixture)" 11
Draw-Op $g 460 360 24 "OP"
Draw-Box $g 590 160 90 100 $wipFill $wipStroke 1.5 "WIP-out`n(shaped)" 10 $false
Draw-Arrow $g 330 200 350 200
Draw-Arrow $g 570 200 590 200
Draw-Arrow $g 460 280 460 335
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Forming press'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'}
)
Save-Canvas $c (Join-Path $outDir "C7_Head_Shaping.png")

# ============================================================
# Figure C8 - Riveting Workstation
# ============================================================
$c = New-Canvas 1100 700 "Figure C8 - Riveting Workstation (convergence of sheet streams)" "3.7 m x 2.6 m, 1 cell"
$g = $c.G
Draw-DashedBox $g 200 110 700 500 $safetyStroke "Cell boundary"
# WIP-in heads (left)
Draw-Box $g 230 200 130 110 $wipFill $wipStroke 1.5 "WIP-in`nHeads (shaped)" 10 $false
# WIP-in hinges (right)
Draw-Box $g 730 200 130 110 $wipFill $wipStroke 1.5 "WIP-in`nHinges (bent)" 10 $false
# Rivet shelf
Draw-Box $g 470 130 160 50 $nwuPurpleVL $nwuPurple 1.5 "Rivet shelf" 11
# Riveter (centre)
Draw-Box $g 430 220 250 170 $nwuLightGrey $nwuDark 2 "Radial`nRiveting Machine" 12
# Operator
Draw-Op $g 555 460 24 "OP"
# WIP-out
Draw-Box $g 405 530 290 60 $wipFill $wipStroke 1.5 "WIP-out - Head sub-assembly (to heat treatment)" 11
# Arrows
Draw-Arrow $g 360 260 430 280
Draw-Arrow $g 730 260 680 280
Draw-Arrow $g 550 180 550 220
Draw-Arrow $g 555 390 555 435
Draw-Arrow $g 555 485 555 528
Draw-Label $g 230 625 "Two-hand control; compressed-air drop; task lighting" 10 $true $nwuGrey
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Riveter'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin'},
    @{Fill=$nwuPurpleVL;Stroke=$nwuPurple;Label='Rivet shelf'}
)
Save-Canvas $c (Join-Path $outDir "C8_Riveting.png")

# ============================================================
# Figure C9 - Blade Sharpening Bank (10 grinders, BOTTLENECK)
# ============================================================
$c = New-Canvas 1300 800 "Figure C9 - Blade Sharpening Bank (BOTTLENECK 94.7%)" "8.4 m x 7.4 m, 10 grinders"
$g = $c.G
Draw-DashedBox $g 60 100 1180 580 $safetyStroke "Bank boundary"
Draw-Label $g 80 75 "Dust extraction along back walls (top + bottom)" 11 $true $nwuGrey
# Two rows of 5 grinders, central WIP lane
$gW = 200; $gH = 120
for ($i = 0; $i -lt 5; $i++) {
    $x = 90 + $i * 220
    # Top row
    Draw-Box $g $x 130 $gW $gH $nwuLightGrey $nwuDark 2 "Grinder $($i + 1)" 11
    Draw-Op $g ($x + $gW / 2) 285 20 ("OP$($i + 1)")
    Draw-Arrow $g ($x + $gW / 2) 250 ($x + $gW / 2) 265
    # Bottom row
    Draw-Box $g $x 510 $gW $gH $nwuLightGrey $nwuDark 2 "Grinder $($i + 6)" 11
    Draw-Op $g ($x + $gW / 2) 470 20 ("OP$($i + 6)")
    Draw-Arrow $g ($x + $gW / 2) 490 ($x + $gW / 2) 505
}
# Central WIP lane
Draw-Box $g 80 320 1140 130 $wipFill $wipStroke 2 "Central WIP lane - heads in / heads out (controlled supply prevents starvation)" 12
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Belt grinder'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP lane'}
)
Save-Canvas $c (Join-Path $outDir "C9_Sharpening_Bank.png")

# ============================================================
# Figure C10 - Blade Serrating Row (5 stations)
# ============================================================
$c = New-Canvas 1300 600 "Figure C10 - Blade Serrating Row" "8.4 m x 3.5 m, 5 stations"
$g = $c.G
Draw-DashedBox $g 60 100 1180 380 $safetyStroke "Row boundary"
Draw-Box $g 80 130 1140 60 $wipFill $wipStroke 1.5 "WIP-in (sharpened heads from C9)" 11
for ($i = 0; $i -lt 5; $i++) {
    $x = 90 + $i * 220
    Draw-Box $g $x 220 200 130 $nwuLightGrey $nwuDark 2 "Serrating`nStation $($i + 1)" 11
    Draw-Op $g ($x + 100) 420 22 ("OP$($i + 1)")
    Draw-Arrow $g ($x + 100) 190 ($x + 100) 220
    Draw-Arrow $g ($x + 100) 350 ($x + 100) 395
}
Draw-Box $g 80 470 1140 0 $null $null
Draw-Label $g 80 510 "Flow continues to polishing row (C11)" 11 $true $nwuGrey
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Serrator'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP'}
)
Save-Canvas $c (Join-Path $outDir "C10_Serrating_Row.png")

# ============================================================
# Figure C11 - Hand Polishing Row (5 benches)
# ============================================================
$c = New-Canvas 1300 600 "Figure C11 - Hand Polishing Row" "8.4 m x 3.5 m, 5 benches"
$g = $c.G
Draw-DashedBox $g 60 100 1180 380 $safetyStroke "Row boundary"
Draw-Box $g 80 130 1140 50 $wipFill $wipStroke 1.5 "WIP-in (serrated heads from C10)" 11
for ($i = 0; $i -lt 5; $i++) {
    $x = 90 + $i * 220
    Draw-Box $g $x 210 200 130 $nwuLightGrey $nwuDark 2 "Polishing`nBench $($i + 1)" 11
    Draw-Op $g ($x + 100) 410 22 ("OP$($i + 1)")
    Draw-Arrow $g ($x + 100) 180 ($x + 100) 210
    Draw-Arrow $g ($x + 100) 340 ($x + 100) 388
}
Draw-Box $g 80 450 1140 30 $wipFill $wipStroke 1.5 "WIP-out (deburred heads → powder coating)" 10 $false
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Polishing bench'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP'}
)
Save-Canvas $c (Join-Path $outDir "C11_Polishing_Row.png")

# ============================================================
# Figure C12 - Final Assembly Cell (3 benches)
# ============================================================
$c = New-Canvas 1300 750 "Figure C12 - Final Assembly Cell" "4.4 m x 3.1 m per bench, 3 benches"
$g = $c.G
Draw-DashedBox $g 60 100 1180 540 $safetyStroke "Cell boundary"
# Three inbound flows
Draw-Box $g 80 130 380 60 $wipFill $wipStroke 1.5 "IN: Powder-coated handles" 11
Draw-Box $g 470 130 380 60 $wipFill $wipStroke 1.5 "IN: Powder-coated head sub-assys" 11
Draw-Box $g 860 130 360 60 $wipFill $wipStroke 1.5 "IN: Rivets / hardware" 11
# Three benches
for ($i = 0; $i -lt 3; $i++) {
    $x = 100 + $i * 380
    Draw-Box $g $x 250 320 200 $nwuLightGrey $nwuDark 2 "Assembly Bench $($i + 1)`n(holding fixtures)" 12
    Draw-Op $g ($x + 160) 510 24 ("OP$($i + 1)")
    Draw-Arrow $g ($x + 80) 190 ($x + 80) 250
    Draw-Arrow $g ($x + 160) 190 ($x + 160) 250
    Draw-Arrow $g ($x + 240) 190 ($x + 240) 250
    Draw-Arrow $g ($x + 160) 450 ($x + 160) 485
}
Draw-Box $g 80 570 1140 50 $wipFill $wipStroke 1.5 "WIP-out: Assembled shovels → Packaging (C13)" 11
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Assembly bench'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP bin / lane'}
)
Save-Canvas $c (Join-Path $outDir "C12_Final_Assembly.png")

# ============================================================
# Figure C13 - Packaging Cell (3 benches)
# ============================================================
$c = New-Canvas 1300 800 "Figure C13 - Packaging Cell (incl. final visual check)" "6.6 m x 3.0 m per bench, 3 benches"
$g = $c.G
Draw-DashedBox $g 60 100 1180 580 $safetyStroke "Cell boundary"
Draw-Box $g 80 130 1140 60 $wipFill $wipStroke 1.5 "IN: Assembled shovels (from C12)" 11
# Shelving for bags + cartons
Draw-Box $g 80 220 220 250 $nwuPurpleVL $nwuPurple 1.5 "Bag &`nCarton`nShelving" 11
# Three packing benches
for ($i = 0; $i -lt 3; $i++) {
    $x = 330 + $i * 290
    Draw-Box $g $x 220 260 250 $nwuLightGrey $nwuDark 2 "Packing Bench $($i + 1)`n(bag + carton +`nfinal visual check)" 11
    Draw-Op $g ($x + 130) 520 24 ("OP$($i + 1)")
    Draw-Arrow $g ($x + 130) 190 ($x + 130) 220
    Draw-Arrow $g ($x + 130) 470 ($x + 130) 497
}
# Quarantine + pallet build
Draw-Box $g 100 580 350 80 $scrapFill $scrapStroke 1.5 "Quarantine bin (rejects)" 11
Draw-Box $g 500 580 720 80 $wipFill $wipStroke 1.5 "Pallet build position → Hand pallet truck → FG storage" 11
# Arrows to pallet build
Draw-Arrow $g 460 545 700 590
Draw-Arrow $g 745 545 860 590
Draw-Arrow $g 1035 545 1020 590
Draw-Legend $c @(
    @{Fill=$nwuLightGrey;Stroke=$nwuDark;Label='Packing bench'},
    @{Fill=$opFill;Stroke=$opStroke;Label='Operator'},
    @{Fill=$wipFill;Stroke=$wipStroke;Label='WIP / pallet'},
    @{Fill=$scrapFill;Stroke=$scrapStroke;Label='Quarantine'}
)
Save-Canvas $c (Join-Path $outDir "C13_Packaging.png")

Write-Host ""
Write-Host "All workstation PNGs saved to: $outDir"
Get-ChildItem $outDir -Filter '*.png' | Select-Object Name, @{n='KB';e={[Math]::Round($_.Length/1KB,1)}} | Format-Table -AutoSize

