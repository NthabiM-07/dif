# Section 6: Detail Design Specifications — Main Report (Deep-Research Edition)

*Examiner-ready condensed body. Full workstation drawings, specification and cost tables in Appendix C; all sources in the Source Register. Benchmark used for structure/quality only — all content original to the 2026 DigMore brief.*

## 6.1 Demand and design basis

DigMore must produce 400 000 folding mini shovels per year over 220 working days on one 9-hour shift with 480 productive minutes per day. Daily demand is ⌈400 000/220⌉ = **1 819 shovels/day** (Eq. 6.1) and takt time is 480 min ÷ 1 819 = 0.264 min = **15.83 s/shovel** (Eq. 6.2). Availability of 1.0 is a design assumption (no setup/breakdown allowance); its sensitivity is tested in §6.4. The 5 % scrap allowance applies only at tube cutting and sheet stamping, so all operations at or upstream of those steps run at gross = good ÷ 0.95: **3 830 tube sections/day** (1 915 per handle type) and **1 915 each of heads and hinges**. Packaging converts output into unit loads of 1 819 bags, 182 boxes and 5 pallets per day; orders ≤ 400 shovels (one pallet) are customer-collected, larger orders ship on DigMore's fleet.

**Design insight.** The takt of 15.83 s, set against brief cycle times of up to 120 s, makes parallelisation — not machine speed — the facility's defining sizing mechanism, and concentrates floor area, WIP and supervision at four banks (knurling, sharpening, serrating, polishing). The product structure fixes the flow architecture before any layout is drawn: two parallel fabrication streams; the two sheet parts converge at riveting into the head subassembly; the streams converge only at final assembly, where three coated items (back handle, middle handle, head subassembly) meet.

## 6.2 Raw-material requirements and delivery logic

Aluminium round tube (Ø31.70 × 3.18 mm) arrives as 6 m stock — the standard South African mill length (Premium Aluminium, verified). With a practical saw-kerf allowance of 2.5 mm (cold-saw blade data; allowance, not a standard), a 6 m tube yields ⌊6 000/152.5⌋ = **39 sections**, giving ⌈3 829.5/39⌉ = **99 tubes/day** and **990 tubes** of two-week stock. Shovel heads and hinges are stamped from 2 500 × 1 250 × 2.5 mm sheet — a standard SA size (Euro Steel, verified) — at 75 % nesting: 20 + 4 = **24 sheets/day**, **240 sheets** two-week stock. Bought-out items: 18 190 bags and 36 380 rivets (2/shovel, assumption) per two weeks.

**Delivery unit-load logic (Table 6.4a).** Tubes are assumed delivered as strapped mill bundles on a flatbed [bundle size VERIFY with supplier — assumed ≈ 25 tubes/bundle ⇒ 4 bundles/day, 40 bundles per two-week cover, 10 bundles per cantilever rack]. Bundles are side-offloaded by counterbalance forklift with long-load fork spacing at a **ground-level bay** (6 m bundles do not suit a raised dock) directly onto cantilever racks — the offload face, storage face and saw-feed face are the same face, eliminating two handlings. Sheets arrive palletised over the shared dock; bags/rivets weekly by parcel/pallet.

## 6.3 Process chain and equipment selection (summary)

Seventeen processes are specified in Appendix C (Figures C.1–C.19), each with machine selection, WIP before/after, operator movement, ergonomics, safety, utilities and space calculation. Equipment is cited as **market examples for sizing only** — all selections require quotation. Key selections and reasoning:

