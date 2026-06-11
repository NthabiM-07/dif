# CLAUDE.md — INGB417 GA3 Facility Design (DigMore) — project handoff

Working context for the DigMore folding mini shovel facility design report (INGB417 GA3, 2026).
On a NEW chat: connect this folder and say "read CLAUDE.md and continue with Section 5 (capacity analysis)".
Sections 1–4 and the process flow diagram are drafted; next is the capacity analysis onward.

## Folder structure (reorganised)
- 00_Admin/                  Academic integrity / AI declaration; exit-interview schedule.
- 01_Assignment_Brief/       INGB417 FacilityDesign GA3 ...June2026_Rev1.pdf  (the ONLY controlling document).
- 02_Module_Lessons/         14 lecture PDFs (Design Process, SLP technique + tutorial, Flow/Activities/Space,
                             Material Handling, Warehouse/Personnel/Auxiliary, Alternatives, Report guidance, etc.).
- 03_Reference_Textbooks/    Stephens & Meyers; Tompkins (theory basis only).
- 04_Benchmarks_style_only/  2025 benchmark reports + MFP examples + xlsx (STYLE/structure guides ONLY).
- 05_Working/                Active build:
    5.1_Capacity_Model/      417.xlsx  (to become the capacity/space workbook = single source of truth).
    5.2_Report/              417.docx (student master report) + DigMore_Facility_Design_Sections_1-4_DRAFT.docx.
    5.3_Process_Flow/        DigMore_Process_Flow.drawio + .png.
    5.4_MFP_and_Layouts/     Alternatives.drawio.pdf + (future) Master Facility Plan.
- 06_Final_Submission/       (empty) final report PDF + MFP source (Draw.io/Rayon) + MFP PDF go here.
- 99_Archive/                2025 brief, group-project material (FINAL/), duplicates, empty folders. Ignore for build.

## Author / submission
- Student: Nthabiseng Maoka (30224926), BEng Industrial, NWU Potchefstroom.
- Due 12 June 2026 08:00 (eFundi, PDF). Report body <= 40 pages.
- MFP submitted twice: source (Draw.io or Rayon) + PDF.
- Exit interview 17–18 June 2026; bring colour A2 (min) printed MFP. No alternatives/MFP = GA3 fail.

## Integrity rules (apply to ALL report text)
- Never name or mention the benchmark files / "benchmark reports".
- No AI / ChatGPT / Claude / prompt references in report text.
- This is DigMore (folding mini shovel), NOT TipTop Tables 2025. Do not import 2025 chair/table assumptions.
  The 2025 "daily dispatch" note does NOT apply; treat dispatch frequency as a designer assumption.
- UK English. No em dashes. Do not use the word "mechanism".
- Do not fabricate machine sizes, supplier specs or references. Label unknowns as
  "designer assumption", "to be verified", or "supplier-based estimate required".

## Demand & capacity basis (locked)
- 400 000 shovels/yr; 220 workdays/yr -> 1 818.18 -> use 1 819/day.
- Shift 9 h = 540 min; breaks 30+15+15 = 60 min -> 480 effective min/day.
- Takt = 480/1 819 = 0.264 min ≈ 15.84 s/shovel.
- 5% scrap on tube cutting and sheet stamping ONLY -> gross ≈ 1 819/0.95 ≈ 1 915/day at those two.
- Inventory: 2 wk raw material (≈10 days ≈ 18 190 units); 4 wk finished goods (≈20 days ≈ 36 380 units). All indoors.
- Reserve ≈10% space for expansion (5-yr growth).

## Product (3 aluminium parts) + materials
- Back handle (grip): 150 mm round tube, narrowed end + external thread, knurled grip.
- Middle handle: 150 mm round tube, internal thread, hinged to head via rivet.
- Shovel head + hinge connector: stamped sheet, bent, riveted; finished head 150 x 120 mm.
- Raw: round tube OD 31.70 mm wall 3.18 mm; sheet 2.5 mm (Aluminium Trading).
  Bought-in: rivets, bags, boxes, black powder-coat material.
- Open BOM items: rivet qty (1, maybe 2 — verify); packaging unit load (units/box, boxes/pallet — define).

## Brief Table 1 processing times (use EXACTLY)
- Cut handle 15 s/cut (pipes per cut depend on equipment)
- Internal thread (middle) 20 s/pipe; Stamp/form narrow end (grip) 5 s/pipe; Knurl + external thread (grip) 1 min/pipe [ONE op]
- Stamp hinge connector 2 s/part; Bend hinge connector 5 s/part
- Stamp shovel head 2 s/part; Shape/bend head 2 s/head; Sharpen blade 2 min/shovel; Serrate edge 1 min/shovel
- Rivet hinge to head 5 s/shovel
- Heat treat = equipment-dependent; Sandblast = equipment-dependent; Hand polish/deburr 1 min/head
- Powder-coat all parts (black) = equipment-dependent; Final assembly 30 s/shovel; Packaging = workstation-dependent

## Process flow (parallel streams converge at powder coating)
Receiving -> inspect -> RM store -> split:
  tube: cut -> [back: narrow -> knurl+thread -> WIP] + [middle: internal thread -> WIP]
  sheet: [head: stamp -> shape/bend -> sharpen -> serrate -> WIP] + [hinge: stamp -> bend -> WIP]
-> rivet head subassembly -> heat treat -> sandblast -> polish
-> ALL parts powder coat (separate ENCLOSED area) -> final assembly -> manual pack + final visual check
-> FG store -> small order collection (customer) / large order dispatch (own truck fleet).
Scrap exits at tube cutting and sheet stamping -> scrap/waste storage.

## Designer assumptions set so far (verify later)
- Small order <= 1 pallet (customer collects); large order > 1 pallet (own trucks). Exact units once box/pallet load fixed.
- WIP buffer ~1 shift at decoupling points (before heat treat/sandblast/powder coat; before assembly/packaging).
- MHE: forklifts/pallet trucks + trolleys/conveyors; main aisle ~3.0–3.7 m, pedestrian ~1.5 m.
- Parking: 1 bay/on-site employee + visitor/collection bays.
- Powder coat / heat treat / sandblast enclosed+extracted; sizes are supplier-based estimates required.

## Status & next steps
DONE: Sections 1–4 draft (05_Working/5.2_Report/); process flow diagram (05_Working/5.3_Process_Flow/).
NEXT:
  1. Excel capacity model (in 05_Working/5.1_Capacity_Model/): per-process cycle time -> units/day ->
     machines & operators (scrap-adjusted), identify bottlenecks, recommend machinery (cite sources; no invented dimensions).
  2. Storage sizing (3D): RM (tube/sheet) + FG pallets, racking, footprint; WIP staging.
  3. Receiving/dispatch/truck-fleet space; support facilities (offices per named roles, amenities,
     parking calc, security, waste, utilities).
  4. >=3 alternative block layouts + weighted evaluation -> justified choice.
  5. Final Master Facility Plan (draw.io) with 10% expansion; export source + PDF -> 06_Final_Submission/.
  6. Assemble full report <=40 pages; complete AI declaration.

## Recommended workflow
- Build the Excel capacity/space workbook FIRST (single source of truth) -> feed numbers into report and MFP.
- Mine 02_Module_Lessons/ (esp. SLP technique + tutorial, Flow/Activities/Space, Warehouse/Personnel) for method.
- Use web search to ground equipment throughput and pallet/rack/forklift/aisle/parking standards before fixing assumptions.
