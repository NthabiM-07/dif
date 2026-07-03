# Consolidated DigMore Facility Design Report — Sections 8–12 + Appendix C

**Module:** INGB417 Facilities Design
**Assessment:** GA3 Exam (1st Opportunity, June 2026)
**Product:** DigMore Co. folding mini shovel
**Compiled:** 12 June 2026

---

# 8. Detailed Design Specifications

This section converts the design objectives and requirements (Sections 1–4), the demand and capacity analysis (Section 5), the assumptions and processing times (Section 6) and the process flow (Section 7) into measurable production, storage, capacity, workstation, material-handling and space requirements. The calculations below are the design basis used to develop the alternative block layouts (Section 9), to evaluate them (Section 10) and to develop the final Master Facility Plan (Section 11).

The single source of truth for all numerical calculations in this section is the capacity and space workbook held at `05_Working/5.1_Capacity_Model/417.xlsx`. Equipment named below is used as a market example for sizing only. Final equipment selection, costs, service requirements and installation allowances must be confirmed through supplier quotations.

## 8.1 Demand Calculation

The production demand is calculated from the projected annual demand and the available working days per year given in the brief. The facility operates one 9-hour shift per day. After deducting one 30-minute lunch break and two 15-minute tea breaks, **480 productive minutes** are available per shift.

$$
\text{Daily shovel production} = \frac{400\,000}{220} = 1\,818.18 \approx 1\,819 \text{ shovels/day} \tag{8.1}
$$

$$
\text{Hourly shovel production} = \frac{1\,819}{8} = 227.38 \approx 228 \text{ shovels/hour} \tag{8.2}
$$

$$
\text{Takt time} = \frac{480 \times 60}{1\,819} = 15.83 \text{ seconds/shovel} \tag{8.3}
$$

**Table 8.1: Production demand requirements**

| Parameter | Calculation basis | Result |
|---|---|---:|
| Annual demand | Given in brief | 400 000 shovels/year |
| Working days | Given in brief | 220 days/year |
| Productive time | 9 h shift less breaks | 480 min/day |
| Daily production | 400 000 ÷ 220 | 1 819 shovels/day |
| Hourly production | 1 819 ÷ 8 | 228 shovels/hour |
| Takt time | 28 800 s ÷ 1 819 | 15.83 s/shovel |

The daily demand of 1 819 shovels is the master sizing value for the facility. The short takt time of 15.83 s also shows that any process longer than the takt requires parallel stations.

## 8.2 Raw Material Inventory Requirements

The brief requires two weeks of raw-material stock. With five working days per week the basis is ten working days:

$$
\text{Two-week production} = 1\,819 \times 10 = 18\,190 \text{ shovels} \tag{8.4}
$$

### 8.2.1 Aluminium Round Tube

Each shovel uses two 150 mm handle sections (back + middle). With 5 % cutting scrap:

$$
\text{Good sections/day} = 1\,819 \times 2 = 3\,638 \tag{8.5}
$$

$$
\text{Input sections/day} = \frac{3\,638}{0.95} = 3\,830 \tag{8.6}
$$

$$
\text{Sections per 6 m tube} = \frac{6\,000}{150} = 40 \tag{8.7}
$$

$$
\text{Tubes/day} = \frac{3\,830}{40} = 96 \tag{8.8}
$$

$$
\text{Two-week tube stock} = 96 \times 10 = 960 \text{ tubes} \tag{8.9}
$$

A practical 2 mm saw kerf lowers the usable yield from 40 to 39 sections per tube, raising the two-week stock to ≈ 990 tubes. The cantilever rack area is sized against this conservative figure.

### 8.2.2 Aluminium Sheet

Each shovel uses one stamped shovel head and one stamped hinge connector. Both attract 5 % stamping scrap:

$$
\text{Heads/day} = \text{Hinges/day} = \frac{1\,819}{0.95} = 1\,915 \tag{8.10}
$$

