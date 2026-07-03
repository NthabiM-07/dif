# 6. Detail Design Specifications

This chapter converts the DigMore Co. demand and product specification into the quantitative parameters that govern the new facility: production rates, raw-material quantities, machine and operator requirements, packaging and dispatch loads, storage volumes, waste handling, utilities and floor-space estimates, including the 10 % future expansion allowance. Each parameter is derived from the 2026 assignment brief or calculated in the supporting workbook, and each subsection closes with its implications for material flow and layout, so that the chapter directly supports the layout alternatives and the final Master Facility Plan.

[Insert Figure 6.1 here: Folding mini shovel component breakdown, showing the back handle section, middle handle section, shovel head and hinge connector, with material callouts (Ø31.70 × 3.18 mm aluminium tube; 2.5 mm aluminium sheet). Redraw in diagrams.net or PowerPoint from the product description in the brief.]

## 6.1 Demand and Production Requirements

The facility must produce 400 000 folding mini shovels per year over 220 working days, on a single 9-hour shift containing one 30-minute lunch break and two 15-minute tea breaks, leaving 480 productive minutes per day. These parameters fix the required rate of every downstream process and are therefore established before any equipment or space calculation. The daily requirement is calculated in Equation 6.1 and rounded up, since rounding down would accumulate an annual shortfall against demand.

**Equation 6.1: Daily demand**

$$
\text{Daily demand} = \left\lceil \frac{\text{Annual demand}}{\text{Working days}} \right\rceil = \left\lceil \frac{400\,000\ \text{shovels/yr}}{220\ \text{days/yr}} \right\rceil = \lceil 1\,818.2 \rceil = 1\,819\ \text{shovels/day}
$$

Dividing the daily requirement across the 8 productive hours gives an hourly rate of 1 819 ÷ 8 = 227.4 ≈ 228 shovels per hour. The takt time — the interval at which one completed shovel must leave the line for demand to be met — follows in Equation 6.2, with the unit conversion shown explicitly.

**Equation 6.2: Takt time**

$$
\text{Takt time} = \frac{\text{Effective time per day}}{\text{Daily demand}} = \frac{480\ \text{min/day}}{1\,819\ \text{shovels/day}} = 0.264\ \text{min/shovel} = 15.83\ \text{s/shovel}
$$

All equipment in this chapter is sized on the full 480 effective minutes per day, i.e. an assumed availability of 1.0. This is a design assumption, not a brief requirement: it makes no allowance for setup, changeover or breakdown time. The sensitivity of machine counts to a lower availability is assessed in §6.4, and the brief designates overtime — not additional base capacity — as the flexibility mechanism. Table 6.1 consolidates the production parameters.

**Table 6.1: Demand and production parameters**

| Parameter | Value | Unit | Basis / Source |
|---|---|---|---|
| Annual demand | 400 000 | shovels/yr | 2026 brief |
| Working days | 220 | days/yr | 2026 brief |
| Shift length | 540 | min/day | 9 h shift (brief) |
| Breaks | 60 | min/day | 30 + 15 + 15 min (brief) |
| Effective production time | 480 | min/day | Shift − breaks |
| Availability | 1.0 | — | Assumption: no setup/breakdown allowance (sensitivity in §6.4) |
| Daily demand (good units) | 1 819 | shovels/day | Equation 6.1, rounded up |
| Hourly demand | ≈ 228 | shovels/h | Daily demand ÷ 8 h |
| Takt time | 15.83 | s/shovel | Equation 6.2 |
| Scrap allowance | 5 | % | Tube cutting and sheet stamping only (brief) |
| Process yield (scrap steps) | 95 | % | 1 − scrap rate |

### Part-level production requirement

Each shovel comprises two tube components (back and middle handle sections) and two sheet components (shovel head and hinge connector). Because the 5 % scrap allowance applies only to tube cutting and sheet stamping, those operations must run at a gross rate of good demand ÷ 0.95, i.e. 5.26 % above the good-unit rate. Table 6.2 states the requirement per component, with the gross tube demand split between the two handle sections and totalled.

**Table 6.2: Part-level daily production requirement**

