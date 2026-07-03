# Section 6 — Proposed Structure and Drafts 6.1–6.2
**Status:** 6.1 confirmed ("proceed"). 6.2 drafted below — awaiting feedback before 6.3.
**Numbering convention (confirmed):** part-level requirement table sits in 6.1 as Table 6.2; later tables shift by one. Equations numbered sequentially through the chapter.
**Source of all values:** `DigMore_Facility_Calculations_v2.xlsx` (sheets: Inputs, Demand, Capacity, RawMaterials, Inventory_Pack, Report Map - Ch6).

---

## PART 1 — Proposed Section 6 Structure

6. Detail Design Specifications
6.1 Demand and Production Requirements *(Demand sheet)*
6.2 Raw Material Requirements *(RawMaterials sheet)*
6.3 Manufacturing Processes and Workstations *(Capacity, Equipment-dep, Machinery sheets)*
  6.3.1 Tube Cutting
  6.3.2 Internal Threading
  6.3.3 End Narrowing
  6.3.4 Knurling and External Threading
  6.3.5 Shovel Head Stamping
  6.3.6 Hinge Connector Stamping
  6.3.7 Hinge Connector Bending
  6.3.8 Shovel Head Shaping and Bending
  6.3.9 Blade Sharpening
  6.3.10 Blade Serrating
  6.3.11 Riveting
  6.3.12 Heat Treatment
  6.3.13 Sandblasting
  6.3.14 Hand Polishing and Deburring
  6.3.15 Powder Coating
  6.3.16 Final Assembly
  6.3.17 Packaging and Final Visual Check
6.4 Manufacturing Time and Capacity *(Capacity sheet — machines, operators, utilisation, bottleneck)*
6.5 Receiving and Dispatch *(Inventory_Pack, Parking, Inputs sheets)*
6.6 Storage and Material Handling *(Storage_3D, Inventory_Pack sheets)*
6.7 Supporting Facilities *(Personnel, Parking sheets)*
6.8 Space Requirements *(Space_Summary sheet)*

### Structural decision to confirm (one numbering conflict)

Your `Report Map - Ch6` tab places **the part-level daily requirement table** (Demand!A11:D17) in 6.1, but your prompt reserves Table 6.2 for "Product components and raw-material basis" in §6.2. I have followed the Report Map and included the part-level table in 6.1 as **Table 6.2**, because gross daily rates are demand outputs, not raw-material inputs. Consequence: subsequent table numbers shift by one (raw-material basis becomes Table 6.3, etc.). **Confirm or I will merge it into §6.2 instead.**

### What I will extract from the spreadsheet (per subsection)

| Section | Sheet / range | Key live values |
|---|---|---|
| 6.1 | Demand!A3:D17, Inputs!B8:E13 | 1 819/day; 480 min; 15.83 s takt; gross rates |
| 6.2 | RawMaterials!A3:C22 | 96 tubes/day; 960 tubes/2 wk; 24 sheets/day; 240 sheets/2 wk |
| 6.3 | Capacity!A3:P19, Equipment-dep, Machinery | cycle times, machines per process, equipment types |
| 6.4 | Capacity!A3:P19 | 34 machines; 34 operators; util. avg 62.5%; sharpening bottleneck (8 stations, 94.7%) |
| 6.5 | Inventory_Pack, Inputs | 5 pallets/day out; small order ≤ 400 units; 6 truck bays; 250 m² docks |
| 6.6 | Storage_3D, Inventory_Pack | 960 tubes / 4 cantilever racks; 240 sheets; 91 FG pallets / 59.5 m²; WIP 1 819 units |
| 6.7 | Personnel, Parking | 60 headcount; 70 car bays; 1 750 m²; 360 m² truck area |
| 6.8 | Space_Summary | 1 305.76 m² functional; 1 697.5 m² + 170 m² expansion = 1 867 m² building; 3 977 m² site |

### Benchmark features I will follow (style only)

From **Benchmark B**: demand equations placed first with numbered equations and a summary table (its Eq. 1–4 and Table 2 pattern); raw-material requirements driven by equations before tables; manufacturing time linked directly to machine counts; per-process subsections combining process description, equipment, workstation and material handling; figures integrated into the narrative. From **A/C**: concise table layout with Basis/Source columns and explicit assumption flagging. No benchmark text, values or product facts will be reused.