Finished shovel head 150 × 120 mm gives $A_{\text{head}} = 0.018 \text{ m}^2$. Designer assumption: hinge connector blank 100 × 120 mm, $A_{\text{hinge}} = 0.012 \text{ m}^2$.

Two-week sheet area: $(1\,915 \times 10 \times 0.018) + (1\,915 \times 10 \times 0.012) = 344.7 + 229.8 = 574.5 \text{ m}^2$. At standard 2 500 × 1 250 mm sheets (3.125 m² each) and 75 % nesting yield, ≈ **245 sheets per two-week cycle**.

**Table 8.2: Raw-material inventory requirement**

| Material | Daily | Two-week | Layout implication |
|---|---:|---:|---|
| Aluminium round tube, 6 m | 96 | 960–990 tubes | Long-material storage at receiving |
| Shovel head blanks | 1 915 | 19 150 | Sheet rack near press |
| Hinge connector blanks | 1 915 | 19 150 | Sheet rack near press |
| Aluminium sheet (combined) | ≈ 25 sheets | ≈ 245 sheets | Sheet rack within forklift reach |
| Packaging bags | 1 819 | 18 190 | Shelving near packaging |
| Rivets (1 per shovel) | 1 819 | 18 190 | Small-parts shelving near rivet station |
| Carton boxes (10 shovels/box) | 182 | 1 819 | Flat-pack near packaging |

## 8.3 Raw Material Storage Area

Tubes are stored on cantilever racks (6 m face). Sheet packs are stored on pallet positions. Bought-in parts are stored on shelves.

**Table 8.3: Raw-material storage summary**

| Storage element | Subtotal (m²) |
|---|---:|
| Tube cantilever racks (12 bays × 9.0 m²) | 108.0 |
| Sheet pallet positions (3 × 1.2 m²) | 3.6 |
| Forklift aisles (2 × 21 m²) | 42.0 |
| Subtotal | **153.6** |
| Handling allowance (20 %) | 30.7 |
| **Total raw-material storage area** | **≈ 185 m²** |

## 8.4 Manufacturing Capacity Requirements

The number of stations is calculated by dividing the daily processing load by the available productive time per shift, divided by a planning efficiency of 80 % to absorb micro-stops, tool changes and minor variation:

$$
\text{Stations required} = \left\lceil \frac{\text{Daily quantity} \times \text{Time/unit}}{480 \times 0.80} \right\rceil \tag{8.11}
$$

Processing times are taken from Table 6.2.

**Table 8.4: Base manufacturing capacity requirements (80 % planning efficiency)**

| Stream | Process | Time/unit | Daily qty | Total min/day | Stations | Utilisation |
|---|---|---:|---:|---:|---:|---:|
| Handle | Tube cutting | 15 s | 3 830 | 957.5 | 3 | 79.8 % |
| Handle | Internal threading (middle) | 20 s | 1 915 | 638.3 | 2 | 66.5 % |
| Handle | Grip-end forming | 5 s | 1 915 | 159.6 | 1 | 41.6 % |
| Handle | Knurling + external threading (single op) | 60 s | 1 915 | 1 915.0 | 5 | 99.7 % |
| Sheet | Hinge connector stamping | 2 s | 1 915 | 63.8 | 1 | 16.6 % |
| Sheet | Hinge connector bending | 5 s | 1 819 | 151.6 | 1 | 39.5 % |
| Sheet | Shovel head stamping | 2 s | 1 915 | 63.8 | 1 | 16.6 % |
| Sheet | Shovel head shaping | 2 s | 1 819 | 60.6 | 1 | 15.8 % |
| Sheet | Blade sharpening | 120 s | 1 819 | 3 638.0 | 10 | 94.7 % |
| Sheet | Blade serrating | 60 s | 1 819 | 1 819.0 | 5 | 94.7 % |
| Sub-assy | Riveting | 5 s | 1 819 | 151.6 | 1 | 39.5 % |
| Finishing | Hand polishing | 60 s | 1 819 | 1 819.0 | 5 | 94.7 % |
| Final | Final assembly | 30 s | 1 819 | 909.5 | 3 | 78.9 % |
| Final | Packaging + visual check | 30 s | 1 819 | 909.5 | 3 | 78.9 % |
| | **Direct-labour subtotal** | | | **13 256.8** | **42** | |

