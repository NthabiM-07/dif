# Build DigMore Master Facility Plan as a high-resolution PNG.
# Top-down site plan with: site boundary, building envelope, internal zones,
# all dimensions in metres, U-flow arrows, legend.
# Driven by Section 8 area schedule.

Add-Type -AssemblyName System.Drawing

$outDir = 'C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

# ---------- Canvas ----------
# Site: 80 m x 52 m (= 4160 m^2)  -> Section 8 target ~4100 m^2
# Building: 50 m x 40 m (= 2000 m^2) -> Section 8 target ~1975 m^2
# Scale: 1 m = 22 px  =>  site = 1760 x 1144 px (interior). Add 240 px border for labels.
$scale = 22
$siteW_m = 80; $siteH_m = 52
$bldgW_m = 50; $bldgH_m = 40
$marginL = 140; $marginT = 110; $marginR = 220; $marginB = 220
$canvasW = $siteW_m * $scale + $marginL + $marginR
$canvasH = $siteH_m * $scale + $marginT + $marginB

# Site origin (top-left of site rectangle, in canvas px)
$sx = $marginL; $sy = $marginT

# Building offset within site (place toward back, customer/road at front-bottom)
# Front yard (truck apron + parking) at bottom of site, 12 m deep
# Building positioned: 5 m gap left, 5 m gap right, 7 m back, 12 m front
$bldgOx_m = 5     # offset from left site edge
$bldgOy_m = 7     # offset from top site edge
$bx = $sx + $bldgOx_m * $scale
$by = $sy + $bldgOy_m * $scale
$bw = $bldgW_m * $scale
$bh = $bldgH_m * $scale

$bmp = New-Object System.Drawing.Bitmap $canvasW, $canvasH
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
$g.Clear([System.Drawing.Color]::White)

# ---------- Colours (NWU + functional palette) ----------
$cBldg     = [System.Drawing.Color]::FromArgb(255, 255, 255)
$cBldgEdge = [System.Drawing.Color]::FromArgb(35, 31, 32)        # near-black
$cSite     = [System.Drawing.Color]::FromArgb(245, 245, 245)
$cYard     = [System.Drawing.Color]::FromArgb(225, 225, 215)     # asphalt
$cReceive  = [System.Drawing.Color]::FromArgb(207, 227, 250)     # blue
$cDispatch = [System.Drawing.Color]::FromArgb(207, 227, 250)
$cRawMat   = [System.Drawing.Color]::FromArgb(255, 244, 214)     # WIP yellow
$cWIP      = [System.Drawing.Color]::FromArgb(255, 244, 214)
$cMach     = [System.Drawing.Color]::FromArgb(230, 224, 236)     # NWU light purple
$cHeat     = [System.Drawing.Color]::FromArgb(251, 227, 228)     # heat/process hazard red
$cBlast    = [System.Drawing.Color]::FromArgb(217, 217, 217)     # grey - enclosed
$cPowder   = [System.Drawing.Color]::FromArgb(251, 227, 228)     # hazard
$cAssy     = [System.Drawing.Color]::FromArgb(230, 224, 236)
$cFG       = [System.Drawing.Color]::FromArgb(216, 232, 209)     # green - finished
$cOffice   = [System.Drawing.Color]::FromArgb(240, 235, 245)     # NWU tint
$cAmen     = [System.Drawing.Color]::FromArgb(255, 240, 230)
$cExpand   = [System.Drawing.Color]::FromArgb(255, 255, 255)     # hatched
$cFlowH    = [System.Drawing.Color]::FromArgb(79, 45, 127)       # NWU purple - handle stream
$cFlowS    = [System.Drawing.Color]::FromArgb(168, 40, 40)       # red - sheet stream
$cDim      = [System.Drawing.Color]::FromArgb(110, 110, 110)
$cTitle    = [System.Drawing.Color]::FromArgb(35, 31, 32)