### DeepSearch needed (later subsections, not 6.1)

Web research with verified links is required only where the Machinery sheet says "supplier/verify": non-ferrous automatic cold saw with bar feed (6.3.1); thread-rolling/knurling machine (6.3.2, 6.3.4); mechanical power press (6.3.5, 6.3.6); press brake (6.3.7, 6.3.8); grinding/serrating equipment (6.3.9, 6.3.10); riveter (6.3.11); T6 ageing oven (6.3.12); enclosed blast booth (6.3.13); conveyorised powder line (6.3.15); pallet racking and cantilever racking (6.6). All links will be opened and checked before citation, presented as market examples only.

---

## PART 2 — Draft 6.1

# 6. Detail Design Specifications

This chapter converts the DigMore Co. demand and product specifications into the quantitative design parameters that govern the new facility: production rates, raw-material quantities, machine and operator requirements, receiving and dispatch loads, storage volumes and floor-space estimates. Each parameter is derived from the 2026 assignment brief or calculated in the supporting workbook, and each subsection closes with the implications for material flow and layout, so that the chapter directly feeds the layout alternatives in Chapter [X] and the final Master Facility Plan.

[Insert Figure 6.1 here: Folding mini shovel component breakdown, showing the back handle section, middle handle section, shovel head and hinge connector, with material callouts (Ø31.70 × 3.18 mm aluminium tube; 2.5 mm aluminium sheet). Recommend redrawing in diagrams.net or PowerPoint from the product description in the brief.]

## 6.1 Demand and Production Requirements

The facility must produce 400 000 folding mini shovels per year over 220 working days, on a single 9-hour shift containing one 30-minute lunch break and two 15-minute tea breaks, leaving 480 productive minutes per day. These four parameters fix the production rate of every downstream process and are therefore established before any equipment or space calculation. The daily requirement is calculated in Equation 6.1 and rounded up, since rounding down would accumulate an annual shortfall against the contracted demand.

**Equation 6.1: Daily demand**

$$
\text{Daily demand} = \left\lceil \frac{\text{Annual demand}}{\text{Working days}} \right\rceil = \left\lceil \frac{400\,000\ \text{shovels/yr}}{220\ \text{days/yr}} \right\rceil = \lceil 1\,818.2 \rceil = 1\,819\ \text{shovels/day}
$$

Dividing the daily requirement across the 8 productive hours gives an hourly rate of 1 819 ÷ 8 = 227.4 ≈ 228 shovels per hour. The takt time — the rate at which one completed shovel must leave the line for demand to be met — follows in Equation 6.2, with the unit conversion shown explicitly.

**Equation 6.2: Takt time**

$$
\text{Takt time} = \frac{\text{Effective time per day}}{\text{Daily demand}} = \frac{480\ \text{min/day}}{1\,819\ \text{shovels/day}} = 0.264\ \text{min/shovel} = 15.83\ \text{s/shovel}
$$

The workbook sizes all equipment on the full 480 effective minutes, i.e. an availability factor of 1.0. This is the brief's stated basis, but it leaves no allowance for setup, breakdown or changeover time; the sensitivity of machine counts to a lower availability is noted in §6.4, and the brief permits overtime as the flexibility mechanism rather than the base plan. Table 6.1 consolidates the production parameters.

**Table 6.1: Demand and production parameters**

| Parameter | Value | Unit | Basis / Source |
|---|---|---|---|
| Annual demand | 400 000 | shovels/yr | 2026 brief |
| Working days | 220 | days/yr | 2026 brief |
| Shift length | 540 | min/day | 9 h shift (brief) |
| Breaks | 60 | min/day | 30 + 15 + 15 min (brief) |
| Effective production time | 480 | min/day | Shift − breaks |
| Availability factor | 1.0 | — | Design basis (brief); no setup/breakdown allowance |
| Daily demand (good units) | 1 819 | shovels/day | Equation 6.1, rounded up |
| Hourly demand | ≈ 228 | shovels/h | Daily demand ÷ 8 h |
| Takt time | 15.83 | s/shovel | Equation 6.2 |
| Scrap allowance | 5 | % | Tube cutting and sheet stamping only (brief) |
| Process yield (scrap steps) | 95 | % | 1 − scrap rate |

