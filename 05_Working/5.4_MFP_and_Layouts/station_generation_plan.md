# Workstation Drawio Generation Plan — DigMore

17 workstation/area layouts to produce, each as a `.drawio` file at **scale 1 m = 100 px**,
plus a short design paragraph, a dimensions table, a material handling table, and a
safety/ergonomics note for the report. Figures/PNG/PDF exports come after each drawio
file is checked.

## Drawio content standard (every station)

Each file includes, as separate labelled boxes/arrows:

1. Station name (title box).
2. Machine footprint (labelled with status tag from `assumptions_register.md`).
3. Operator standing/seated zone.
4. Input WIP marker.
5. Output WIP marker.
6. Tool rack / consumables, where relevant.
7. Scrap bin, where relevant (tube cutting, sheet stamping only, per locked scrap rule).
8. Safety clearance zone around moving/hot/hazardous equipment.
9. Forklift or trolley aisle segment (width per `assumptions_register.md`).
10. Material flow arrows (in/out direction).
11. Dimension labels in metres.
12. Figure caption text (station number, name, scale note).
13. Source/assumption note (which assumptions_register.md row it relies on).

## Station list and build order

| # | Station | Cycle time (brief Table 1) | Status this batch |
|---|---|---|---|
| 1 | Tube receiving & raw material storage | n/a (storage) | **Done** |
| 2 | Tube cutting station | 15 s/cut | **Done** |
| 3 | Internal threading (middle handle) | 20 s/pipe | **Done** |
| 4 | Grip narrowing stamp (back handle) | 5 s/pipe | **Done** |
| 5 | Knurling + external threading (back handle) | 1 min/pipe (one op) | **Done** |
| 6 | Hinge connector stamp + bend | 2 s + 5 s/part | **Done** |
| 7 | Shovel head stamp + shape/bend | 2 s + 2 s/part | **Done** |
| 8 | Sharpening + serrating | 2 min + 1 min/shovel | **Done — flagged as process bottleneck (12 parallel stations needed)** |
| 9 | Riveting (hinge to head) | 5 s/shovel | **Done** |
| 10 | Heat treatment | equipment-dependent | Pending |
| 11 | Sandblasting | equipment-dependent | Pending |
| 12 | Hand polishing / deburring | 1 min/head | Pending |
| 13 | Enclosed powder coating | equipment-dependent | **Done** |
| 14 | Final assembly | 30 s/shovel | Pending |
| 15 | Packaging + final inspection | workstation-dependent | Pending |
| 16 | Finished goods storage | n/a (storage) | Pending |
| 17 | Dispatch + customer collection | n/a | Pending |

## Capacity finding from this batch (stations 3-9)

At takt 15.84 s/shovel (LOCKED), parallel machine/operator counts by station:

| Station | Cycle time | Parallel units needed |
|---|---|---|
| 3. Internal threading | 20 s/pipe | 2 |
| 4. Grip narrowing | 5 s/pipe | 1 |
| 5. Knurl + ext. thread | 60 s/pipe | 4 |
| 6. Hinge stamp+bend | 7 s/part | 1 |
| 7. Head stamp+shape | 4 s/part | 1 |
| 8. Sharpen + serrate | 180 s/shovel | **12 (8 sharpen + 4 serrate) — bottleneck** |
| 9. Riveting | 5 s/shovel | 1 |

Station 8 needs roughly 6-12x the parallel capacity of any other station in this batch.
This must be surfaced in the report's capacity section, not buried in an appendix, and
will dominate the footprint/labour count for the head-finishing sub-area of the MFP.

Note: the brief's Table 1 lists 12 timed operations; stations 1, 10, 11, 16, 17 are
storage/equipment-dependent areas without a fixed cycle time and are sized from space
standards (racking, aisle, equipment envelope) rather than takt time.

## This batch (3 files)

- `drawio/01_receiving_raw_material_storage.drawio`
- `drawio/02_tube_cutting_station.drawio`
- `drawio/10_powder_coating_station.drawio` (numbered 10 to match the brief's process
  position — powder coat is the convergence point after polish, per `CLAUDE.md` process
  flow — not station #13 in file order; file names will be renumbered once all 17 exist)

## Next batch (proposed, on confirmation)

Stations 3-9 (the tube/sheet parallel-stream stations up to riveting) — these share
similar footprints (small stamping/threading equipment) and can be produced together
efficiently once the tube-cutting machine's footprint assumption is either confirmed or
formally logged as supplier-based-estimate-required.