# ---------- Fonts ----------
$fTitle  = New-Object System.Drawing.Font("Arial", 18, [System.Drawing.FontStyle]::Bold)
$fSub    = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
$fZone   = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Bold)
$fSmall  = New-Object System.Drawing.Font("Arial", 7.5)
$fDim    = New-Object System.Drawing.Font("Arial", 8.5, [System.Drawing.FontStyle]::Italic)
$fLeg    = New-Object System.Drawing.Font("Arial", 8.5)
$fLegBold= New-Object System.Drawing.Font("Arial", 8.5, [System.Drawing.FontStyle]::Bold)

# ---------- Brushes / Pens ----------
$pBldg = New-Object System.Drawing.Pen $cBldgEdge, 3
$pZone = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(60, 60, 60)), 1
$pSite = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(80, 80, 80)), 2
$pSite.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$pDim  = New-Object System.Drawing.Pen $cDim, 1
$pExp  = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(150, 150, 150)), 1
$pExp.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$bText = New-Object System.Drawing.SolidBrush $cBldgEdge
$bDim  = New-Object System.Drawing.SolidBrush $cDim
$bWhite= New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)

# ---------- Helpers ----------
function M2P($m) { return [int]($m * $scale) }

function Draw-Zone($xm, $ym, $wm, $hm, $colour, $label, $area_m2, [string]$detail = '') {
    # Coordinates in metres relative to BUILDING top-left
    $x = $bx + (M2P $xm)
    $y = $by + (M2P $ym)
    $w = M2P $wm
    $h = M2P $hm
    $rect = New-Object System.Drawing.Rectangle $x, $y, $w, $h
    $fill = New-Object System.Drawing.SolidBrush $colour
    $g.FillRectangle($fill, $rect)
    $g.DrawRectangle($pZone, $rect)
    # Label centred
    $line1 = $label
    $line2 = "{0:N1} x {1:N1} m" -f $wm, $hm
    $line3 = "{0:N0} m^2" -f $area_m2
    $sz1 = $g.MeasureString($line1, $fZone)
    $sz2 = $g.MeasureString($line2, $fSmall)
    $sz3 = $g.MeasureString($line3, $fSmall)
    $totH = $sz1.Height + $sz2.Height + $sz3.Height
    if ($detail) {
        $sz4 = $g.MeasureString($detail, $fSmall)
        $totH += $sz4.Height
    }
    $cy = $y + ($h - $totH) / 2
    $g.DrawString($line1, $fZone,  $bText, ($x + ($w - $sz1.Width)/2), $cy)
    $cy += $sz1.Height
    $g.DrawString($line2, $fSmall, $bText, ($x + ($w - $sz2.Width)/2), $cy)
    $cy += $sz2.Height
    $g.DrawString($line3, $fSmall, $bText, ($x + ($w - $sz3.Width)/2), $cy)
    if ($detail) {
        $cy += $sz3.Height
        $sz4 = $g.MeasureString($detail, $fSmall)
        $g.DrawString($detail, $fSmall, $bText, ($x + ($w - $sz4.Width)/2), $cy)
    }
}

function Draw-DimH($xm1, $xm2, $ym, $text, [bool]$above = $true, [int]$offsetPx = 18) {
    # Horizontal dimension line at building-coord ym, between xm1 and xm2
    $x1 = $bx + (M2P $xm1); $x2 = $bx + (M2P $xm2)
    $y  = $by + (M2P $ym)
    if (-not $above) { $y = $y }
    $arrowY = $y + ($(if ($above) { -$offsetPx } else { $offsetPx }))
    $g.DrawLine($pDim, $x1, $arrowY, $x2, $arrowY)
    $g.DrawLine($pDim, $x1, $arrowY - 4, $x1, $arrowY + 4)
    $g.DrawLine($pDim, $x2, $arrowY - 4, $x2, $arrowY + 4)
    # tick marks down to objects
    $g.DrawLine($pDim, $x1, $arrowY, $x1, $y)
    $g.DrawLine($pDim, $x2, $arrowY, $x2, $y)
    $sz = $g.MeasureString($text, $fDim)
    $tx = ($x1 + $x2) / 2 - $sz.Width / 2
    $ty = $arrowY - ($(if ($above) { $sz.Height + 1 } else { -3 }))
    $g.FillRectangle($bWhite, $tx - 2, $ty, $sz.Width + 4, $sz.Height)
    $g.DrawString($text, $fDim, $bDim, $tx, $ty)
}