Because the 5 % scrap allowance applies only to tube cutting and sheet stamping, the processes upstream of (and including) those two steps must run at a gross rate of good demand ÷ 0.95, i.e. 5.26 % above the good-unit rate. Table 6.2 translates the daily demand into part-level requirements per the product structure: each shovel consumes two 150 mm tube sections (back and middle handle), one shovel head and one hinge connector.

**Table 6.2: Part-level daily production requirement**

| Part | Qty per shovel | Good units/day | Gross units/day | Basis / Source |
|---|---|---|---|---|
| Back handle section (tube) | 1 | 1 819 | — | Product structure (brief) |
| Middle handle section (tube) | 1 | 1 819 | — | Product structure (brief) |
| Handle sections to be cut (tube) | 2 | 3 638 | 3 830 | Gross = good ÷ 0.95 (5 % cutting scrap) |
| Shovel head (sheet) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (5 % stamping scrap) |
| Hinge connector (sheet) | 1 | 1 819 | 1 915 | Gross = good ÷ 0.95 (5 % stamping scrap) |

*Gross values rounded up from 3 829.5 and 1 914.7 respectively; the workbook carries unrounded values through subsequent calculations to avoid compounding rounding error.*

### Key Findings and Layout Implications

The takt time of 15.83 s/shovel is the single most consequential number in this chapter. Several brief-specified cycle times exceed it by a wide margin — blade sharpening at 120 s, knurling and external threading at 60 s, serrating at 60 s and hand polishing at 60 s — so these processes cannot meet demand on single machines and must be parallelised (sharpening alone requires 8 stations, calculated in §6.4). The layout must therefore provide banks of identical workstations at these operations, which makes them the dominant drivers of production floor area and of WIP staging between unbalanced stages. Second, because scrap arises only at tube cutting and sheet stamping, those two workstations need scrap bins and a dedicated scrap-removal route to the waste store, and they pull raw material at 5.26 % above the good-unit rate — which feeds directly into the raw-material and storage calculations of §6.2 and §6.6. Third, the gross tube-section requirement of 3 830 cuts/day against 3 638 good sections confirms that the tube line and the sheet line run as two parallel streams that only converge at riveting and final assembly; the layout alternatives must accommodate this split flow from raw-material storage onward (see Figure 6.3 in §6.3). Finally, the single-shift, availability-1.0 basis means any machine downtime translates directly into overtime; this argues for maintenance access space at the high-utilisation stations identified in §6.4.

[Insert Figure 6.2 here: High-level material flow from receiving to dispatch, showing the parallel tube and sheet streams converging at riveting/assembly, then heat treatment, sandblasting, polishing, enclosed powder coating, final assembly, packaging, finished-goods storage and dispatch. Recommend drawing in diagrams.net.]

---

## PART 3 — Draft 6.2

## 6.2 Raw Material Requirements

The product consumes two raw-material streams: aluminium round tube (Ø31.70 mm outside diameter, 3.18 mm wall) for the two handle sections, and 2.5 mm aluminium sheet for the shovel head and hinge connector. Packaging bags are bought from an outside supplier and rivets are purchased hardware; neither is manufactured on site. The brief requires two weeks of raw material to be held indoors, which on the 220-day calendar equals 10 working days of cover. This subsection converts the gross daily part requirements of Table 6.2 into purchasable raw-material units — full-length tubes and standard sheets — because storage racking, receiving loads and material-handling equipment are all sized in those units, not in finished parts. Table 6.3 records the conversion basis.

**Table 6.3: Product components and raw-material basis**

