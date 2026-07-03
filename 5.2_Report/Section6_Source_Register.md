# Section 6 — Source and Figure Register
All links below marked **Verified** were opened and checked on **10 June 2026**. Items marked **TO SOURCE** have NOT yet been verified — no link is given, and one must be found and opened before citation. All equipment sources are **market examples for sizing, workstation design and illustration only — not procurement recommendations**. Where images are copyrighted, use the link as a cited visual reference and redraw a simplified version (diagrams.net / PowerPoint).

## A. Product and process figures

| Report subsection | Equipment / figure needed | Recommended source link | Supplier / manufacturer | Key specifications to extract | Why it fits DigMore | How to use in report |
|---|---|---|---|---|---|---|
| 6 intro (Fig 6.1) | Folding shovel component breakdown | None needed — draw from brief product description | — | Component names, materials, dimensions from brief | It is the DigMore product itself | Original exploded-view sketch; no external source required |
| 6.1 (Fig 6.2) | High-level material flow receiving→dispatch | None needed — derive from brief + §6.1 flow logic; method per Tompkins et al. (Facilities Planning) | Textbook reference | Flow-diagramming convention only | Standard IE method | Original diagram; cite Tompkins for method if required |
| 6.2/6.3 (Fig 6.3) | Tube/sheet split-flow diagram | None needed — derive from Capacity sheet routing | — | Process sequence per workbook | Matches DigMore routing | Original diagram |
| 6.3.x workstation figures | Example workstation layouts (cutting, stamping, bending, riveting, polishing, powder coating, assembly, packaging) | Use the verified machine pages in §B below as visual references for machine proportions | Per §B | Machine outline dimensions | Same machine classes | Redraw simplified plan-view workstation concepts; caption "Adapted from [supplier page]" |

## B. Manufacturing machines

| Report subsection | Equipment needed | Recommended source link | Supplier / manufacturer | Key specifications to extract | Why it fits DigMore | How to use in report | Status |
|---|---|---|---|---|---|---|---|
| 6.3.1 | Automatic non-ferrous saw with bar feed | https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/ | ProfiFeed Technologies | Bar feeding, cut-to-length, servo positioning, CE guarding; dimensions [VERIFY datasheet] | Cuts 6 m aluminium stock to short repeat lengths at high cycle counts; guarding removes operator from blade | Machine example in Table 6.8; visual reference for Fig 6.4 (redraw) | **Verified** |
| 6.3.2 | Internal threading (tapping) machine | https://www.cotswold-machinery-sales.co.uk/roscamat-tapping-machines/electric-tapping-machines/roscamat-tiger-electric-tapping-machine/ | Roscamat (Tecnospiro) via Cotswold Machinery Sales (official distributor) | Thread capacity to M30 aluminium; 1 020 mm working radius; torque-limited tap holders; 220 V | Covers internal thread in Ø31.7 mm aluminium pipe; bench-cell scale matches 6 m² workstation | Machine example in Table 6.9 | **Verified** |
| 6.3.3 | Tube end narrowing / swaging | https://www.hippobender.com/tube-end-former/ | Hippo (tube end formers) | Ram-type reduction/swaging principle; standard range 4–20 mm — model for Ø31.7 mm [VERIFY] | Exact process (end reduction by die); class confirmed, model TBC | Machine class reference in Table 6.10; process description support | **Verified** (class only) |
| 6.3.4 | Knurling + external thread rolling | https://profimach.com/special-machine/2-roll-thread-roll-machines-ptr-series | Profimach | PTR 42: Ø6–42 mm, 150 kN, 1 500 × 1 580 × 1 140 mm, 4.0 kW, 1 400 kg | Capacity spans Ø31.7 mm; chipless cold-forming suits thin-wall aluminium; published full spec table | Machine example + dimensions in Table 6.11; footprint check of 6 m² allowance | **Verified** |
| 6.3.5/6.3.6 | Mechanical/hydraulic press + progressive die (head & hinge stamping) | — | e.g. press manufacturers with SA distribution | Press tonnage, bed size, strokes/min, footprint | 2 s cycle stamping of 2.5 mm aluminium | Machine example + Fig 6.5 reference | TO SOURCE |
| 6.3.7/6.3.8 | Press brake / forming press (hinge bending, head shaping) | — | e.g. press brake manufacturers (note: Euromac press brakes seen on verified Cotswold site — open the specific product page before citing) | Tonnage, bed length, footprint | Short-stroke forming of small aluminium blanks | Machine example | TO SOURCE |
| 6.3.9 | Blade sharpening grinder | — | Belt/disc grinding machine manufacturer | Belt speed, contact wheel, dust extraction, footprint | 120 s manual-assisted sharpening; 8-station bank | Machine example + Fig 6.6 | TO SOURCE |
| 6.3.10 | Serrating / notching equipment | — | Notching machine or serration grinding manufacturer | Cycle, tooling, footprint | 60 s serration of blade edge | Machine example | TO SOURCE |
| 6.3.11 | Riveting machine | — | Pneumatic/hydraulic riveter manufacturer | Throat depth, force, cycle | 5 s hinge-to-head riveting | Machine example | TO SOURCE |
| 6.3.12 | Aluminium ageing (T6) oven | — | Industrial oven manufacturer | Chamber size, temperature range, batch capacity | 6 h ageing cycle, ~1 819 subassemblies/day | Machine example; confirms 80 m² allowance | TO SOURCE |
| 6.3.13 | Sandblasting booth / cabinet | — | Blast equipment manufacturer (SA: e.g. blast-room suppliers) | Booth size, extraction, media | Enclosed blasting of head subassemblies | Machine example | TO SOURCE |
| 6.3.15 | Conveyorised powder-coating line | — | Powder line integrator | Line rate (~600 parts/h basis), booth + cure oven dimensions, ventilation | Enclosed area sizing (120 m²); 2 lines per workbook | Machine example + Fig 6.7 | TO SOURCE |
| 6.3.16/6.3.17 | Assembly benches; packaging benches + carton sealer | — | Industrial workbench / packaging equipment supplier | Bench dimensions, sealer throughput | Manual assembly (30 s) and packaging (30 s) cells | Workstation sizing | TO SOURCE |