function Draw-DimV($ym1, $ym2, $xm, $text, [bool]$left = $true, [int]$offsetPx = 18) {
    $y1 = $by + (M2P $ym1); $y2 = $by + (M2P $ym2)
    $x  = $bx + (M2P $xm)
    $arrowX = $x + ($(if ($left) { -$offsetPx } else { $offsetPx }))
    $g.DrawLine($pDim, $arrowX, $y1, $arrowX, $y2)
    $g.DrawLine($pDim, $arrowX - 4, $y1, $arrowX + 4, $y1)
    $g.DrawLine($pDim, $arrowX - 4, $y2, $arrowX + 4, $y2)
    $g.DrawLine($pDim, $arrowX, $y1, $x, $y1)
    $g.DrawLine($pDim, $arrowX, $y2, $x, $y2)
    # rotated text
    $sz = $g.MeasureString($text, $fDim)
    $cx = $arrowX + ($(if ($left) { -8 } else { 8 }))
    $cy = ($y1 + $y2) / 2
    $state = $g.Save()
    $g.TranslateTransform($cx, $cy)
    $g.RotateTransform(-90)
    $g.FillRectangle($bWhite, -$sz.Width/2 - 2, -$sz.Height/2, $sz.Width + 4, $sz.Height)
    $g.DrawString($text, $fDim, $bDim, -$sz.Width/2, -$sz.Height/2)
    $g.Restore($state)
}

function Draw-Arrow($x1, $y1, $x2, $y2, $colour, $width = 3) {
    $p = New-Object System.Drawing.Pen $colour, $width
    $p.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
    $p.StartCap = [System.Drawing.Drawing2D.LineCap]::RoundAnchor
    $g.DrawLine($p, [int]$x1, [int]$y1, [int]$x2, [int]$y2)
    $p.Dispose()
}

function Draw-FlowArrow_M($xm1, $ym1, $xm2, $ym2, $colour) {
    $x1 = $bx + (M2P $xm1); $y1 = $by + (M2P $ym1)
    $x2 = $bx + (M2P $xm2); $y2 = $by + (M2P $ym2)
    Draw-Arrow $x1 $y1 $x2 $y2 $colour 4
}

# =================================================================
#   DRAW
# =================================================================

# ---- Title block ----
$title = "MASTER FACILITY PLAN  -  DigMore Folding Mini Shovel"
$g.DrawString($title, $fTitle, $bText, $marginL - 20, 14)
$subt = "Final layout (Alternative 2, U-flow) | Section 8 space basis | All dimensions in metres | Not to scale"
$g.DrawString($subt, $fSub, $bDim, $marginL - 20, 44)
$rev = "Drawn: 12 June 2026 | Sheet 1 of 1 | Module INGB417 GA3"
$g.DrawString($rev, $fSmall, $bDim, $marginL - 20, 64)

# ---- Site boundary ----
$siteRect = New-Object System.Drawing.Rectangle $sx, $sy, ($siteW_m * $scale), ($siteH_m * $scale)
$bSite = New-Object System.Drawing.SolidBrush $cSite
$g.FillRectangle($bSite, $siteRect)
$g.DrawRectangle($pSite, $siteRect)

# ---- Yard areas (outside building) ----
# Front yard = bottom strip (truck apron + customer parking)
# Truck apron 25 m wide at receiving/dispatch (bottom-left)
# Customer parking + visitor entry at bottom-right