| Component | Raw material | Blank / section size | Source unit | Basis / Source |
|---|---|---|---|---|
| Back handle section | Al round tube Ø31.70 × 3.18 mm | 150 mm section | 6 m stock tube [VERIFY supplier length] | Brief; stock length assumption (Inputs) |
| Middle handle section | Al round tube Ø31.70 × 3.18 mm | 150 mm section | 6 m stock tube [VERIFY supplier length] | Brief; stock length assumption (Inputs) |
| Shovel head | Al sheet, 2.5 mm | 0.17 × 0.14 m blank (incl. forming allowance) | 2.5 × 1.25 m sheet | Brief (finished 150 × 120 mm); blank allowance assumption |
| Hinge connector | Al sheet, 2.5 mm | 0.08 × 0.05 m blank | 2.5 × 1.25 m sheet | Blank size assumption |
| Packaging bag | Bought-out | — | Per shovel | Brief (outside supplier) |
| Rivets | Bought-out | — | Per shovel [VERIFY qty per joint] | Brief (riveted joint); not sized in workbook |

### Aluminium tube requirement

Each shovel requires two 150 mm handle sections, and tube cutting carries the 5 % scrap allowance, so the cutting line must produce the gross section rate derived in Equation 6.3. A 6 m stock tube yields 40 sections at 150 mm if saw kerf is ignored — the workbook's stated basis; the sensitivity of this assumption is addressed in the key findings below.

**Equation 6.3: Daily gross tube-section requirement**

$$
\text{Gross sections/day} = \frac{\text{Good sections/day}}{1 - \text{scrap rate}} = \frac{2 \times 1\,819}{0.95} = \frac{3\,638}{0.95} = 3\,829.5 \approx 3\,830\ \text{sections/day}
$$

**Equation 6.4: Daily 6 m tube requirement**

$$
\text{Tubes/day} = \left\lceil \frac{\text{Gross sections/day}}{\text{Sections per tube}} \right\rceil = \left\lceil \frac{3\,829.5}{40} \right\rceil = \lceil 95.7 \rceil = 96\ \text{tubes/day}
$$

**Table 6.4: Aluminium tube requirement**

| Measure | Value | Unit | Basis / Source |
|---|---|---|---|
| Tube sections per shovel | 2 | sections | Product structure (brief) |
| Good sections per day | 3 638 | sections/day | 2 × 1 819 |
| Gross sections per day | 3 830 | sections/day | Equation 6.3 (5 % cutting scrap) |
| Sections per 6 m tube | 40 | sections | 6 000 ÷ 150 mm, kerf ignored [VERIFY] |
| Tubes per day | 96 | tubes/day | Equation 6.4 |
| Tubes for 2-week cover | 960 | tubes | 96 × 10 working days |

### Aluminium sheet requirement

Shovel heads and hinge connectors are stamped from standard 2.5 × 1.25 m sheets (3.125 m² each — a workbook assumption pending supplier confirmation [VERIFY]). Because stamped blanks cannot tile a sheet perfectly, the workbook applies a nesting efficiency of 75 %, giving the usable yield per sheet in Equation 6.5. Sheet stamping carries the 5 % scrap allowance, so sheets are sized on the gross part rates of Table 6.2.

**Equation 6.5: Parts nested per sheet**

$$
\text{Parts/sheet} = \left\lfloor \frac{\text{Sheet area} \times \text{Nesting efficiency}}{\text{Blank area}} \right\rfloor
\quad\Rightarrow\quad
\text{Heads: } \left\lfloor \frac{3.125 \times 0.75}{0.0238} \right\rfloor = 98; \quad
\text{Hinges: } \left\lfloor \frac{3.125 \times 0.75}{0.004} \right\rfloor = 585
$$

**Equation 6.6: Daily sheet requirement**

$$
\text{Sheets/day} = \left\lceil \frac{\text{Gross parts/day}}{\text{Parts per sheet}} \right\rceil
\quad\Rightarrow\quad
\text{Heads: } \left\lceil \frac{1\,914.7}{98} \right\rceil = 20; \quad
\text{Hinges: } \left\lceil \frac{1\,914.7}{585} \right\rceil = 4
$$

**Table 6.5: Aluminium sheet requirement**