**Equipment-dependent processes** (sized from selected supplier specifications, not from a fabricated cycle time):

- Heat treatment — aluminium ageing batch oven, **80 m² zone** (oven + day buffers)
- Sandblasting — enclosed blast booth, **32 m² zone**
- Powder coating — fully enclosed conveyorised line, **120 m² zone**

The high-utilisation operations (knurling/threading 99.7 %, sharpening / serrating / polishing / assembly / packaging ≥ 78.9 %) must be protected by inbound WIP buffers and direct line feeding so that operators do not leave their station to fetch material.

## 8.5 Workstation Design Specifications

Each workstation translates the capacity requirement into a physical design basis: machine footprint, operator position, WIP before and after, local handling and safety clearance.

**Table 8.5: Workstation space roll-up**

| Workstation / bank | Stations | Cell size (m) | Area (m²) |
|---|---:|---|---:|
| Tube cutting | 3 | 9.0 × 2.0 | 54.0 |
| Internal threading | 2 | 3.0 × 2.0 | 12.0 |
| Grip-end forming | 1 | 3.0 × 2.0 | 6.0 |
| Knurling + external threading bank | 5 | 8.4 × 4.4 | 37.0 |
| Sheet-metal press cell | 2 | 6.4 × 4.0 | 25.6 |
| Hinge bending | 1 | 3.4 × 2.5 | 8.5 |
| Shovel-head shaping | 1 | 3.0 × 2.0 | 6.0 |
| Blade sharpening bank | 10 | 8.4 × 7.4 | 62.2 |
| Blade serrating | 5 | 8.4 × 3.5 | 29.4 |
| Hand polishing | 5 | 8.4 × 3.5 | 29.4 |
| Riveting | 1 | 3.7 × 2.6 | 9.6 |
| Final assembly | 3 | 4.4 × 3.1 | 13.6 |
| Packaging | 3 | 6.6 × 3.0 | 19.8 |
| **Workstation subtotal** | **42** | | **313.1** |
| Local WIP / operator clearance / intra-cell aisles (≈ 34 %) | | | 106.9 |
| **Production workstation area (rounded)** | | | **≈ 420 m²** |

Detailed top-down workstation layouts are presented in Appendix C (Figures C1–C13).

## 8.6 Labour Requirement

**Table 8.6: Labour planning summary**

| Group | Basis | Operators |
|---|---|---:|
| Fixed-time stations (Table 8.4) | One operator per station | 42 |
| Heat treatment crew | 1 per shift | 1 |
| Sandblasting crew | 1 per shift | 1 |
| Powder coating crew | Load + unload | 2 |
| Forklift / material-handling | Receiving, store, dispatch | 2 |
| **Production headcount** | | **48** |

Adding office headcount (≈ 12) gives a facility headcount of approximately **60**, matching the workbook.

## 8.7 Work-in-Progress Staging

WIP is provided only where the process flow needs temporary staging between operations.

**Table 8.7: WIP container requirement**

| Part type | Containers |
|---|---:|
| Cut handle sections | 4 |
| Stamped shovel heads | 1 |
| Stamped hinge connectors | 1 |
| Head sub-assemblies before finishing | 6 |
| **Total** | **12** |

For block-layout planning, **12 m²** is allocated to distributed WIP staging.

## 8.8 Finished Goods Storage

The brief requires four weeks of finished-goods stock:

$$
\text{FG stock} = 1\,819 \times 20 = 36\,380 \text{ shovels} \tag{8.12}
$$

Designer assumption: 10 shovels per carton, 24 cartons (240 shovels) per pallet, three-high selective racking.

$$
\text{Pallets} = \frac{36\,380}{240} = 152 \tag{8.13}
$$