# Truck apron in front of receiving/dispatch (south side of building, bottom)
$apronXm = $bldgOx_m; $apronYm = $bldgOy_m + $bldgH_m
$apronW_m = 30; $apronH_m = 12
$ax = $sx + (M2P $apronXm); $ay = $sy + (M2P $apronYm)
$aw = M2P $apronW_m; $ah = M2P $apronH_m
$bYard = New-Object System.Drawing.SolidBrush $cYard
$g.FillRectangle($bYard, $ax, $ay, $aw, $ah)
$g.DrawRectangle($pZone, $ax, $ay, $aw, $ah)
$lbl = "TRUCK APRON / DOCK YARD"
$lbl2 = "30.0 x 12.0 m  =  360 m^2"
$sz = $g.MeasureString($lbl, $fZone)
$g.DrawString($lbl, $fZone, $bText, ($ax + ($aw - $sz.Width)/2), ($ay + $ah/2 - 12))
$sz = $g.MeasureString($lbl2, $fSmall)
$g.DrawString($lbl2, $fSmall, $bText, ($ax + ($aw - $sz.Width)/2), ($ay + $ah/2 + 4))

# Customer parking (right of apron)
$parkXm = $bldgOx_m + 30; $parkYm = $apronYm
$parkW_m = 20; $parkH_m = 12
$px = $sx + (M2P $parkXm); $py = $sy + (M2P $parkYm)
$pw = M2P $parkW_m; $ph = M2P $parkH_m
$g.FillRectangle($bYard, $px, $py, $pw, $ph)
$g.DrawRectangle($pZone, $px, $py, $pw, $ph)
$lbl = "VISITOR + STAFF PARKING"
$lbl2 = "20.0 x 12.0 m  =  240 m^2  (12 bays)"
$sz = $g.MeasureString($lbl, $fZone)
$g.DrawString($lbl, $fZone, $bText, ($px + ($pw - $sz.Width)/2), ($py + $ph/2 - 12))
$sz = $g.MeasureString($lbl2, $fSmall)
$g.DrawString($lbl2, $fSmall, $bText, ($px + ($pw - $sz.Width)/2), ($py + $ph/2 + 4))

# Landscaping strips (left and right of building, plus rear)
# Use light green
$cLand = [System.Drawing.Color]::FromArgb(225, 238, 220)
$bLand = New-Object System.Drawing.SolidBrush $cLand
# Left strip
$g.FillRectangle($bLand, $sx, $sy, (M2P $bldgOx_m), ($siteH_m * $scale))
$g.DrawString("LANDSCAPING", $fSmall, $bDim, $sx + 4, $sy + ($siteH_m*$scale)/2 - 20)
$g.DrawString("5.0 m wide", $fSmall, $bDim, $sx + 4, $sy + ($siteH_m*$scale)/2 - 6)
# Right strip
$rsx = $sx + (M2P ($bldgOx_m + $bldgW_m))
$rsw = $sx + ($siteW_m * $scale) - $rsx
$g.FillRectangle($bLand, $rsx, $sy, $rsw, ($siteH_m * $scale))
$g.DrawString("LANDSCAPING", $fSmall, $bDim, $rsx + 4, $sy + ($siteH_m*$scale)/2 - 20)
$g.DrawString("25.0 m wide", $fSmall, $bDim, $rsx + 4, $sy + ($siteH_m*$scale)/2 - 6)
$g.DrawString("(future Phase 2)", $fSmall, $bDim, $rsx + 4, $sy + ($siteH_m*$scale)/2 + 8)
# Rear strip
$g.FillRectangle($bLand, ($sx + (M2P $bldgOx_m)), $sy, (M2P $bldgW_m), (M2P $bldgOy_m))
$g.DrawString("REAR LANDSCAPING  (7.0 m)", $fSmall, $bDim, ($sx + (M2P $bldgOx_m) + 10), $sy + 6)

