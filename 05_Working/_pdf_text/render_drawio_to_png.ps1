# Render a drawio file to PNG using System.Drawing (no external dependencies).
# This is an APPROXIMATE renderer designed to clearly show vertices and edges
# with arrowheads ON TOP of boxes. It does not replicate every drawio style.
#
# Usage: render_drawio_to_png.ps1 -Src <file.drawio> -Dst <file.png> [-Scale 1.5]

param(
    [Parameter(Mandatory)][string]$Src,
    [Parameter(Mandatory)][string]$Dst,
    [double]$Scale = 1.0
)

Add-Type -AssemblyName System.Drawing

function ParseStyle([string]$s) {
    $h = @{}
    if ([string]::IsNullOrWhiteSpace($s)) { return $h }
    foreach ($kv in ($s -split ';' | Where-Object { $_ -ne '' })) {
        $p = $kv -split '=', 2
        if ($p.Count -eq 2) { $h[$p[0]] = $p[1] } else { $h[$p[0]] = $true }
    }
    return $h
}

function ParseColor([string]$c, $fallback) {
    if ([string]::IsNullOrWhiteSpace($c) -or $c -eq 'none' -or $c -eq 'default') { return $fallback }
    if ($c -notmatch '^#') { $c = '#' + $c }
    try { return [System.Drawing.ColorTranslator]::FromHtml($c) } catch { return $fallback }
}

function StripHtml([string]$s) {
    if ($s -eq $null) { return '' }
    $s = $s -replace '<br\s*/?>',"`n"
    $s = $s -replace '<[^>]+>',''
    $s = $s -replace '&amp;','&'
    $s = $s -replace '&lt;','<'
    $s = $s -replace '&gt;','>'
    $s = $s -replace '&quot;','"'
    $s = $s -replace '&nbsp;',' '
    return $s
}

[xml]$doc = Get-Content -LiteralPath $Src -Raw

$model = $doc.SelectSingleNode('//mxGraphModel')
$pageW = [int]([double]$model.GetAttribute('pageWidth'))
$pageH = [int]([double]$model.GetAttribute('pageHeight'))
if ($pageW -le 0) { $pageW = 1654 }
if ($pageH -le 0) { $pageH = 1169 }

$w = [int]($pageW * $Scale)
$h = [int]($pageH * $Scale)

$bmp = New-Object System.Drawing.Bitmap $w, $h
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.Clear([System.Drawing.Color]::White)

# Build vertex map
$vertices = @{}
foreach ($v in $doc.SelectNodes("//mxCell[@vertex='1']")) {
    $geo = $v.SelectSingleNode('mxGeometry')
    if (-not $geo) { continue }
    $id = $v.GetAttribute('id')
    $vertices[$id] = @{
        Id = $id
        X = [double]$geo.GetAttribute('x')
        Y = [double]$geo.GetAttribute('y')
        W = [double]$geo.GetAttribute('width')
        H = [double]$geo.GetAttribute('height')
        Style = ParseStyle ($v.GetAttribute('style'))
        Value = StripHtml ($v.GetAttribute('value'))
    }
}