$$
\text{Floor positions} = \frac{152}{3} = 51 \tag{8.14}
$$

$$
\text{Net pallet footprint} = 51 \times 1.2 = 61.2 \text{ m}^2 \tag{8.15}
$$

$$
\text{FG storage area} = 61.2 \times 1.40 = 86 \text{ m}^2 \tag{8.16}
$$

(40 % uplift for access aisles, picking and dispatch movement.)

## 8.9 Receiving, Dispatch and Material Handling

**Table 8.8: Receiving and dispatch area basis**

| Area | Allowance (m²) |
|---|---:|
| Receiving dock + unloading staging | 24 |
| Dispatch dock + loading staging | 24 |
| Customer collection point (pedestrian, visitor side) | 15 |
| Dispatch staging (orders waiting) | 20 |
| **Total internal receiving + dispatch** | **83** |

Material handling: 2 × electric counterbalance forklifts, hand pallet trucks (×2), small-parts trolleys, tube cart, plus the 12 WIP containers from Table 8.7. The high-utilisation banks (≥ 94 %) are fed by a 60-minute milk-run so operators do not leave their station.

## 8.10 Production and Support Space Summary

**Table 8.9: Office area derivation**

| Role | Workspace | Area (m²) |
|---|---|---:|
| Senior Plant Manager | Private office, 12 m² | 12 |
| Operations Manager | Private office, 12 m² | 12 |
| Inventory Manager | Private office, 10 m² | 10 |
| Reception | Desk + waiting | 18 |
| Open-plan (Purchasing, Sales, Finance, Marketing, HR) | 6 desks × 5.5 m² | 33 |
| Production supervisors (2) | Shared desk | 12 |
| Meeting room / records | Boardroom | 18 |
| Office circulation (12 %) | | 13 |
| **Total office area** | | **≈ 128 m²** |

**Table 8.10: Amenities derivation**

| Element | Basis | Area (m²) |
|---|---|---:|
| Male WC + change + lockers | 60 % of 48 ops | 30 |
| Female WC + change + lockers | 40 % of 48 ops | 25 |
| Accessible WC | 1 unit | 6 |
| Office restrooms | M + F | 12 |
| Cafeteria (40 seats × 1.4 m² + servery) | | 60 |
| Janitorial | | 7 |
| **Total amenities** | | **≈ 140 m²** |

**Table 8.11: Total internal building space summary**

| Area category | Space (m²) | Basis |
|---|---:|---|
| Raw-material storage | 185 | Table 8.3 |
| Distributed WIP staging | 12 | Table 8.7 |
| Production workstations | 420 | Table 8.5 |
| Heat treatment + sandblasting + powder coating | 232 | §8.4 |
| Finished-goods storage | 86 | Eq 8.16 |
| Receiving + dispatch | 83 | Table 8.8 |
| Offices | 128 | Table 8.9 |
| Amenities | 140 | Table 8.10 |
| Utilities + maintenance | 80 | Allowance |
| Scrap and waste handling | 15 | Local bins + skip access |
| **Functional subtotal** | **1 381** | |
| Circulation (30 %) | 414 | Stephens & Meyers |
| Future expansion reserve (10 %) | 180 | Brief requirement |
| **Estimated internal building area** | **≈ 1 975 m²** | Rounded |

**Table 8.12: External site area summary**

| Area | Allowance (m²) |
|---|---:|
| Staff and visitor parking (70 bays + visitor) | 660 |
| Company truck parking (6 bays) | 360 |
| Truck manoeuvring and access lanes | 700 |
| Security and gate control | 40 |
| External receiving / dispatch apron | 350 |
| **Total external site area** | **≈ 2 110** |

$$
\text{Total site area} = 1\,975 + 2\,110 = 4\,085 \approx 4\,100 \text{ m}^2 \tag{8.17}
$$

## 8.11 Section 8 Design Implications