# Re-draw site border on top
$g.DrawRectangle($pSite, $siteRect)

# ---- Building envelope (interior fill white, heavy outline) ----
$bldgRect = New-Object System.Drawing.Rectangle $bx, $by, $bw, $bh
$bBldg = New-Object System.Drawing.SolidBrush $cBldg
$g.FillRectangle($bBldg, $bldgRect)

# =================================================================
#   INTERNAL ZONES (coordinates in metres from building top-left)
# =================================================================
# Building is 50 m wide x 40 m deep. U-flow:
#   Top strip (0-8m deep): Raw mat storage (left) + Office/Amenities (right)
#   Middle band (8-32m): Production
#   Bottom strip (32-40m): Receiving/Dispatch/FG against south wall
#
# Layout grid:
#  Y bands:
#    0 - 8  m : top strip (Raw mat + Office)
#    8 - 17 m : handle stream row (tube, intl, grip, knurl) + press cell
#    17 - 24 m : finishing row 1 (heat, blast, powder coat)
#    24 - 32 m : finishing row 2 + assembly + packaging
#    32 - 40 m : FG, dispatch, receiving, customer collection
#
# X columns approx 5 m each (10 columns).

# ---- Top strip: Raw Material Storage + Office + Amenities ----
Draw-Zone 0.0  0.0  26.0  8.0  $cRawMat   "RAW MATERIAL STORAGE"     208 "(racks 12 tubes + 3 sheet pallets)"
Draw-Zone 26.0 0.0  16.0  8.0  $cOffice   "OFFICES"                  128 "(7 staff + meeting room)"
Draw-Zone 42.0 0.0  8.0   8.0  $cAmen     "AMENITIES"                64  "(change/toilets - male)"

# ---- Production row 1 (handle stream going LEFT->RIGHT) y = 8..16 ----
Draw-Zone 0.0  8.0  6.0   8.0  $cMach "1. TUBE CUT"        48  "3 saws"
Draw-Zone 6.0  8.0  5.0   8.0  $cMach "2. INT. THREAD"     40  "2 cells"
Draw-Zone 11.0 8.0  4.0   8.0  $cMach "3. GRIP END"        32  "1 cell"
Draw-Zone 15.0 8.0 11.0   8.0  $cMach "4. KNURL + EXT.THR." 88 "5 machines  (binding 99.7%)"
# WIP buffer column
Draw-Zone 26.0 8.0  3.0   8.0  $cWIP  "WIP" 24 "buffer"
# Press cell (sheet stream entry) on right
Draw-Zone 29.0 8.0 13.0   8.0  $cMach "7. SHEET-METAL PRESS CELL" 104 "2 presses + sheet staging"
Draw-Zone 42.0 8.0  8.0   8.0  $cAmen "AMENITIES" 64 "(change/toilets - female)"

# ---- Production row 2 (U-bend at right; flow turns down then back left) y = 16..24 ----
# Right side: hinge bend + head shaping (after press)
Draw-Zone 29.0 16.0 6.5  8.0  $cMach "8a. HINGE BENDING"   52 "1 cell"
Draw-Zone 35.5 16.0 6.5  8.0  $cMach "8b. HEAD SHAPING"    52 "1 cell"
Draw-Zone 42.0 16.0 8.0  8.0  $cAssy "16. FINAL ASSEMBLY"  64 "3 benches"
# Middle: sharpening bank (bottleneck) returning leftward
Draw-Zone 14.0 16.0 15.0 8.0  $cMach "9. BLADE SHARPENING" 120 "10 grinders (bottleneck 94.7%)"
Draw-Zone 7.0  16.0 7.0  8.0  $cMach "10. SERRATING"       56 "5 stations"
Draw-Zone 0.0  16.0 7.0  8.0  $cMach "11. HAND POLISHING"  56 "5 benches + extraction"