# ---------- Draw vertices (boxes first, so edges are drawn on top) ----------
foreach ($key in $vertices.Keys) {
    $v = $vertices[$key]
    $x = $v.X * $Scale; $y = $v.Y * $Scale
    $vw = $v.W * $Scale; $vh = $v.H * $Scale

    $isText = $v.Style.ContainsKey('text')
    $fill   = ParseColor $v.Style['fillColor']   ([System.Drawing.Color]::White)
    $stroke = ParseColor $v.Style['strokeColor'] ([System.Drawing.Color]::FromArgb(35,31,32))
    $font   = ParseColor $v.Style['fontColor']   ([System.Drawing.Color]::FromArgb(35,31,32))

    $strokeNone = ($v.Style['strokeColor'] -eq 'none')
    $fillNone   = ($v.Style['fillColor']   -eq 'none')

    if (-not $isText) {
        # Background rectangle
        if (-not $fillNone -and $v.Style['fillColor']) {
            $brush = New-Object System.Drawing.SolidBrush $fill
            $g.FillRectangle($brush, $x, $y, $vw, $vh)
            $brush.Dispose()
        }
        if (-not $strokeNone) {
            $sw = 2.0
            if ($v.Style['strokeWidth']) { $sw = [double]$v.Style['strokeWidth'] }
            $pen = New-Object System.Drawing.Pen $stroke, ([single]($sw * $Scale))
            $g.DrawRectangle($pen, $x, $y, $vw, $vh)
            $pen.Dispose()
        }
    }

    # Text (label)
    if (-not [string]::IsNullOrWhiteSpace($v.Value)) {
        $fontSize = 10
        if ($v.Style['fontSize']) { $fontSize = [int]$v.Style['fontSize'] }
        $fontStyle = [System.Drawing.FontStyle]::Regular
        if ($v.Style['fontStyle'] -eq '1' -or $v.Style['fontStyle'] -eq '5' -or $v.Style['fontStyle'] -eq '3') {
            $fontStyle = [System.Drawing.FontStyle]::Bold
        }
        $f = New-Object System.Drawing.Font 'Segoe UI', ([single]($fontSize * $Scale * 0.85)), $fontStyle
        $tb = New-Object System.Drawing.SolidBrush $font
        $sf = New-Object System.Drawing.StringFormat
        $align = $v.Style['align']
        $valign = $v.Style['verticalAlign']
        switch ($align) {
            'left'   { $sf.Alignment = [System.Drawing.StringAlignment]::Near }
            'right'  { $sf.Alignment = [System.Drawing.StringAlignment]::Far }
            default  { $sf.Alignment = [System.Drawing.StringAlignment]::Center }
        }
        switch ($valign) {
            'top'    { $sf.LineAlignment = [System.Drawing.StringAlignment]::Near }
            'bottom' { $sf.LineAlignment = [System.Drawing.StringAlignment]::Far }
            default  { $sf.LineAlignment = [System.Drawing.StringAlignment]::Center }
        }
        $rect = New-Object System.Drawing.RectangleF $x, $y, $vw, $vh
        $g.DrawString($v.Value, $f, $tb, $rect, $sf)
        $f.Dispose(); $tb.Dispose(); $sf.Dispose()
    }
}

# ---------- Draw edges ON TOP ----------
function GetAnchorPoint($v, $style, $isExit) {
    $px = $v.X + $v.W / 2.0
    $py = $v.Y + $v.H / 2.0
    if ($isExit) {
        if ($style['exitX']) { $px = $v.X + [double]$style['exitX'] * $v.W }
        if ($style['exitY']) { $py = $v.Y + [double]$style['exitY'] * $v.H }
    } else {
        if ($style['entryX']) { $px = $v.X + [double]$style['entryX'] * $v.W }
        if ($style['entryY']) { $py = $v.Y + [double]$style['entryY'] * $v.H }
    }
    return @{ X = $px; Y = $py }
}

function DrawArrowhead($g, $pen, $brush, $fromX, $fromY, $toX, $toY, $size) {
    $dx = $toX - $fromX
    $dy = $toY - $fromY
    $len = [Math]::Sqrt($dx * $dx + $dy * $dy)
    if ($len -lt 0.001) { return }
    $ux = $dx / $len; $uy = $dy / $len
    # base of arrowhead
    $bx = $toX - $ux * $size
    $by = $toY - $uy * $size
    # perpendicular
    $px = -$uy * ($size * 0.45)
    $py =  $ux * ($size * 0.45)
    $p1 = New-Object System.Drawing.PointF $toX, $toY
    $p2 = New-Object System.Drawing.PointF ($bx + $px), ($by + $py)
    $p3 = New-Object System.Drawing.PointF ($bx - $px), ($by - $py)
    $pts = [System.Drawing.PointF[]]@($p1, $p2, $p3)
    $g.FillPolygon($brush, $pts)
}