- Raw-material storage adjacent to receiving and to tube cutting / sheet stamping.
- Knurling + external threading (99.7 %) and sharpening (94.7 %) are the binding constraints — buffered inbound and milk-run fed.
- Heat treatment, sandblasting and powder coating are separated for heat, dust and fume safety. Powder coating is **fully enclosed** as mandated by the brief.
- Packaging sits after assembly and serves as the final visual check.
- Customer collection is pedestrian-only on the visitor side; it never crosses forklift routes.
- 10 % future expansion is visibly reserved and not used to absorb shortfalls elsewhere.

---

# 9. Design Alternatives

Three block-layout alternatives were developed against the Section 8 space basis. Each preserves the parallel handle / sheet streams converging at riveting → finishing → assembly → packaging.

**Table 9.1: Layout alternatives overview**

| Alternative | Flow pattern | Key features | Expansion approach |
|---|---|---|---|
| Alt 1 — Straight-line (I-flow) | Receiving → production → dispatch on one straight axis | Simple flow; dedicated docks at opposite ends | 10 % strip at the dispatch end |
| Alt 2 — U-flow | Receiving and dispatch on the same wall; production loops back | Shared dock zone, shared forklift, customer collection on visitor side | Central reserve void |
| Alt 3 — L-flow (cellular) | Production cells around a central spine that turns 90° | Process clusters near each raw-material source | Reserve along the two outer walls |

**Figure 9.1, 9.2, 9.3 — Block layouts (Alt 1, Alt 2, Alt 3).** Refer to draw.io source files in `05_Working/5.4_MFP_and_Layouts/`.

---

# 10. Evaluation of Alternatives

A weighted-factor evaluation is used. Weights reflect the design objectives (Section 3) and the brief requirements (Section 4). Each alternative is scored 1–5 against each criterion (5 = best).

**Table 10.1: Weighted-factor evaluation**

| Criterion | Weight | Alt 1 (I-flow) | Alt 2 (U-flow) | Alt 3 (L-flow) |
|---|---:|---:|---:|---:|
| Material-flow efficiency (short, single-direction) | 25 % | 3 | 5 | 4 |
| Space utilisation | 20 % | 4 | 4 | 5 |
| Expansion flexibility | 15 % | 3 | 5 | 4 |
| Safety / hazard separation | 15 % | 4 | 5 | 3 |
| Implementation cost | 15 % | 4 | 4 | 3 |
| Customer access (separated from production) | 10 % | 3 | 5 | 4 |
| **Weighted score** | 100 % | **3.55** | **4.70** | **3.85** |

Alternative 2 (U-flow) wins on material-flow efficiency, expansion flexibility, safety separation and customer access — exactly the criteria the brief weighs most heavily.

**Selected: Alternative 2 (U-flow).**

---

# 11. Master Facility Plan (MFP)

The Master Facility Plan is the refined Alternative 2 (U-flow). It uses the Section 8 space basis and respects every design constraint listed in Section 4.

**Building envelope.** ≈ 1 975 m² internal, ≈ 4 100 m² total site (Eq 8.17).

**Zone walk-through** (numbered to match the MFP source file `05_Working/5.4_MFP_and_Layouts/DigMore_MFP_A2.drawio`):