# ---- Production row 3: finishing (south of polishing) + heat/blast/powder ----
# y = 24..32
Draw-Zone 0.0  24.0  7.0  8.0  $cAssy "12. RIVETING"        56 "1 cell - streams converge"
Draw-Zone 7.0  24.0 11.0 8.0  $cHeat "13. HEAT TREATMENT"   88 "ageing oven + day buffers"
Draw-Zone 18.0 24.0  5.0 8.0  $cBlast "14. SANDBLAST"        40 "enclosed booth"
Draw-Zone 23.0 24.0 15.0 8.0  $cPowder "15. POWDER COATING (enclosed)" 120 "load-booth-cure-cool"
Draw-Zone 38.0 24.0 12.0 8.0  $cAssy "17. PACKAGING"        96 "3 benches + carton shelving"

# ---- Bottom strip: Receiving / FG / Dispatch / Customer collection ----
# y = 32..40
Draw-Zone 0.0  32.0  7.0  8.0  $cReceive  "19. RECEIVING DOCK" 56 "1 dock door"
Draw-Zone 7.0  32.0 11.0  8.0  $cWIP      "WIP STAGING"        88 "(distributed)"
Draw-Zone 18.0 32.0 20.0  8.0  $cFG       "18. FINISHED GOODS STORE" 160 "(selective racking, 3 high)"
Draw-Zone 38.0 32.0  7.0  8.0  $cDispatch "20. DISPATCH DOCK"  56 "1 dock door"
Draw-Zone 45.0 32.0  5.0  8.0  $cReceive  "21. CUST. COLLECT"  40 "pedestrian"

# Future expansion strip - 10% of building (hatched along right outer column already used; show as overlay)
# Use right-side landscaping strip as Phase-2 reserve indicator (already labelled)

# ---- Building outline on top ----
$g.DrawRectangle($pBldg, $bldgRect)

# =================================================================
#   FLOW ARROWS (U-flow)
# =================================================================
# Handle stream (purple): receiving (bottom-left) -> raw mat (top-left) -> tube cut -> ... -> knurl
Draw-FlowArrow_M 3.5 32.0  3.5 16.5  $cFlowH   # receiving up to raw mat
Draw-FlowArrow_M 3.0  8.0 26.0  8.0  $cFlowH   # raw mat right - feeds handle row (label only)
Draw-FlowArrow_M 6.0 12.0 11.0 12.0  $cFlowH
Draw-FlowArrow_M 11.0 12.0 15.0 12.0 $cFlowH
Draw-FlowArrow_M 15.0 12.0 26.0 12.0 $cFlowH
Draw-FlowArrow_M 29.0 12.0 35.0 16.0 $cFlowH   # knurl down to riveting via sharpening
# U-bend down right side
Draw-FlowArrow_M 42.0  8.0 42.0 16.0 $cFlowS   # press to hinge/head
Draw-FlowArrow_M 38.0 20.0 42.0 20.0 $cFlowS
Draw-FlowArrow_M 46.0 20.0 46.0 24.0 $cFlowS
# Finishing return left
Draw-FlowArrow_M 38.0 28.0 23.0 28.0 $cFlowS
Draw-FlowArrow_M 23.0 28.0 18.0 28.0 $cFlowS
Draw-FlowArrow_M 18.0 28.0  7.0 28.0 $cFlowS
# Riveting to packaging to FG to dispatch (assembled product purple)
Draw-FlowArrow_M  3.5 32.0  3.5 32.0 $cFlowH   # placeholder
Draw-FlowArrow_M 14.0 28.0 14.0 16.0 $cFlowH   # sharpening up from polishing (return)
Draw-FlowArrow_M  3.5 24.0 18.0 36.0 $cFlowH   # riveting to FG
Draw-FlowArrow_M 28.0 36.0 41.0 36.0 $cFlowH   # FG to dispatch
Draw-FlowArrow_M 42.0 28.0 44.0 32.0 $cFlowH   # packaging to FG/dispatch

