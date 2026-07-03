# Appendix C: Workstation Layouts and Costed Equipment Schedule (v3 — Deep-Research Edition)

Drawings: `Appendix_C_SVGs/C00–C19` (SVG + editable .drawio, generated previously and held in `05_Working/5.2_Report/Appendix_C_SVGs/`) plus **new Figure C.20 milk-run route** (this package). All drawings are original (author's own); machine proportions adapted from verified supplier pages are credited per caption and redrawn, never copied. Colour code (Fig. C.0): machine light green · raw light red · load/unload orange · WIP light yellow · operator/aisles grey · safety light blue · waste brown · flow black · coating conveyor orange dashed. Every drawing carries overall L × W, zone dimensions, area, scale note, legend and caption. Export: A4 landscape, ≥ 300 dpi or vector.

**Cost discipline.** Levels used throughout: Direct price · Converted price (R22.11/GBP, exchangerates.org.uk, 10 Jun 2026; excl. shipping/duties/installation/SA VAT treatment) · Published price range · Comparable estimate · **Quotation required** (no figure stated) · Design assumption. No invented values.

---

## C.0 Delivery unit loads and internal transport capacity (new — benchmark-pattern tables)

**Table C.0a: Raw-material delivery unit loads**

| Item | Unit load | Loads/day | 2-wk cover | Offload | Basis |
|---|---|---|---|---|---|
| Al tube 6 m, Ø31.70×3.18 | Strapped mill bundle ≈ 25 tubes [VERIFY supplier strapping] | ≈ 4 bundles | 40 bundles (990 tubes; 10/rack) | Forklift side-offload, ground bay | Design assumption on verified 99 tubes/day |
| Al sheet 2 500×1 250×2.5 | Pallet ≈ 60 sheets [VERIFY] | 0.4 (24 sheets) | 4 pallets (240) | Dock, forklift | Assumption on verified 24 sheets/day |
| Bags / rivets | Carton/pallet | weekly | 18 190 / 36 380 | Dock, pallet truck | Table 6.7 |

**Table C.0b: Internal transport capacity**

| Equipment | Capacity | Daily loads implied | Basis |
|---|---|---|---|
| Tube cart (fabricated, 3-tier, end stops, ≈1.3×0.8 m) | ≈ 400 × 150 mm sections | 3 830 sections ⇒ ≈ 10 cart-trips | Design assumption [VERIFY fabrication] |
| Kanban bin (two-bin) | sized per station hour-demand | 1 milk-run loop/h | §6.6.5 rule |
| Powered pallet truck | 1 pallet | 5 pallets/day FG + staging | Verified flow |
| Forklift (~2.5 t, long-load forks) | 1 bundle / 1 pallet | 4 bundle + ≤ 1 pallet moves/day inbound | Verified flows |

---

## C.1–C.19 Workstation packages

Each entry: purpose · WIP before/after · operator movement · ergonomics & safety · utilities · space · figure. Full 13-row cost/spec tables follow the set (Tables C.1–C.19); geometry is on the drawings.

### C.1 Tube cutting — Fig. `C01` (9.0 × 2.0 m/saw = 18 m², ×2 mirrored)
Purpose: 6 m tubes → 150 mm sections (gross 3 830/day, 5 % scrap). WIP-before = rack face (990 tubes); WIP-after = section bins 1.7 m²; scrap bin on waste route. Operator movement 7.9×0.9 m = 7.1 m². **Ergonomics/safety:** operator loads from rack at waist height along the same face; blade fully guarded with magazine interlock; noise PPE; no pedestrian crossing of the bar magazine. Utilities: 400 V, extraction-ready. Layout: anchors tube line on apron perimeter.

### C.2 Internal threading — Fig. `C02` (3.0 × 2.0 m = 6 m², ×2)
Middle handles tapped (20 s). WIP bins 0.7 m² each side at bench height. Ergonomics: seated/standing bench, fixture eliminates wrist torque (torque-limited head); swarf bin; task light. Utilities: 220 V.

### C.3 End narrowing — Fig. `C03` (6 m², ×1)
Back-handle swage (5 s). Single-stroke ram; two-position loading keeps hands clear; 33 % utilisation = flex station. Feeds C.4 one-piece.

### C.4 Knurling/external threading bank — Fig. `C04` (8.4 × 3.4 m = 28.6 m², 4 machines)
99.7 % utilisation ⇒ mandatory full-length infeed buffer (WIP-before 4.6 m²; WIP-after same strip outbound right). Ergonomics: load between dies at elbow height; coolant mist control; maintenance clearance each machine (bank cannot afford downtime). Utilities: 400 V, coolant.

### C.5 Press cell (head + hinge stamping) — Fig. `C05` (6.4 × 4.0 m = 25.6 m²)
WIP-before = sheet stacks (storage-counted); WIP-after = blank bins; skeleton scrap bin. **Ergonomics:** ≈ 21 kg sheets — two-person lift or assist [VERIFY]; infeed support table; guards/light curtains; die-change access. 13.3 % each ⇒ consolidation option (1 press + QDC) preserved.

### C.6 Hinge bending — Fig. `C06` (8.5 m² drawn) · C.7 Head shaping — Fig. `C07` (6 m²)
Light-curtain at brake pinch point; same press platform as C.5 for commonality; C.7 output buffer sized to keep sharpening fed.

### C.8 Sharpening bank — Fig. `C08` (8.4 × 6.2 m = 52.1 m², 8 grinders) — **BOTTLENECK**
Central milk-run WIP lane 8.8 m²; operator rows 0.8 m. **Safety:** combustible Al dust — rear extraction trunks to dedicated collector (NFPA 484-type practice; local equivalent VERIFY); dominant noise zone (zoned away from assembly/offices; hearing PPE); eye protection; belt-change lockout. Ergonomics: workpiece presented at chest height to belt; anti-fatigue mats; task lighting.

### C.9 Serrating row — Fig. `C09` (26.9 m², 4) · C.13 Polishing row — Fig. `C13` (26.0 m², 4)
In-line with sharpening lane (no trolley transfer in); same dust/noise regime; polishing adds inspection-grade lighting (de facto pre-coat check). Serration alternative (hydraulic notcher) carried to quotation trial.

### C.10 Riveting — Fig. `C10` (9.6 m²) — sheet convergence
Two matched inbound buffers + rivet point-of-use shelf (min/max marked); two-hand control; compressed-air drop; task light for alignment check; hinge must pivot after forming.

### C.11 Heat treatment + day buffers — Fig. `C11` (50.8 m² of 80 m² zone)
1 batch/shift; WIP-before/after ≈ 5 pallets each side (the +19.2 m² correction). Safety: thermal clearance, hot-rack handling gloves/tongs, services-wall heat relief; single-point-of-failure flagged for MFP risk. Utilities: dominant electrical/gas load.

### C.12 Sandblasting — Fig. `C12` (32.0 m²)
Enclosed booth + media-recovery floor + collector on services wall; sealed dust/media drums; entry control + PPE; major compressed-air consumer (sizes compressor plant).

### C.14 Powder coating (enclosed) — Fig. `C14` (15.0 × 8.0 m = **120 m², matches allowance**)
Conveyor loop (orange dashed): hang/load → booth + recovery → cure oven → cooling leg → unload; negative pressure, filtered extraction + make-up air; personnel airlock; trolley wall-openings only; organic-powder fire regime separate from Al-dust regime [fire engineer VERIFY]. WIP-before/after = hang/unload staging 3.6 m² each. **Coated-surface protection:** parts stay on hooks/trolleys with non-marking contacts until assembly.

### C.15 Final assembly — Fig. `C15` (13.6 m², 2 benches) — streams converge
Three-part staging strip in reach envelope; min/max marking; torque-comfortable threaded-joint work at elbow height; clean, quiet zone.

### C.16 Packaging + final visual check — Fig. `C16` (19.8 m² drawn; 18 m² corrected cell)
Consumable shelving behind operator; inspection-grade lighting; **quarantine/reject bin** (auditable quality gate); pallet-build positions (no lift above shoulder; hand pallet truck take-off). 30 s cycle is a workbook assumption [VERIFY].

### C.17 FG racking + dispatch — Fig. `C17` (zone 119 m²; racking 59.5 m²)
FIFO putaway→pick; 3.5 m forklift aisle; collection counter pedestrian-only. C.18 RM storage — Fig. `C18` (zone 109 m²; stores 48.4 m²): offload = storage = feed face. C.19 Dock interface — Fig. `C19` (174 m² of 250 m²): five-areas U-flow, skip exchange, customer separation.

### C.20 Milk-run route — Fig. `C20_milkrun_route` (new)
Hourly loop, stops 1–12 (RM → saws → thread/narrow → knurl → press cell → finishing → polish/rivet → oven staging → coat hang/unload → assembly → packaging → FG putaway), 2.0 m trolley lane with 3.5 m forklift sections; route length is the layout-alternative scoring metric.

---

## Tables C.1–C.19: Costed specifications (13-row format)

*(Values identical to the verified v2 schedule; full per-station tables as previously issued — reproduced headline rows here; the only costed items remain:)*

| Item | Qty | Unit | Total | Cost basis | Confidence | Verification |
|---|---|---:|---:|---|---|---|
| Belt grinder w/ extraction (C.8 + C.9) | 12 | ≈ R72 800 (£3 293 @ R22.11) | ≈ **R873 600** | Converted price | Medium | Config at quote; excl. shipping/duties |
| Selective pallet racking (93 positions) | 1 system | R1 500–4 000/pos. | **R139 500–372 000** (mid ≈ R256 000) | Published price range (Krost) | Medium | Bay ratings |
| Hand pallet truck 2 t | 2 | R4 695 | **R9 390** | Direct price (Adendorff) | High | — |
| Saw; tapper; end former; roller ×4; presses ×3 (+dies); brake; riveter; oven; blast; powder lines ×2; cantilever racks; forklift; PPT; dock package; fabricated benches/carts/bins | — | Quotation required | Quotation required | Quotation required / fabrication quote | Low | All at supplier quotation |

**Table C.21: Capital cost audit (consolidated)** — categories Machine / Installation / Fabricated / Storage / MH / Dock as previously issued; **priced subset ≈ R1.14 m (midpoint)** — budgeting structure only; quotation items (powder lines, oven, saws, presses, rollers) will dominate.

---

## Drawing & copyright notes
All figures original; "adapted from" credits: ProfiFeed (C.1), Profimach (C.4), Stamtec (C.5), EC Hopkins/Fein (C.8), P.I. Marketing (C.14), Krost (C.17/C.18), Maxiflex (C.19). Supplier images/catalogues: reference or dimension-data only — never reproduced. Dimensions.com symbols (Pro): use as reference blocks subject to licence terms; redraw simplified.

## Source list
See `Source_Register_DigMore_Section6.md` (19 verified suppliers + 3 tool-doc sources + cost sources, all with access dates).