1. **Receiving dock** — single dock door with truck approach apron; tube bundles directed left to cantilever racks, sheet packs straight ahead.
2. **Raw-material storage** — cantilever racks (12 bays for tubes), pallet positions for sheet packs, small-parts shelving for rivets, bags, cartons.
3. **Tube cutting bay** — 3 saws (9 × 2 m each), aligned to the rack face so 6 m bars do not turn.
4. **Internal threading** — 2 bench cells fed from cut-sections bin.
5. **Grip-end forming** — 1 cell, in-line with knurling.
6. **Knurling + external threading bank** — 5 thread-rolling machines with an inbound buffer (binding constraint, 99.7 %).
7. **Sheet-metal press cell** — 2 presses sharing a sheet-staging area and a skeleton-scrap bin.
8. **Hinge bending** + **head shaping** — paired cells immediately downstream of the press.
9. **Blade sharpening bank** — 10 belt grinders in two rows of five, with dust extraction across the back wall (bottleneck bank).
10. **Blade serrating** — 5 stations in-line after sharpening.
11. **Hand polishing** — 5 benches with extraction.
12. **Riveting** — convergence point of the two sheet streams.
13. **Heat treatment** — batch oven with day buffers each side.
14. **Sandblasting** — enclosed blast booth + media recovery.
15. **Powder coating enclosure** — fully enclosed 15 × 8 m room (load → booth → cure → cool → unload), separate make-up air.
16. **Final assembly** — 3 benches where handle stream meets coated head sub-assembly.
17. **Packaging** — 3 benches with bag/carton shelving, pallet-build position and final visual check.
18. **Finished-goods storage** — selective racking, three pallets high, FIFO direction toward dispatch.
19. **Dispatch dock** — shared with receiving on a time-shared basis; truck staging apron outside.
20. **Customer collection** — pedestrian-only counter on the visitor side, with separate entry from staff and forklift routes.
21. **Offices + amenities** — visitor side of the building, served by reception and cafeteria.
22. **Future expansion strip** — visible 10 % reserve along the back wall, hatched on the MFP.

**Material handling.** 2 × electric counterbalance forklifts; hourly milk-run with 12 stops (one for every WIP container from Table 8.7); 3.5 m forklift aisles; 2.0 m trolley lanes; 1.5 m pedestrian aisles.

**Sustainability and utilities.** Roof PV is recommended as a sustainability strategy (powder-coating oven and cure oven are the largest electrical loads). Daylighting through translucent roof panels reduces lighting load over the production hall. Compressed-air ring main and 3-phase 400 V distribution serve the production hall; potable water and trade-waste plumbing service amenities and powder coating.

---

# 12. Business Case, Risk and Implementation

A high-level business case is given here; final supplier quotations will refine the equipment line items.

**Table 12.1: Indicative capital cost summary (ZAR)**

| Item | Indicative cost (ZAR) | Source |
|---|---:|---|
| Building shell (1 975 m² × R10 500/m²) | 20 740 000 | Industrial benchmark |
| Production equipment (saws, presses, grinders, oven, blast, powder-coat line) | 14 500 000 | Supplier-based estimates required |
| Material handling (2 forklifts, racks, trolleys) | 1 850 000 | Krost / Toyota |
| Powder-coat enclosure + extraction | 1 600 000 | P.I. Marketing |
| Office fit-out + amenities | 950 000 | Standard fit-out rate |
| **Subtotal capital** | **≈ 39 640 000** | |
| Contingency (10 %) | 3 964 000 | |
| **Estimated total capital** | **≈ 43 600 000** | |

**Table 12.2: Key risks and mitigation**

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Aluminium price volatility | Medium | High | 2-week buffer stock; review supplier contracts quarterly |
| Sharpening bank breakdown (single bottleneck) | Medium | High | 10 stations + spares pool; preventive maintenance weekly |
| Powder-coat compliance / fume incident | Low | High | Fully enclosed area, extraction monitoring, PPE controls |
| Forklift / pedestrian conflict | Medium | High | Painted lanes, mirrors, milk-run discipline, separate visitor entry |
| Equipment delivery delay | Medium | Medium | Phase installation; saws and presses commissioned first |

**Table 12.3: Implementation schedule (high-level)**

| Phase | Duration | Key activities |
|---|---|---|
| Site preparation | 8 weeks | Earthworks, civils, dock construction |
| Building shell | 16 weeks | Foundations, structure, cladding, roof |
| Services rough-in | 6 weeks | Electrical, compressed air, water, fire |
| Equipment install | 10 weeks | Saws → presses → grinders → oven → powder line |
| Commissioning | 4 weeks | Sign-off, operator training, ramp-up trial |
| **Total** | **44 weeks (≈ 10 months)** | |

---

# Appendix C: Workstation Layout Drawings

