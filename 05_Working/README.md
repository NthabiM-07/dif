# DigMore Folding Mini Shovel — Facility Design (INGB417 GA3, 2026)

Project map and status for the facility design workflow. This README maps onto the
existing project structure defined in `CLAUDE.md` (project root) — no parallel folder
tree has been created, to avoid duplicating the work already in `05_Working/`.

## Where things live (mapped to the existing structure)

```
INGB 417 EXAM ASSIGNMENT/
├── 01_Assignment_Brief/        <- controlling brief (only source for requirements)
├── 02_Module_Lessons/          <- SLP technique, Flow/Activities/Space, etc. (method source)
├── 03_Reference_Textbooks/     <- Tompkins; Stephens & Meyers (design method, theory)
├── 04_Benchmarks_style_only/   <- structure/style reference ONLY - never cited in report text
├── 05_Working/
│   ├── 5.1_Capacity_Model/
│   │     ├── 417.xlsx, DigMore_Capacity_Model.xlsx, ...   <- capacity workbook(s)
│   │     └── assumptions_register.md                       <- NEW (this batch)
│   ├── 5.2_Report/              <- report drafts, Sections 1-4 (+5 in progress)
│   ├── 5.3_Process_Flow/        <- DigMore_Process_Flow.drawio/.png
│   └── 5.4_MFP_and_Layouts/
│         ├── Alternatives.drawio.pdf
│         ├── station_generation_plan.md                    <- NEW (this batch)
│         └── drawio/                                       <- NEW subfolder (this batch)
│               ├── 01_receiving_raw_material_storage.drawio
│               ├── 02_tube_cutting_station.drawio
│               └── 10_powder_coating_station.drawio
└── 06_Final_Submission/        <- empty; final PDF + MFP (source + PDF) go here at the end
```

## Status

- Sections 1-4 of the report: drafted (`05_Working/5.2_Report/`).
- Process flow diagram: drafted (`05_Working/5.3_Process_Flow/`).
- Capacity/demand basis: locked in `CLAUDE.md` (400,000 units/yr, 220 workdays, takt
  15.84 s/shovel, 5% scrap at tube cutting and sheet stamping only).
- Workstation-level drawio layouts: **starting now** — 3 of 17 stations drafted this
  batch (receiving/RM storage, tube cutting, powder coating). Remaining 14 to follow
  in later batches.
- MFP: multiple draft versions exist across the folder tree (see note below) — not yet
  reconciled into one final version.
- GitHub: no GitHub connector/tool is available in this session, so no repo, branch,
  or commit has been created. See note below.

## Note on existing duplicate MFP files

The folder currently contains several MFP-related files spread across
`05_Working/5.4_MFP_and_Layouts/`, a `files additional info 3 july/` dump (with its own
nested `05_Working` copies), and a `rayon/` folder with Rayon.design CAD exports
(including `DigMoreMasterFacilityPlan_....dxf`). These have not been merged. Recommend
picking one MFP lineage (Rayon export vs. drawio) before the final submission push —
flagged separately, not resolved in this batch.

## Note on GitHub

No GitHub MCP tool is present in this session's tool list, regardless of what a
connector might report elsewhere. Version control of this project, if wanted, should
happen locally (`git` is already initialised at the project root) or via a GitHub
connector authorised through Settings, with you pushing/confirming each commit — no
push has been made and none will be, without that connector being available and you
explicitly confirming.

## Method sources (per brief priority order)

1. `01_Assignment_Brief/INGB417 FacilityDesign GA3 assignment_1st Opp_June2026_Rev1.pdf`
   — the only controlling document.
2. Benchmark reports in `04_Benchmarks_style_only/` — structure/style reference only,
   never named or cited in report text (integrity rule, see `CLAUDE.md`).
3. `03_Reference_Textbooks/` — Tompkins; Stephens & Meyers, for design method, space
   standards, and material handling logic.
4. Verified web sources for machine/equipment/storage dimensions not given in the
   brief — cited with each figure flagged as "designer assumption", "to be verified",
   or "supplier-based estimate required" per the integrity rule in `CLAUDE.md`. No
   fabricated machine specs.