# =================================================================
#   DIMENSIONS - building envelope (heavy outer)
# =================================================================
# Building width across top (above building)
Draw-DimH 0.0 50.0 0.0 "Building width: 50.00 m" $true 24
# Building depth on left (left of building)
Draw-DimV 0.0 40.0 0.0 "Building depth: 40.00 m" $true 35
# Site width across very top (placed above site boundary, well clear of title block)
$g.DrawString("SITE BOUNDARY: 80.0 m wide x 52.0 m deep  =  4 160 m^2 total site area", $fSub, $bText, $marginL, 88)
# Site dims on right
$g.DrawString("SITE RIGHT EDGE", $fSmall, $bDim, $sx + ($siteW_m*$scale) + 6, $sy + 10)
$g.DrawString("80.00 m total width", $fSmall, $bDim, $sx + ($siteW_m*$scale) + 6, $sy + 24)
$g.DrawString("52.00 m total depth", $fSmall, $bDim, $sx + ($siteW_m*$scale) + 6, $sy + 38)
# Yard depth dimension on right of apron
Draw-DimV 40.0 52.0 50.0 "Front yard: 12.00 m" $false 30

# Per-zone column widths along top of building (between heading dim and building) -- skip for clarity; per-zone size shown inside each box

# =================================================================
#   COMPASS + SCALE BAR
# =================================================================
# Compass (top-right of canvas)
$ncx = $canvasW - 130; $ncy = 50
$g.DrawEllipse($pSite, $ncx - 22, $ncy - 22, 44, 44)
$pArrow = New-Object System.Drawing.Pen ([System.Drawing.Color]::Black), 2
$pArrow.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$g.DrawLine($pArrow, $ncx, $ncy + 16, $ncx, $ncy - 20)
$g.DrawString("N", $fSub, $bText, $ncx - 6, $ncy - 38)
$pArrow.Dispose()

# Scale bar (bottom-left)
$sbx = $marginL; $sby = $canvasH - 60
$tenM = M2P 10
$g.FillRectangle($bText, $sbx, $sby, $tenM, 10)
$g.FillRectangle($bWhite, $sbx + $tenM, $sby, $tenM, 10)
$g.DrawRectangle($pZone, $sbx, $sby, $tenM * 2, 10)
$g.DrawString("0", $fSmall, $bText, $sbx - 3, $sby + 12)
$g.DrawString("10", $fSmall, $bText, $sbx + $tenM - 6, $sby + 12)
$g.DrawString("20 m", $fSmall, $bText, $sbx + $tenM*2 - 6, $sby + 12)
$g.DrawString("SCALE 1:200 (nominal)", $fSmall, $bDim, $sbx, $sby - 14)

# =================================================================
#   LEGEND (bottom-right)
# =================================================================
$lx = $canvasW - 460; $ly = $canvasH - 220
$g.FillRectangle($bWhite, $lx + 1, $ly + 1, 438, 198)
$g.DrawRectangle($pZone, $lx, $ly, 440, 200)
$g.DrawString("LEGEND", $fSub, $bText, $lx + 8, $ly + 6)

$items = @(
    @{ c = $cReceive; t = "Receiving / Dispatch / Customer" },
    @{ c = $cRawMat;  t = "Raw material storage / WIP buffers" },
    @{ c = $cMach;    t = "Production workstations (machining)" },
    @{ c = $cHeat;    t = "Heat process / hazard zone" },
    @{ c = $cBlast;   t = "Enclosed sandblast booth" },
    @{ c = $cPowder;  t = "Enclosed powder-coat line" },
    @{ c = $cAssy;    t = "Assembly + packaging" },
    @{ c = $cFG;      t = "Finished-goods storage" },
    @{ c = $cOffice;  t = "Offices (visitor side)" },
    @{ c = $cAmen;    t = "Amenities (change/toilets/cafeteria)" }
)
$row = $ly + 26
foreach ($it in $items) {
    $fb = New-Object System.Drawing.SolidBrush $it.c
    $g.FillRectangle($fb, $lx + 10, $row, 18, 14)
    $g.DrawRectangle($pZone, $lx + 10, $row, 18, 14)
    $g.DrawString($it.t, $fLeg, $bText, $lx + 34, $row)
    $row += 16
    $fb.Dispose()
}