| Part | Qty per shovel | Good units/day | Gross units/day | Basis / Source |
|---|---|---|---|---|
| Back handle section (tube) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (cutting scrap) |
| Middle handle section (tube) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (cutting scrap) |
| **Total tube sections** | **2** | **3 638** | **3 830** | Sum of handle sections |
| Shovel head (sheet) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (stamping scrap) |
| Hinge connector (sheet) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (stamping scrap) |

*Gross values rounded up from 1 914.7 per part and 3 829.5 in total; the workbook carries unrounded values through subsequent calculations to avoid compounding rounding error.*

### Packaging and unit-load demand

Packaging is manual and doubles as the final visual inspection, so its demand is stated here because it sizes both the packaging workstations (§6.3.17) and the dispatch unit loads (§6.5). Each shovel is packed into a bought-out bag; bagged shovels are boxed and palletised on the workbook's unit-load definitions.

**Table 6.3: Packaging and unit-load demand**

| Measure | Value | Unit | Basis / Source |
|---|---|---|---|
| Packaging bags | 1 819 | bags/day | 1 per shovel (brief: bought-out) |
| Boxes (10 shovels/box) | 182 | boxes/day | ⌈1 819 ÷ 10⌉; box size is an assumption |
| Pallets (40 boxes/pallet, 400 shovels) | 5 | pallets/day | ⌈182 ÷ 40⌉; pallet load is an assumption |
| Small order threshold | ≤ 400 | shovels (≤ 1 pallet) | Workbook order definition |
| Large order threshold | > 400 | shovels (> 1 pallet) | Workbook order definition |

### Key Findings and Layout Implications

The takt time of 15.83 s/shovel is the most consequential parameter in this chapter. Several brief-specified cycle times exceed it severalfold — blade sharpening at 120 s, knurling and external threading at 60 s, serrating at 60 s and hand polishing at 60 s — so these operations cannot meet demand on single machines and must be parallelised (sharpening alone requires 8 stations, derived in §6.4). The layout must therefore provide banks of identical workstations at these operations, making them the dominant drivers of production floor area and of WIP staging between unbalanced stages. Second, because scrap arises only at tube cutting and sheet stamping, those two workstations require scrap bins and a dedicated removal route to the waste store, and they draw raw material at 5.26 % above the good-unit rate — the input to the raw-material and storage sizing in §6.2 and §6.6. Third, the part structure defines the facility's flow architecture: the tube stream (cutting, threading, narrowing, knurling) and the sheet stream (stamping, bending, shaping, sharpening, serrating) run in parallel; the two sheet parts converge at riveting to form the head subassembly, which then passes through heat treatment, sandblasting, polishing and powder coating; the tube and sheet streams converge only at final assembly, where the two powder-coated handle sections are united with the coated head subassembly. The layout alternatives must preserve this split-and-merge flow from raw-material storage to assembly (Figure 6.3, §6.3). Finally, the single-shift, availability-1.0 assumption means any unplanned downtime converts directly into overtime, which argues for maintenance access at the high-utilisation stations identified in §6.4.

[Insert Figure 6.2 here: High-level material flow from receiving to dispatch — receiving → raw-material stores → parallel tube and sheet streams → riveting (sheet parts only, forming the head subassembly) → heat treatment → sandblasting → polishing → enclosed powder coating (handles and head subassembly) → final assembly (streams converge) → packaging and final visual check → finished-goods storage → small-order collection / large-order dispatch. Redraw in diagrams.net.]

## 6.2 Raw Material Requirements

The product consumes two manufactured raw-material streams — aluminium round tube (Ø31.70 mm outside diameter, 3.18 mm wall) for the handle sections, and 2.5 mm aluminium sheet for the shovel head and hinge connector — plus bought-out packaging bags and rivets. The brief requires two weeks of raw material to be held indoors, equal to 10 working days of cover on the 220-day calendar. This subsection converts the gross daily part requirements of Table 6.2 into purchasable raw-material units — full-length tubes and standard sheets — because storage racking, receiving loads and material-handling equipment are sized in those units, not in finished parts. Table 6.4 records the conversion basis; market research confirming the stock-unit assumptions is noted beneath each table.

**Table 6.4: Product components and raw-material basis**