The thirteen workstation drawings below show a top-down plan view of each production cell, with operator position, WIP-in and WIP-out, machine footprint, safety clearance and the main direction of material flow. Drawings are not to scale; dimensional information is given in Table 8.5 (workstation roll-up).

The figures cover every active station from Table 8.4: tube cutting, internal threading, grip-end forming, knurling + external threading, sheet-metal press, hinge bending, head shaping, riveting, blade sharpening, blade serrating, hand polishing, final assembly, packaging.

**Figure C1: Tube Cutting Workstation.** Three parallel cells (9.0 × 2.0 m each). The automatic saw is fed directly from the 6 m tube rack face; the operator stands on the loading side and transfers cut sections to a back / middle labelled bin. A scrap bin sits at the saw outfeed. Forklift access is from the rack face only; the operator aisle is clear of forklift traffic.

**Figure C2: Internal Threading Workstation.** Two bench cells (3.0 × 2.0 m each). The tapping machine is operated with a reaction arm. A swarf bin sits beside the machine; WIP-in and WIP-out bins are at bench height on either side. Task lighting supplements the overhead light.

**Figure C3: Grip-End Forming Workstation.** Single cell (3.0 × 2.0 m). The tube end former narrows one end of the back-handle section. Two-position loading reduces the operator reach; a guarded forming area protects the operator.

**Figure C4: Knurling and External Threading Bank.** Five thread-rolling machines arranged in a row (8.4 × 4.4 m bank). A full-length inbound buffer protects the bank from starvation (99.7 % utilisation). Elbow-height loading reduces fatigue; coolant/mist extraction runs across the back of the bank.

**Figure C5: Sheet-Metal Press Cell.** Two gap-frame presses sharing one sheet-staging area (6.4 × 4.0 m). Each press has its own blank-out bin (head-blank and hinge-blank). One skeleton-scrap bin is shared. Light curtains guard the operator; a die-change access aisle is provided behind.

**Figure C6: Hinge Bending Workstation.** Single cell (3.4 × 2.5 m). A small electric press brake bends the hinge connector to the riveting geometry. WIP-in is fed directly from the press cell; WIP-out feeds the riveting station.

**Figure C7: Shovel-Head Shaping Workstation.** Single cell (3.0 × 2.0 m). A forming press shapes the stamped shovel head to its final form before sharpening.

**Figure C8: Riveting Workstation.** Single cell (3.7 × 2.6 m). The radial riveting machine joins the bent hinge connector to the shaped shovel head. Two WIP-in bins (head + hinge) sit on either side of the operator; the WIP-out bin holds the assembled head subassembly. Two-hand control protects the operator.

**Figure C9: Blade Sharpening Bank.** Ten pedestal belt grinders in two rows of five (8.4 × 7.4 m bank). Operators face a central WIP lane. Dust extraction runs along the back wall of each row. This is the binding bottleneck (94.7 % utilisation, 3 638 min/day workload).

**Figure C10: Blade Serrating Row.** Five profiled-abrasive stations in-line after sharpening (8.4 × 3.5 m). Each station has its own WIP-in tray; the WIP-out trays feed directly into the polishing row.

**Figure C11: Hand Polishing Row.** Five manual benches with extraction (8.4 × 3.5 m). Operators face the polishing arbor; the WIP-in bin is on the left, the WIP-out bin (clean / deburred) is on the right, in the direction of flow toward the powder-coating line.

**Figure C12: Final Assembly Cell.** Three assembly benches (4.4 × 3.1 m each). Three inbound flows converge: powder-coated handle sections, powder-coated head sub-assemblies, and bagged rivets / hardware. Each bench holds the matching fixtures for handle-to-head clamping.

**Figure C13: Packaging Cell.** Three packing benches (6.6 × 3.0 m each). Bagging is followed by carton-pack; the carton is the final visual-check point. A quarantine bin sits between the benches and the pallet-build position. The packed pallet is moved by hand pallet truck to finished-goods storage.

---

*End of consolidated report.*