foreach ($e in $doc.SelectNodes("//mxCell[@edge='1']")) {
    $srcId = $e.GetAttribute('source')
    $tgtId = $e.GetAttribute('target')
    if (-not $vertices.ContainsKey($srcId) -or -not $vertices.ContainsKey($tgtId)) { continue }
    $style = ParseStyle ($e.GetAttribute('style'))

    $sv = $vertices[$srcId]; $tv = $vertices[$tgtId]
    $sp = GetAnchorPoint $sv $style $true
    $tp = GetAnchorPoint $tv $style $false

    $sx = $sp.X * $Scale; $sy = $sp.Y * $Scale
    $tx = $tp.X * $Scale; $ty = $tp.Y * $Scale

    $stroke = ParseColor $style['strokeColor'] ([System.Drawing.Color]::FromArgb(35,31,32))
    $sw = 2.0
    if ($style['strokeWidth']) { $sw = [double]$style['strokeWidth'] }
    $pen = New-Object System.Drawing.Pen $stroke, ([single]($sw * $Scale))
    $brush = New-Object System.Drawing.SolidBrush $stroke

    # Build orthogonal route: source -> bend -> target (L or Z shape)
    $useOrth = ($style['edgeStyle'] -eq 'orthogonalEdgeStyle')

    $pts = New-Object System.Collections.Generic.List[System.Drawing.PointF]
    $pts.Add((New-Object System.Drawing.PointF $sx, $sy)) | Out-Null

    if ($useOrth) {
        # Decide based on exit/entry orientation
        $exitX = if ($style['exitX']) { [double]$style['exitX'] } else { 0.5 }
        $exitY = if ($style['exitY']) { [double]$style['exitY'] } else { 0.5 }
        $entryX = if ($style['entryX']) { [double]$style['entryX'] } else { 0.5 }
        $entryY = if ($style['entryY']) { [double]$style['entryY'] } else { 0.5 }

        # Determine source-exit direction
        $exitVert = ($exitY -eq 0 -or $exitY -eq 1)
        $entryVert = ($entryY -eq 0 -or $entryY -eq 1)

        if ($exitVert -and $entryVert) {
            # Both vertical: Z shape via midpoint Y
            $midY = ($sy + $ty) / 2.0
            $pts.Add((New-Object System.Drawing.PointF $sx, $midY)) | Out-Null
            $pts.Add((New-Object System.Drawing.PointF $tx, $midY)) | Out-Null
        } elseif (-not $exitVert -and -not $entryVert) {
            # Both horizontal: Z via midpoint X
            $midX = ($sx + $tx) / 2.0
            $pts.Add((New-Object System.Drawing.PointF $midX, $sy)) | Out-Null
            $pts.Add((New-Object System.Drawing.PointF $midX, $ty)) | Out-Null
        } elseif ($exitVert -and -not $entryVert) {
            # L: vertical first then horizontal -> bend at (sx, ty)
            $pts.Add((New-Object System.Drawing.PointF $sx, $ty)) | Out-Null
        } else {
            # L: horizontal first then vertical -> bend at (tx, sy)
            $pts.Add((New-Object System.Drawing.PointF $tx, $sy)) | Out-Null
        }
    }
    $pts.Add((New-Object System.Drawing.PointF $tx, $ty)) | Out-Null

    if ($pts.Count -ge 2) {
        $arr = $pts.ToArray()
        $g.DrawLines($pen, $arr)
        # Arrowhead at end
        $arrSize = 12 * $Scale
        if ($style['endSize']) { $arrSize = [double]$style['endSize'] * $Scale }
        $p_n = $arr[$arr.Length - 2]
        $p_e = $arr[$arr.Length - 1]
        DrawArrowhead $g $pen $brush $p_n.X $p_n.Y $p_e.X $p_e.Y $arrSize
    }

    $pen.Dispose(); $brush.Dispose()
}

$g.Dispose()
$bmp.Save($Dst, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "Saved $Dst ($w x $h)"