## C. Storage and material handling

| Report subsection | Equipment needed | Recommended source link | Supplier / manufacturer | Key specifications to extract | Why it fits DigMore | How to use in report | Status |
|---|---|---|---|---|---|---|---|
| 6.6 | Cantilever racking (990 tubes) | https://www.krostshelving.com/warehouse-storage-solutions/industrial-racking-systems/cantilever-racking/ | Krost Shelving & Racking (SA) | Arm capacities, single/double entry, adjustability | SA supplier; designed for long tube/bar storage | Racking example + Fig 6.9 basis; check 250 tubes/rack and 6 m² footprint assumptions | **Verified** |
| 6.2 | Tube stock standard (6 m) | https://www.premiumaluminium.co.za/aluminium-round-tube/ | Premium Aluminium (SA) | 6 m standard length (supports stock length only — NOT the Ø31.70 × 3.18 mm size) | SA supplier confirming purchasing unit | Footnote to Table 6.4 | **Verified** |
| 6.2 | Sheet stock standard (2 500 × 1 250 × 2.5 mm) | https://www.eurosteel.co.za/aluminium-sheets/ | Euro Steel (SA) | Standard sizes incl. 2 500 × 1 250; thickness to 2.5 mm | SA supplier confirming sheet purchasing unit | Footnote to Table 6.4 | **Verified** |
| 6.2 | Saw kerf allowance | https://coldsawbladestore.com/cold-saw-blade-guide/ | Cold Saw Blade Store | 2.2 mm chip-breaker kerf; 2.5 mm blade plate — practical allowance only, not a universal standard | Supports 39 sections/tube basis | In-text reference in §6.2 | **Verified** |
| 6.6 | Sheet-metal storage rack | — | Sheet rack / A-frame supplier (SA preferred) | Capacity, footprint | 240-sheet store beside presses | Storage example | TO SOURCE |
| 6.6 | Pallet racking (finished goods, 91 pallets) | — | SA racking supplier (Krost also offers pallet racking — open the specific page before citing) | Bay dimensions, levels, load/bay | 3-level FG racking per Storage_3D | Storage example + Fig 6.10 | TO SOURCE |
| 6.6 | WIP trolleys / tube carts | — | Industrial trolley supplier | Deck size, capacity | Inter-station moves in both streams | MH example | TO SOURCE |
| 6.6 | Scrap bins | — | Steel bin supplier | Volume, forklift pockets | Cutting + stamping scrap routes | MH example | TO SOURCE |
| 6.5/6.6 | Pallet jack and counterbalance forklift | — | SA dealer (e.g. major forklift brands' SA pages) | Capacity, aisle requirement, turning radius | 5 pallets/day dispatch; tube bundle handling | Aisle-width design input | TO SOURCE |
| 6.5 | Dock leveller / loading dock equipment | — | SA dock equipment supplier | Leveller size, capacity, pit dimensions | Own-fleet large-order dispatch; 250 m² receiving/dispatch | Receiving/dispatch design + Fig 6.8 | TO SOURCE |

## Rules applied
1. No link listed unless opened and verified; TO SOURCE rows deliberately carry no URL.
2. Premium Aluminium supports the 6 m length only; Euro Steel supports sheet size/thickness; Cold Saw Blade Store supports a practical kerf allowance only.
3. All machine links are market examples, not procurement selections.
4. Bought-out items (bags, rivets), rivet quantity (2/shovel) and bought-out stock cover are assumptions marked [VERIFY] in the report.
