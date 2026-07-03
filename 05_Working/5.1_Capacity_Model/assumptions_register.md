# DigMore Assumptions Register

Every figure used in the capacity model, workstation drawings, and MFP must trace to
one of the four status tags below. No item here is presented as fact unless tagged
LOCKED. UK English; no fabricated supplier specs (per `CLAUDE.md` integrity rules).

Status tags:
- **LOCKED** — fixed by the brief or by an earlier confirmed design decision; do not
  re-derive.
- **DESIGNER ASSUMPTION** — a reasonable choice made to allow the design to proceed;
  defensible in the exit interview, not sourced externally.
- **TO BE VERIFIED** — a figure taken from a general/secondary source that should be
  checked against the actual brief, textbook, or a named supplier before final
  submission.
- **SUPPLIER-BASED ESTIMATE REQUIRED** — no real supplier figure exists yet; a
  placeholder range is used and must be replaced before the MFP is finalised.

## Demand and capacity (LOCKED — from CLAUDE.md, do not re-derive)

| Item | Value | Status |
|---|---|---|
| Annual demand | 400,000 shovels/yr | LOCKED |
| Workdays/yr | 220 | LOCKED |
| Daily demand | 1,818.18 -> use 1,819/day | LOCKED |
| Shift length | 9 h (540 min) | LOCKED |
| Breaks | 30 + 15 + 15 = 60 min | LOCKED |
| Effective minutes/day | 480 | LOCKED |
| Takt time | 480/1,819 = 0.264 min ≈ 15.84 s/shovel | LOCKED |
| Scrap rate | 5% at tube cutting and sheet stamping ONLY | LOCKED |
| Gross throughput at those 2 stations | 1,819/0.95 ≈ 1,915/day | LOCKED |
| Raw material inventory | 2 weeks ≈ 10 days ≈ 18,190 units | LOCKED |
| Finished goods inventory | 4 weeks ≈ 20 days ≈ 36,380 units | LOCKED |
| Expansion reserve | 10% of footprint (5-yr growth) | LOCKED |

## Product / BOM open items (DESIGNER ASSUMPTION unless noted)

| Item | Current assumption | Status |
|---|---|---|
| Rivets per shovel (head-to-hinge) | 1 rivet assumed; brief says "1, maybe 2" | TO BE VERIFIED against brief Table 1 / lecturer |
| Raw tube purchase length | 6 m mill stock length (typical aluminium round-tube supply length) | DESIGNER ASSUMPTION |
| Packaging unit load | 1 shovel/bag; boxes/pallet not yet defined | DESIGNER ASSUMPTION — needs a number to size FG storage racking |
| Pallet footprint | 1200 x 1000 mm | DESIGNER ASSUMPTION — 1200x800mm EUR pallet is the alternative regional standard; pick one and hold it everywhere (aisle widths, racking bay depth, truck loading all depend on this) |

## Material handling / storage space (mixed status)

| Item | Current assumption | Status | Note |
|---|---|---|---|
| Main aisle (forklift) | 3.0-3.7 m | DESIGNER ASSUMPTION, consistent with published range | Counterbalance forklifts typically need 3.5-4.0 m; reach trucks 2.7-3.0 m; pick truck type first, then fix aisle width |
| Pedestrian aisle | 1.5 m | DESIGNER ASSUMPTION | — |
| Racking type | Selective pallet racking (assumed) | DESIGNER ASSUMPTION | Not yet compared against alternatives (drive-in, push-back) |
| Forklift type | Counterbalance (assumed) | DESIGNER ASSUMPTION | Drives the aisle width figure above — must be stated together |

## Enclosed / hazardous process areas (SUPPLIER-BASED ESTIMATE REQUIRED unless noted)

| Item | Current placeholder | Status |
|---|---|---|
| Powder-coat booth interior | ~1.2 m x 1.2 m x 2.4 m, plus ~1.2-1.5 m exhaust chamber depth (small-parts booth range) | SUPPLIER-BASED ESTIMATE REQUIRED — real footprint depends on jig/hanger reach and part batch size, not just single-part envelope |
| Heat treatment equipment | Not sized | SUPPLIER-BASED ESTIMATE REQUIRED |
| Sandblast booth | Not sized | SUPPLIER-BASED ESTIMATE REQUIRED |
| Tube-cutting machine footprint | Not sized | SUPPLIER-BASED ESTIMATE REQUIRED |
| Stamping presses (sheet + tube ops) | Not sized | SUPPLIER-BASED ESTIMATE REQUIRED |

## Support facilities (DESIGNER ASSUMPTION unless noted)

| Item | Current assumption | Status |
|---|---|---|
| Parking | 1 bay per on-site employee + visitor/collection bays | DESIGNER ASSUMPTION |
| Small vs. large order threshold | <= 1 pallet = customer collects; > 1 pallet = own trucks | DESIGNER ASSUMPTION — exact units depend on packaging unit load above |
| WIP buffer at decoupling points | ~1 shift, before heat treat/sandblast/powder coat and before assembly/packaging | DESIGNER ASSUMPTION |
| Dispatch frequency | Designer's own choice (2025 "daily dispatch" note does NOT apply to DigMore) | DESIGNER ASSUMPTION, per CLAUDE.md |

## How this file gets used

- The capacity workbook (`417.xlsx` / `DigMore_Capacity_Model.xlsx`) should read its
  inputs from the LOCKED table above — if a number changes there, it must change here
  first.
- Each workstation drawio file must cite the relevant row from this register in its
  figure caption / assumption note (see `5.4_MFP_and_Layouts/station_generation_plan.md`).
- Anything still marked TO BE VERIFIED or SUPPLIER-BASED ESTIMATE REQUIRED must be
  resolved, or explicitly left as a stated assumption in the report text, before final
  submission — it must never silently become a LOCKED-looking number in the report.