| # | Process | Equipment class (verified market example) | Why it fits | Key risk/VERIFY |
|---|---|---|---|---|
| 1 | Tube cutting | Auto non-ferrous saw + 6 m bar feed (ProfiFeed A420) | 3 830 cuts/day; guarding; cut-to-length | Dims/bundle cutting at quote |
| 2 | Internal threading | Torque-limited tapping arm (Roscamat Tiger; to M30 Al) | Low-force, short cycle; tap protection | Thread spec |
| 3 | End narrowing | Ram tube end former (Hippo class) | Single-stroke swage matches 5 s | Model for Ø31.7 |
| 4 | Knurl + ext. thread | 2-die thread/profile roller (Profimach PTR 42; Ø6–42; 150 kN) | Chipless; stronger threads on thin wall | Achievable cycle |
| 5–6 | Head/hinge stamping | Gap-frame press (Stamtec OCP-35; 35 t; 70–180 SPM) | Small-part blanking from sheet | Die tonnage |
| 7 | Hinge bending | Small electric press brake (Euromac FX Bend class) | Fixed-die repeat bend | Dims/tonnage |
| 8 | Head shaping | Same press platform as 5–6 | Spares/training commonality | Forming tonnage |
| 9 | Sharpening | Belt grinder + extraction base (Fein GRIT GI75; 4 kW) | Manual bevel on curved edge; cool on Al | Combustible dust controls |
| 10 | Serrating | Grinder base case; notcher alternative (Euromac VA Multi 220/6R) | Bank homogeneity vs faster mechanical cut | Method trial |
| 11 | Riveting | Pneumatic radial riveter (AGME RA; two-hand control) | Low-force forming protects 2.5 mm joint | Rivet spec; 5 s covers 2 rivets |
| 12 | Heat treatment | Ageing batch oven (Wisconsin Oven class) | 6 h batch = 1 batch/shift decoupling | Alloy/route; chamber for 1 819 |
| 13 | Sandblasting | Enclosed booth + media recovery + collector (Airblast AFC) | Contains combustible Al dust | Cycle/booth count |
| 14 | Polishing | Manual benches + extraction | Judgement-based edge work | Consumables |
| 15 | Powder coating | Conveyorised line ×2 (P.I. Marketing, SA turnkey) | 5 457 items/day; 1 line needs 9.1 h > shift | 600 parts/h rate; fire/vent design |
| 16–17 | Assembly/packaging | Manual benches (fabricated) | Hand-fit + brief's visual check | Packaging cycle (30 s assumed) |

**Capacity result (Table 6.25 summary).** 34 line machines / 34 operators, average utilisation 62.5 %; bottleneck by workload is **sharpening** (3 638 machine-min/day, 8 stations @ 94.7 %); least headroom at **cutting and knurling (99.7 %)**. At 90 % availability the requirement rises to 41 machines (+7) — reserved as positioned expansion ground, not base plan. Equipment-dependent: 1 ageing oven, blast installation, **2 powder lines** (⌈5 457/(600×8)⌉, Eq. 6.10) in a fully enclosed 120 m² area.

## 6.4 Material-handling system design

The system is built on one rule derived from §6.3: **stations above 90 % utilisation are never self-served** — at 94.7 % a station holds 25 min/shift of slack, and self-fetching 5 min/hour destroys ≈ 8 % of capacity. Five material handlers therefore run an **hourly fixed-route milk-run** (Figure C.20) with two-bin kanban at every station; the press cell (13–33 %) self-serves. Movement schedule:

| Movement | From → To | Load | Equipment | Frequency | Aisle | Safety note |
|---|---|---|---|---|---|---|
| Tube offload | Flatbed → cantilever racks | Bundles (≈25 tubes) | Forklift, long-load forks | 2–3/wk | 3.5 m straight apron face | Long-load swing; no pedestrians at face |
| Tube to saw | Rack face → bar magazine | Single tubes | Operator slide (same face) | Continuous | Shared 3.5 m lane | Rack face = feed face (zero transfer) |
| Sheet to presses | Dock → stacks → press infeed | Pallet / single sheet (~21 kg) | Forklift; 2-person/assist at press | 2–3/wk; hourly | 3.5 m / 2.0 m | Manual-lift limit; assist at detailed design |
| Cut sections out | Saw outfeed → thread/narrow | Tube carts (3-tier, end stops) | Milk-run | Hourly | 2.0 m | Cart capacity table, App. C |
| Feed knurl bank | Narrowing → buffer strip | Carts → kanban bins | Milk-run | Hourly | 2.0 m | 99.7 % station — buffer mandatory |
| Feed sharpening | Head forming → central WIP lane | Bins | Milk-run | Hourly | 2.0 m lane | Bottleneck — never starve |
| Scrap removal | Saw + presses → waste store | Scrap bins | Milk-run (return leg) | Per loop | 2.0 m | Segregated from dust drums |
| Subassy to oven | Rivet → day buffer IN | Trolleys → oven racks | Handler + pallet truck | Continuous | 2.0 m | Batch staging discipline |
| Oven → blast → polish | Racks/trolleys | Racked subassemblies | Handler | Per batch | 2.0 m | Hot-parts cooling first |
| Into/out of coating | Polish + knurl → hang station; unload → assembly | Trolleys; overhead conveyor inside | Milk-run to wall openings | Hourly | 2.0 m | Enclosure openings only; clean route out |
| Packaging → FG | Pallet build → racking | Pallets (5/day) | Powered pallet truck | ~Hourly | 2.4 m min | FIFO putaway end |
| FG picking | Racking → outbound/collection | Pallets / boxes | Forklift / hand pallet truck | Daily | 3.5 m | Pick face at collection end |
| Dispatch | Outbound staging → fleet | 5 pallets/day | Forklift | Daily p.m. | Dock apron | Time-shared dock (a.m. receive) |
| Customer collection | FG pick face → counter | Boxes/pallet | Hand pallet truck | Ad hoc | Pedestrian route | Customers never in yard/factory |