# Flow arrow legend (right column of legend box)
$g.DrawString("FLOW:", $fLegBold, $bText, $lx + 270, $ly + 26)
$pH = New-Object System.Drawing.Pen $cFlowH, 4
$pH.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$pS = New-Object System.Drawing.Pen $cFlowS, 4
$pS.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$g.DrawLine($pH, $lx + 270, $ly + 50, $lx + 310, $ly + 50)
$g.DrawString("Handle stream", $fLeg, $bText, $lx + 316, $ly + 44)
$g.DrawLine($pS, $lx + 270, $ly + 72, $lx + 310, $ly + 72)
$g.DrawString("Sheet stream", $fLeg, $bText, $lx + 316, $ly + 66)
$pH.Dispose(); $pS.Dispose()

# Area summary in legend
$g.DrawString("AREA SUMMARY (m^2):", $fLegBold, $bText, $lx + 270, $ly + 96)
$g.DrawString("Production workstations: 420", $fLeg, $bText, $lx + 270, $ly + 112)
$g.DrawString("Raw materials + WIP:      270", $fLeg, $bText, $lx + 270, $ly + 126)
$g.DrawString("Finishing (HT/blast/PC):  280", $fLeg, $bText, $lx + 270, $ly + 140)
$g.DrawString("Receiving / Dispatch / FG: 295", $fLeg, $bText, $lx + 270, $ly + 154)
$g.DrawString("Office + amenities:       320", $fLeg, $bText, $lx + 270, $ly + 168)
$g.DrawString("Building footprint: ~2000 m^2", $fLegBold, $bText, $lx + 270, $ly + 184)

# =================================================================
#   DOCK DOORS (drawn on south wall)
# =================================================================
# Receiving dock at x = 3 m, dispatch at x = 41 m on south wall
$pDoor = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(160, 50, 50)), 5
$g.DrawLine($pDoor, ($bx + (M2P 1)),  ($by + (M2P 40)), ($bx + (M2P 6)),  ($by + (M2P 40)))
$g.DrawLine($pDoor, ($bx + (M2P 39)), ($by + (M2P 40)), ($bx + (M2P 44)), ($by + (M2P 40)))
$g.DrawString("Receiving dock door", $fSmall, $bDim, ($bx + (M2P 1)), ($by + (M2P 40) + 4))
$g.DrawString("Dispatch dock door", $fSmall, $bDim, ($bx + (M2P 39)), ($by + (M2P 40) + 4))
# Customer pedestrian entry
$g.DrawLine($pDoor, ($bx + (M2P 46)), ($by + (M2P 40)), ($bx + (M2P 48)), ($by + (M2P 40)))
$g.DrawString("Customer entry", $fSmall, $bDim, ($bx + (M2P 45)), ($by + (M2P 40) + 18))
# Staff entry on north wall (visitor side)
$g.DrawLine($pDoor, ($bx + (M2P 30)), $by, ($bx + (M2P 32)), $by)
$g.DrawString("Staff entry", $fSmall, $bDim, ($bx + (M2P 28)), $by - 14)
$pDoor.Dispose()

# Save
$out = Join-Path $outDir "DigMore_MFP_Final.png"
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Host "Saved: $out"
Write-Host "Size:  $((Get-Item $out).Length / 1KB) KB"
Write-Host "Dims:  $canvasW x $canvasH px"