| Measure | Heads | Hinges | Unit | Basis / Source |
|---|---|---|---|---|
| Blank size | 0.17 × 0.14 | 0.08 × 0.05 | m | Forming allowance assumptions (Inputs) |
| Gross parts per day | 1 915 | 1 915 | parts/day | Table 6.2 (5 % stamping scrap) |
| Parts nested per sheet | 98 | 585 | parts | Equation 6.5 (75 % nesting) |
| Sheets per day | 20 | 4 | sheets/day | Equation 6.6 |
| Total sheets per day | 24 | | sheets/day | Heads + hinges |
| Sheets for 2-week cover | 240 | | sheets | 24 × 10 working days |

### Two-week raw-material stockholding

**Equation 6.7: Two-week raw-material stock**

$$
\text{Stock} = \text{Daily requirement} \times 10\ \text{working days}
$$

**Table 6.6: Two-week raw-material requirement**

| Raw material | Daily requirement | 2-week stock | Unit | Basis / Source |
|---|---|---|---|---|
| Aluminium tube (6 m) | 96 | 960 | tubes | Equation 6.7; Table 6.4 |
| Aluminium sheet (2.5 × 1.25 m) | 24 | 240 | sheets | Equation 6.7; Table 6.5 |
| Packaging bags | 1 819 | 18 190 | bags | 1 per shovel [VERIFY cover policy for bought-out items] |
| Rivets | [VERIFY] | [VERIFY] | rivets | Qty per shovel not specified in workbook |

*The workbook expresses total raw-material inventory as 18 190 shovel-equivalents (Inventory_Pack sheet); Table 6.6 expresses the same cover in purchasable units for storage and receiving design.*

### Key Findings and Layout Implications

The two-week stockholding translates into physically dissimilar storage problems, which is why §6.6 treats them separately: 960 six-metre tubes require horizontal cantilever racking with long-side access for a forklift or side-loader, whereas 240 sheets stack compactly on pallets or in a sheet rack beside the stamping presses. Both stores should sit adjacent to receiving and feed directly into their respective process streams — tubes to the cutting saw, sheets to the presses — preserving the split flow identified in §6.1 and avoiding cross-traffic between the two streams at the start of the line. The daily replenishment burden is modest (96 tubes and 24 sheets per day, roughly two to three vehicle deliveries per week if suppliers deliver in multi-day lots [VERIFY delivery cadence with supplier policy]), so receiving is sized by finished-goods dispatch and unit-load handling rather than by raw-material volume. Two assumptions materially affect these quantities and are carried as verification items: first, the 40-sections-per-tube basis ignores saw kerf — at any realistic kerf width a 6 m tube yields 39 sections, raising the requirement to ⌈3 829.5 ÷ 39⌉ = 99 tubes/day and 990 tubes of stock (≈ 3 % more racking); second, the 75 % nesting efficiency drives the sheet count almost linearly, so the progressive-die layout chosen in §6.3.5–6.3.6 should be confirmed against it. Neither changes the order of magnitude of the storage area, but both should be settled before racking is finalised in §6.6.

[Insert Figure 6.3 here: Split-flow diagram for tube and sheet processing, showing tube store → cutting → threading/narrowing/knurling stream in parallel with sheet store → stamping → bending/shaping stream, converging at riveting and final assembly. Recommend drawing in diagrams.net.]

---

## Items flagged for your confirmation (6.2)

1. **Kerf sensitivity** — workbook uses 40 sections/tube (kerf ignored). I kept 96 tubes/day as the design value and flagged the 39-section case (99 tubes/day) in the key findings. Confirm, or update the workbook and I will re-derive.
2. **Bought-out items** — packaging bags (18 190 for 2 weeks at 1/shovel) and rivets are not sized in the workbook. I added them to Table 6.6 with [VERIFY]. Confirm whether the 2-week cover policy applies to bought-out items, and the rivet count per shovel.
3. **Sheet size 2.5 × 1.25 m and 75 % nesting** — both workbook assumptions, flagged [VERIFY] for supplier confirmation.
4. **Equation numbering** — Eq. 6.3–6.7 used here; machine-requirement and storage equations in §6.4/§6.6 will continue from 6.8. Confirm.

### Resolved at 6.1 (accepted via "proceed")
Table numbering per Report Map; availability 1.0 flagged with §6.4 sensitivity; hourly demand displayed ≈ 228; no brief/spreadsheet conflicts in 6.1.