| Component | Raw material | Blank / section size | Purchasing unit | Basis / Source |
|---|---|---|---|---|
| Back handle section | Al round tube Ø31.70 × 3.18 mm | 150 mm section | 6 m stock tube | Brief; 6 m is the standard SA mill length¹ [VERIFY supplier] |
| Middle handle section | Al round tube Ø31.70 × 3.18 mm | 150 mm section | 6 m stock tube | Brief; as above |
| Shovel head | Al sheet, 2.5 mm | 0.17 × 0.14 m blank (forming allowance) | 2 500 × 1 250 mm sheet | Brief (finished 150 × 120 mm); standard SA sheet size² |
| Hinge connector | Al sheet, 2.5 mm | 0.08 × 0.05 m blank | 2 500 × 1 250 mm sheet | Blank size assumption [VERIFY against die design] |
| Packaging bag | Bought-out | — | Per shovel | Brief (outside supplier) |
| Rivets | Bought-out | — | 2 per shovel (assumed) | Brief (riveted hinge joint); count [VERIFY with product engineering] |

¹ 6 m is the standard mill length for aluminium round tube in South Africa ([Premium Aluminium](https://www.premiumaluminium.co.za/aluminium-round-tube/), accessed 10 June 2026). This source supports the stock length only; availability of the specific Ø31.70 × 3.18 mm section must be confirmed with the supplier [VERIFY].
² 2 500 × 1 250 mm is a standard South African aluminium sheet size, stocked in thicknesses up to 2.5 mm ([Euro Steel](https://www.eurosteel.co.za/aluminium-sheets/), accessed 10 June 2026).

### Aluminium tube requirement

Each shovel requires two 150 mm handle sections, and tube cutting carries the 5 % scrap allowance, so the saw must produce the gross section rate derived in Equation 6.3. The yield per 6 m stock tube must account for saw kerf. A practical kerf allowance of 2.5 mm is adopted here, informed by blade data published by a cold-saw blade supplier (chip-breaker tooth forms at 2.2 mm kerf; common blade plate thicknesses of 2.5 mm) ([Cold Saw Blade Store](https://coldsawbladestore.com/cold-saw-blade-guide/), accessed 10 June 2026). This is an allowance, not a universal standard; the actual kerf must be confirmed against the blade specified for the selected saw [VERIFY]. Each cut then consumes approximately 152.5 mm of stock, giving 39 sections per tube rather than the 40 obtained when kerf is ignored (Equation 6.4).

**Equation 6.3: Daily gross tube-section requirement**

$$
\text{Gross sections/day} = \frac{\text{Good sections/day}}{1 - \text{scrap rate}} = \frac{2 \times 1\,819}{0.95} = \frac{3\,638}{0.95} = 3\,829.5 \approx 3\,830\ \text{tube sections/day}
$$

**Equation 6.4: Sections per stock tube (kerf included)**

$$
\text{Sections/tube} = \left\lfloor \frac{\text{Stock length}}{\text{Section length} + \text{kerf}} \right\rfloor = \left\lfloor \frac{6\,000\ \text{mm}}{150\ \text{mm} + 2.5\ \text{mm}} \right\rfloor = \lfloor 39.3 \rfloor = 39\ \text{sections/tube}
$$

**Equation 6.5: Daily 6 m tube requirement**

$$
\text{Tubes/day} = \left\lceil \frac{\text{Gross sections/day}}{\text{Sections per tube}} \right\rceil = \left\lceil \frac{3\,829.5}{39} \right\rceil = \lceil 98.2 \rceil = 99\ \text{tubes/day}
$$

**Table 6.5: Aluminium tube requirement**

| Measure | Value | Unit | Basis / Source |
|---|---|---|---|
| Tube sections per shovel | 2 | sections | Product structure (brief) |
| Good tube sections per day | 3 638 | sections/day | 2 × 1 819 |
| Gross tube sections per day | 3 830 | sections/day | Equation 6.3 (5 % cutting scrap) |
| Sections per 6 m tube | 39 | sections | Equation 6.4 (2.5 mm kerf) [VERIFY blade specification] |
| Tubes per day | 99 | tubes/day | Equation 6.5 |
| Tubes for 2-week cover | 990 | tubes | 99 × 10 working days |

*The workbook's current basis ignores kerf (40 sections/tube; 96 tubes/day; 960 tubes stored). The kerf-inclusive figures above are adopted as the design values; the difference (+30 tubes of stock) remains within the four cantilever racks sized in §6.6.*

### Aluminium sheet requirement

Shovel heads and hinge connectors are stamped from 2 500 × 1 250 mm sheets (3.125 m² each). Because stamped blanks cannot tile a sheet perfectly, a nesting efficiency of 75 % is applied — a conservative figure for rectangular blanks on a progressive die, to be confirmed against the die layout in §6.3.5 [VERIFY]. Sheet stamping carries the 5 % scrap allowance, so sheets are sized on the gross part rates of Table 6.2.

**Equation 6.6: Parts nested per sheet**

$$
\text{Parts/sheet} = \left\lfloor \frac{\text{Sheet area} \times \text{Nesting efficiency}}{\text{Blank area}} \right\rfloor
\;\Rightarrow\;
\text{Heads: } \left\lfloor \frac{3.125 \times 0.75}{0.0238} \right\rfloor = 98; \quad
\text{Hinges: } \left\lfloor \frac{3.125 \times 0.75}{0.004} \right\rfloor = 585
$$

**Equation 6.7: Daily sheet requirement**

$$
\text{Sheets/day} = \left\lceil \frac{\text{Gross parts/day}}{\text{Parts per sheet}} \right\rceil
\;\Rightarrow\;
\text{Heads: } \left\lceil \frac{1\,914.7}{98} \right\rceil = 20; \quad
\text{Hinges: } \left\lceil \frac{1\,914.7}{585} \right\rceil = 4
$$

**Table 6.6: Aluminium sheet requirement**

| Measure | Heads | Hinges | Unit | Basis / Source |
|---|---|---|---|---|
| Blank size | 0.17 × 0.14 | 0.08 × 0.05 | m | Forming-allowance assumptions [VERIFY die design] |
| Gross parts per day | 1 915 | 1 915 | parts/day | Table 6.2 (5 % stamping scrap) |
| Parts nested per sheet | 98 | 585 | parts | Equation 6.6 (75 % nesting) |
| Sheets per day | 20 | 4 | sheets/day | Equation 6.7 |
| Total sheets per day | 24 | | sheets/day | Heads + hinges |
| Sheets for 2-week cover | 240 | | sheets | 24 × 10 working days |

### Two-week raw-material stockholding

**Equation 6.8: Two-week raw-material stock**

$$
\text{Stock} = \text{Daily requirement} \times 10\ \text{working days}
$$

**Table 6.7: Two-week raw-material requirement**

| Raw material | Daily requirement | 2-week stock | Unit | Basis / Source |
|---|---|---|---|---|
| Aluminium tube (6 m, Ø31.70 × 3.18 mm) | 99 | 990 | tubes | Equation 6.8; Table 6.5 |
| Aluminium sheet (2 500 × 1 250 × 2.5 mm) | 24 | 240 | sheets | Equation 6.8; Table 6.6 |
| Packaging bags | 1 819 | 18 190 | bags | 1 per shovel; 2-week cover applied to bought-out items (assumption) [VERIFY purchasing policy] |
| Rivets | 3 638 | 36 380 | rivets | 2 per shovel (assumed) [VERIFY count] |

*The workbook expresses total raw-material inventory as 18 190 shovel-equivalents; Table 6.7 expresses the same cover in purchasable units, which is the form required for storage and receiving design.*

### Key Findings and Layout Implications

The two-week stockholding translates into physically dissimilar storage problems, which is why §6.6 treats them separately: 990 six-metre tubes require horizontal cantilever racking with long-side access for a forklift or side-loader, whereas 240 sheets stack compactly on pallets or in a sheet rack beside the stamping presses; bags and rivets are small-volume items suited to shelf storage at the packaging and riveting workstations respectively. Both metal stores should sit adjacent to receiving and feed directly into their respective process streams — tubes to the cutting saw, sheets to the presses — preserving the split flow established in §6.1 and avoiding cross-traffic at the head of the line. The daily replenishment burden is modest (99 tubes and 24 sheets per day, equivalent to roughly two to three consolidated deliveries per week if suppliers deliver in multi-day lots [VERIFY supplier delivery cadence]), so receiving capacity is governed by unit-load handling and finished-goods dispatch rather than raw-material volume. Two assumptions materially affect these quantities and are carried as verification items: the 2.5 mm kerf (a narrower blade raises tube yield back towards 40 sections), and the 75 % nesting efficiency, which drives the sheet count almost linearly and must be confirmed against the progressive-die layout selected in §6.3.5–6.3.6. Neither changes the order of magnitude of the storage area, but both must be settled before racking is finalised in §6.6.

[Insert Figure 6.3 here: Split-flow diagram for tube and sheet processing — tube store → cutting → internal threading (middle section) / end narrowing → knurling and external threading (back section), in parallel with sheet store → head and hinge stamping → hinge bending / head shaping → sharpening → serrating → riveting (sheet parts converge: head subassembly). Both streams continue independently through finishing until they converge at final assembly. Redraw in diagrams.net.]

## 6.3 Manufacturing Processes and Workstations

This section specifies each manufacturing process, the equipment type selected for it, and the workstation concept that the layout must accommodate. Machine and operator counts are stated per process and derived formally in §6.4; the workbook allocates 6 m² per standard workstation including operator space, an assumption tested against actual equipment footprints as each process is detailed. Equipment named below is a **market example used for sizing, workstation design and illustration only** — final selection requires supplier quotations, confirmed throughput, verified dimensions, safety clearances and cost confirmation. Subsections 6.3.1–6.3.4 cover the tube stream; 6.3.5 onwards cover the sheet stream, finishing and assembly.

### 6.3.1 Tube Cutting

**Process description.** Six-metre aluminium stock tubes are cut into 150 mm handle sections at 15 s per cut. This is the head of the tube stream and one of only two scrap-generating operations (5 % allowance), so the saw must deliver the gross rate of 3 830 tube sections/day (Equation 6.3).

**Machine selection and justification.** A fully automatic non-ferrous circular saw with powered bar feed is selected because the cut is short, highly repetitive (≈ 3 830 cycles/day) and dimensionally simple, which favours automatic feeding and cut-to-length control over manual sawing; automatic feeding also removes the operator from the blade area. Machines of this class accept full 6 m bars, position the stock by servo feed and cut to programmed length. A representative example is the ProfiFeed A420 fully automatic aluminium saw (bar feeding, cut-to-length, servo positioning, CE-guarded) ([ProfiFeed Technologies](https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/), accessed 10 June 2026). Bundle cutting (several tubes per stroke) is available on machines of this class and is the principal lever for relieving this station's near-full utilisation; the base plan conservatively assumes one tube per cut.

**Machine specifications (Table 6.8).**

| Item | Value | Basis / Source |
|---|---|---|
| Equipment type | Automatic non-ferrous circular saw with bar feed | Process requirement; market example: ProfiFeed A420 |
| Cycle time | 15 s/cut | Brief |
| Daily throughput required | 3 830 tube sections/day | Equation 6.3 |
| Machines required | 2 (utilisation 99.7 %) | §6.4 |
| Operators | 2 (1 per machine) | Workbook (1:1 baseline) |
| Dimensions / power | [VERIFY] supplier datasheet | Not published on product page |
| Infeed length | ≥ 6 m bar magazine | Stock length (implication for footprint) |

**Workstation concept.** The operator loads 6 m tubes from the adjacent cantilever rack onto the bar magazine, monitors the automatic cycle, and clears cut sections into WIP bins; scrap offcuts and the 5 % rejects drop to a scrap bin at the outfeed. The 6 m²/workstation allowance in the workbook materially understates this station: with a 6 m infeed magazine plus saw body and operator aisle, the realistic footprint is an 8–10 m strip per saw. This is flagged as a correction to the space model in §6.8 [VERIFY against selected machine].

[Insert Figure 6.4 here: Conceptual tube-cutting workstation — cantilever rack side-feeding the bar magazine, saw, operator aisle, WIP section bins at outfeed, scrap bin. Redraw in diagrams.net; machine proportions may be adapted from the ProfiFeed product page (cited visual reference — redraw, do not copy).]

**Material handling.** Tubes arrive by forklift or side-loader from the raw-tube store in rack-length bundles; cut sections leave in wheeled WIP bins or tube carts to the threading and narrowing stations; the scrap bin is exchanged daily on the waste route.

**Layout implications.** This station anchors the tube stream: it must sit directly against the raw-tube store with straight-line, long-load access (wide aisle, no tight turns for 6 m stock), generates scrap requiring a waste route, and feeds two downstream stations in parallel. Its long infeed dictates the orientation of the entire tube line along one building edge.

### 6.3.2 Internal Threading

**Process description.** The middle handle section receives an internal thread (20 s per pipe) so that the externally threaded back handle can screw into it, forming the folding shovel's two-piece handle. Input is the gross flow of cut sections allocated to middle handles, 1 915 pipes/day.

**Machine selection and justification.** A bench-mounted tapping machine with a torque-limited tapping head is selected: thread cutting in soft aluminium at this size is a low-force, short-cycle operation that does not justify CNC turning capacity, and an articulated or column tapping machine with a clutch-protected tap holder gives repeatable depth and protects taps at high daily volumes. A representative example is the Roscamat Tiger electric tapping machine, whose interchangeable speed modules cover threads up to M30 in aluminium with torque-limited quick-change tap holders ([Cotswold Machinery Sales — Roscamat Tiger](https://www.cotswold-machinery-sales.co.uk/roscamat-tapping-machines/electric-tapping-machines/roscamat-tiger-electric-tapping-machine/), accessed 10 June 2026). A dedicated fixture to clamp the Ø31.70 mm pipe is required [VERIFY thread specification against product design].

**Machine specifications (Table 6.9).**

| Item | Value | Basis / Source |
|---|---|---|
| Equipment type | Electric tapping machine, torque-limited head | Market example: Roscamat Tiger |
| Thread capacity (aluminium) | Up to M30 | Supplier specification table |
| Working envelope | 1 020 mm radius | Supplier specification table |
| Cycle time | 20 s/pipe | Brief |
| Daily throughput required | 1 915 pipes/day | Table 6.2 (middle handles, gross) |
| Machines required | 2 (utilisation 66.5 %) | §6.4 |
| Operators | 2 | Workbook (1:1) |
| Power | 220 V single phase | Supplier specification table |

**Workstation concept.** The operator clamps a pipe in the fixture, taps under power, and unloads to the WIP bin — a classic bench cell within the standard 6 m² allowance. WIP buffers sit before (cut sections) and after (threaded pipes); the 66.5 % utilisation provides slack that absorbs upstream saw interruptions.

**Material handling.** Cut sections arrive by tube cart from the saw outfeed; threaded pipes move by cart to powder-coating staging. No scrap stream (chips only, to a swarf bin).

**Layout implications.** Position immediately downstream of tube cutting, beside end narrowing (§6.3.3) so the two parallel handle routes stay visually paired and share WIP space. Chip extraction or swarf bins are needed but no special ventilation or separation.

### 6.3.3 End Narrowing

**Process description.** One end of the back handle section is narrowed (stamped/swaged) at 5 s per pipe to form the grip end that will be knurled and externally threaded. Input is 1 915 pipes/day (back handles, gross).

**Machine selection and justification.** A ram-type tube end-forming (swaging) machine is selected: end reduction by ram forming presses a die over the tube end in a single short stroke, matching the 5 s cycle and producing the stepped-down diameter without cutting. Tube end formers perform exactly this reduction/swaging operation; standard catalogue machines from one representative manufacturer cover 4–20 mm tube as standard with larger capacities (including the Ø31.70 mm DigMore tube) available on rotary and custom models ([Hippo — tube end former](https://www.hippobender.com/tube-end-former/), accessed 10 June 2026). The machine class is confirmed; the specific model for Ø31.70 × 3.18 mm must be specified at quotation [VERIFY].

**Machine specifications (Table 6.10).**

| Item | Value | Basis / Source |
|---|---|---|
| Equipment type | Ram-type tube end former (reduction/swaging die) | Process requirement; market reference: Hippo |
| Cycle time | 5 s/pipe | Brief |
| Daily throughput required | 1 915 pipes/day | Table 6.2 (back handles, gross) |
| Machines required | 1 (utilisation 33.2 %) | §6.4 |
| Operators | 1 | Workbook (1:1) |
| Capacity for Ø31.70 × 3.18 mm | [VERIFY] model selection | Standard range 4–20 mm; larger on rotary/custom models |

**Workstation concept.** Load pipe into clamp die, single forming stroke, unload — one operator, standard 6 m² cell, WIP bins both sides. At 33 % utilisation this station has ample spare capacity and could later absorb a second forming operation if product variants are introduced.

**Material handling.** Tube cart in from cutting; cart out to knurling and external threading. No scrap stream.

**Layout implications.** Must directly precede knurling/external threading (§6.3.4) since it creates the grip geometry that station threads; a one-piece flow lane from narrowing into the knurling bank avoids double handling of the same pipe.

### 6.3.4 Knurling and External Threading

**Process description.** The narrowed grip end of the back handle is knurled and externally threaded in a combined 60 s cycle. This is the longest tube-stream operation and, with sharpening, one of the two utilisation-critical stations in the facility. Input is 1 915 pipes/day.

**Machine selection and justification.** A two-die cylindrical thread- and profile-rolling machine is selected because rolling cold-forms both the knurl pattern and the external thread without cutting: it is chipless, produces work-hardened threads of higher fatigue strength than cut threads, and completes the form in a single pass — attributes suited to a thin-walled aluminium tube end where cut threads would weaken the wall. A representative example with a published specification is the Profimach PTR 42 two-roll machine (rolling capacity Ø6–42 mm, 150 kN rolling pressure, 1 500 × 1 580 × 1 140 mm, 4.0 kW main motor) ([Profimach PTR series](https://profimach.com/special-machine/2-roll-thread-roll-machines-ptr-series), accessed 10 June 2026), which spans the Ø31.70 mm DigMore tube. Thread rolling at this scale typically cycles far faster than the brief's 60 s; the brief value is retained as the design basis, so any realised cycle improvement converts directly into spare capacity at this four-machine bank [VERIFY achievable cycle at quotation].

**Machine specifications (Table 6.11).**

| Item | Value | Basis / Source |
|---|---|---|
| Equipment type | 2-die cylindrical thread/profile rolling machine | Market example: Profimach PTR 42 |
| Rolling capacity | Ø6–42 mm; 150 kN | Supplier specification table |
| Dimensions (L × W × H) | 1 500 × 1 580 × 1 140 mm | Supplier specification table |
| Main motor | 4.0 kW | Supplier specification table |
| Cycle time | 60 s/pipe | Brief (design basis) |
| Daily throughput required | 1 915 pipes/day | Table 6.2 (back handles, gross) |
| Machines required | 4 (utilisation 99.7 %) | §6.4 |
| Operators | 4 | Workbook (1:1) |

**Workstation concept.** Four identical machines arranged as a bank, each with an operator loading the narrowed pipe between the dies, cycling, and unloading to the coated-parts staging cart. The published machine footprint (≈ 2.4 m² each) sits within the 6 m² allowance once operator space and WIP bins are added, supporting the workbook's space model for this station. WIP staging ahead of the bank is essential: at 99.7 % utilisation the bank has no recovery margin, so a buffer of narrowed pipes decouples it from upstream stoppages.

[Optional Figure 6.4b: Tube-finishing cell concept — narrowing station feeding the four-machine rolling bank, shared WIP buffer, carts to powder-coat staging. Redraw in diagrams.net; machine proportions may be adapted from the Profimach product page (cited visual reference — redraw, do not copy).]

**Material handling.** Carts in from end narrowing; completed back handles join threaded middle handles on carts to powder-coating staging. Coolant/lubricant service to each machine; no scrap stream.

**Layout implications.** The four-machine bank is the largest single floor-area driver in the tube stream and, with its 99.7 % utilisation, the tube stream's capacity constraint. It should sit at the end of the tube line with generous WIP staging on its infeed side, maintenance clearance around each machine (the bank cannot afford extended downtime), and a direct route to powder-coat staging where both handle types consolidate. Together with sharpening (§6.3.9), this station determines whether the facility meets takt; both must be placed where supervision and maintenance can reach them quickly.