Fleet: 1 electric counterbalance forklift (~2.5 t — shared site-wide; viable at 3–5 truck movements/day), 1 powered pallet truck, 2 hand pallet trucks (R4 695 ea., verified), milk-run tugger/trolleys and 4 fabricated tube carts. Aisles: 3.5 m forklift, 2.0 m trolley, separated pedestrian walkways; the rack aisle is straight-through because a 6 m load cannot swing at the face (benchmark-consistent aisle-fits-load logic).

## 6.5 Receiving, dispatch and warehouse logic

A **U-flow** dock zone serves the small flows: one time-shared leveller dock (receive mornings ≈ 2–3/wk; dispatch afternoons ≈ 30 min for 5 pallets) plus one ground-level bay for tube bundles and skip exchange, within the 250 m² allowance; a knock-out panel reserves a second dock. The five warehouse functions connect through one forklift spine (Fig. C.19): load/unload → receiving staging → storage (raw beside receiving and production; FG fed directly by packaging) → packing → shipping staging. Finished goods run **FIFO through 3-level selective racking** (91 pallets/31 positions — selective chosen over denser drive-in because single-SKU 4-week cover must turn FIFO and drive-in is LIFO). Customer collection is a pedestrian-only counter on the visitor side; trucks, forklifts and production are never exposed to customers. Floor markings and labels: milk-run lane, forklift spine, staging boxes, FIFO arrows, quarantine square at packaging.

## 6.6 Support, utilities and safety zones

Headcount 60 (43 production-related). Offices 260 m² (aggregate allowance; supervisors in glazed floor cubicles overlooking the two bottleneck zones); amenities 240 m² with single-sitting cafeteria, PPE-boundary change rooms and first-aid at the finishing/coating boundary; parking 70 bays (1 750 m²) + 6 truck **parking** bays (360 m²). Utilities cluster on one **services wall**: electrical (oven + cure ovens dominant), compressed air (blast major consumer; ring main on milk-run spine), water/plumbing, and **three never-interconnected extraction systems** — combustible aluminium dust (finishing), powder enclosure (negative pressure + make-up air), oven heat relief — with two distinct fire regimes (combustible metal dust vs organic powder) to be confirmed with a fire engineer. Ergonomics are specified per workstation in Appendix C (reach, stand/sit, ~21 kg sheet handling assist, WIP at waist height, lighting grades, noise zoning, guarding/two-hand controls, PPE).

## 6.7 Space summary (corrected basis — unchanged)

Three reconciled corrections (+24 m² saw strips, +6 m² packaging cell, +19.2 m² oven day-buffers = **+49.2 m²**) are added to the functional area and deliberately not charged to the expansion allowance. Result: functional 1 355 m² → +30 % circulation → +10 % positioned expansion → **building ≈ 1 940 m²**; with 2 110 m² vehicle areas, **site ≈ 4 050 m²** (indicative; erf VERIFY). Expansion is positioned at the 94.7 %+ banks (+7-machine case ≈ 42 m²), dock knock-out, FG racking headroom and press-cell shell — never inside the powder enclosure or extraction footprints.

## 6.8 Link to the Master Facility Plan

The layout alternatives are different geometric answers to the constraints fixed here: split-and-merge flow, two bottleneck anchor zones, oven buffer floor, services wall, three extraction regimes, U-flow dock, two-faced building, milk-run spine. Score them on: demand attainment at takt; flow distance and **milk-run circuit length** (Fig. C.20 — a measurable criterion); hazard separation; storage/handling efficiency; site safety; expansion positioning; implementability. The MFP fixes the preferred answer at ≈ 1 940 m² / ≈ 4 050 m².

*Detail: Appendix C (Figures C.1–C.20; Tables C.1–C.21). Sources: Source Register. Insert: Main_Report_Insert.md.*
