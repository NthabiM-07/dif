# Relabel TIPTOP TABLES drawio template -> DigMore
$src = "C:\Users\NB444144\Downloads\INGB 417 EXAM ASSIGNMENT\INGB 417 EXAM ASSIGNMENT\05_Working\5.4_MFP_and_Layouts\DigMore_MFP_v2.drawio"
$bak = $src + ".bak"
Copy-Item $src $bak -Force

$text = Get-Content $src -Raw -Encoding UTF8

# Ordered list of (find, replace) pairs.
# Longest / most specific first to avoid double-replacing.
$pairs = @(
    # TITLE
    @('Master Facility Plan for TIPTOP TABLES', 'Master Facility Plan for DigMore (Folding Mini Shovel)'),
    @('TIPTOP TABLES', 'DIGMORE'),

    # OFD operations (chair/table -> shovel: handle/head)
    @('Table &amp;amp; Chair Cutting', 'Tube + Sheet Cutting'),
    @('Tabletop frame manual welding', 'Manual Welding (Heads)'),
    @('Slider automatic welding', 'Automated Welding (Handles)'),
    @('Outsourcing of rattan backing', 'Sandblast + Heat Treat'),
    @('Rubber levelling feet put on', 'Final QC + Inspection'),
    @('&amp;nbsp;Stacking &amp;amp; tiestrapping', '&amp;nbsp;Stacking &amp;amp; strapping'),
    @('Are the cut &lt;br&gt;pieces for a chair or table?', 'Cut pieces:&lt;br&gt;handle or head?'),
    @('Are the cut&lt;br&gt;pieces for slider or frame?', 'Handle type:&lt;br&gt;telescopic or fixed?'),

    # Branch labels (1-2 char words appear standalone in <value="...">)
    @('value="Slider"',  'value="Handles"'),
    @('value="Frame"',   'value="Heads/Blades"'),
    @('value="Chair"',   'value="Case Pack"'),
    @('value="Table"',   'value="Single Pack"'),

    # Suppliers and consumables
    @('Aluminium Supplier', 'Steel Tube + Sheet Supplier'),
    @('Rubber Feet Supplier', 'Powder + Consumables Supplier'),
    @('Rubber feet storage', 'Powder consumables storage'),

    # Storage / WIP
    @('Small order storage', 'Single-pack WIP'),
    @('Large order storage', 'Case-pack WIP'),

    # Packaging stations
    @('Set packaging', 'Case packing (6/box)'),
    @('Unit packaging', 'Single-unit packing'),
    @('Pack-age', 'Package'),

    # MFP zone labels (FG storage)
    @('Finished chair storage', 'FG storage (case packs)'),
    @('Finished table storage', 'FG storage (single packs)'),

    # MFP loading bays
    @('Chairs Loading Bay', 'FG Loading Bay (Case Packs)'),
    @('Tables Loading Bay', 'FG Loading Bay (Single Packs)'),
    @('Rattan Loading Bay', 'Sandblast / Powder Inbound'),

    # MFP zone 9 (Rattan Chair Storage -> Sandblast + WIP)
    @('9. Rattan Chair Storage', '9. Sandblast Booth + WIP Buffer'),
    @('span&gt;Rattan Chair Storage&lt;', 'span&gt;Sandblast + WIP Buffer&lt;'),

    # Bare "Rattan" zone labels (appear with size suffixes)
    @('value="Rattan&lt;br&gt;', 'value="Sandblast WIP&lt;br&gt;'),
    @('&amp;gt;Rattan&lt;', '&amp;gt;Sandblast WIP&lt;'),

    # Legend items
    @('Rattan Storage', 'Sandblast WIP'),
    @('Chair w/o rattan backing', 'Shovel (no head fitted)'),
    @('Chair with rattan backing', 'Shovel (assembled)'),
    @('Box with 5 tables', 'Case pack (6 shovels)'),

    # Misc OFD endpoint text (kept generic)
    @('Customers', 'Customer / Distributor')
)

$total = 0
foreach ($p in $pairs) {
    $find = $p[0]
    $rep  = $p[1]
    $before = ([regex]::Matches($text, [regex]::Escape($find))).Count
    if ($before -gt 0) {
        $text = $text.Replace($find, $rep)
        Write-Host ("OK  [{0,3} hit(s)]  {1}" -f $before, ($find -replace '\s+',' ').Substring(0, [Math]::Min(70,$find.Length)))
        $total += $before
    } else {
        Write-Host ("--  [  0 hit(s)]  {0}" -f ($find -replace '\s+',' ').Substring(0, [Math]::Min(70,$find.Length)))
    }
}
Write-Host ""
Write-Host ("Total replacements: " + $total)

Set-Content -Path $src -Value $text -Encoding UTF8 -NoNewline
Write-Host ("Saved: " + $src)
Write-Host ("Backup: " + $bak)

# Validate XML
try {
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($src)
    $diags = $doc.SelectNodes('//diagram')
    Write-Host ("XML OK. pages=" + $diags.Count)
} catch {
    Write-Host ("XML ERR: " + $_.Exception.Message)
}
