# 8. Detailed Design Specifications

This section converts the design objectives and requirements established in Sections 1–4, the demand and capacity analysis of Section 5, and the process flow of Section 7 into measurable production, storage, capacity, workstation, material-handling and space requirements. These values form the design basis used to develop the alternative block layouts (Section 9) and the final Master Facility Plan (Section 10).

The single source of truth for all numerical calculations in this section is the capacity and space workbook held at `05_Working/5.1_Capacity_Model/417.xlsx`. Where a value in this section differs from the workbook, the workbook is updated to match. The equipment named below is used as a market example for sizing and layout development only. Final equipment selection, costs, service requirements and installation allowances must be confirmed through supplier quotations. Supplier images are used as reference material only; the figures in this report are redrawn as original drawings and the supplier source is acknowledged in the caption.

---

## 8.1 Demand Calculation

The production demand is calculated from the projected annual demand and the available working days per year given in the brief. The facility operates one 9-hour shift per day. After deducting one 30-minute lunch break and two 15-minute tea breaks, 480 productive minutes are available per shift.

$$
\text{Daily shovel production} = \frac{\text{Annual demand}}{\text{Working days per year}} \tag{8.1}
$$

$$
= \frac{400\,000}{220} = 1\,818.18 \approx 1\,819 \text{ shovels/day}
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
| Productive time | 9-hour shift less breaks | 480 min/day |
| Daily production | 400 000 ÷ 220 | 1 819 shovels/day |
| Hourly production | 1 819 ÷ 8 | 228 shovels/hour |
| Takt time | 28 800 s ÷ 1 819 | 15.83 s/shovel |

The daily demand of 1 819 shovels is the master sizing value for the facility. It drives the raw-material stock level, machine count, labour requirement, WIP staging, finished-goods storage and dispatch load. The short takt time of 15.83 s also shows that the design cannot rely on a single machine for any operation longer than the takt: tube cutting, knurling, blade sharpening, blade serrating, polishing, assembly and packaging therefore require parallel stations.

---

## 8.2 Raw-Material Inventory Requirements

The facility must hold two weeks of raw materials in stock. Because the facility operates five days per week, the raw-material inventory basis is ten working days of production:

$$
\text{Two-week production requirement} = 1\,819 \times 10 = 18\,190 \text{ shovels} \tag{8.4}
$$

The following design basis applies (taken from the brief and CLAUDE.md):

- Each shovel uses one back handle section and one middle handle section, both cut from aluminium round tube.
- Each handle section is 150 mm long.
- Each shovel uses one shovel head and one hinge connector, both stamped from 2.5 mm aluminium sheet or coil.
- The 5 % scrap allowance applies **only** to tube cutting and sheet stamping.
- Packaging bags, rivets and carton boxes are bought-in components and are not part of the scrap calculation.

### 8.2.1 Aluminium Round Tube Requirement

Each shovel needs two handle sections (one back, one middle), so the good output requirement is:

$$
\text{Good handle sections/day} = 1\,819 \times 2 = 3\,638 \text{ sections/day} \tag{8.5}
$$

With a 5 % cutting scrap allowance, the input quantity is:

$$
\text{Input handle sections/day} = \frac{3\,638}{0.95} = 3\,829.47 \approx 3\,830 \text{ sections/day} \tag{8.6}
$$

The theoretical yield from one 6 m tube, ignoring kerf, is:

$$
\text{Sections per 6 m tube} = \frac{6\,000}{150} = 40 \text{ sections/tube} \tag{8.7}
$$

$$
\text{Daily 6 m tubes required} = \frac{3\,830}{40} = 95.75 \approx 96 \text{ tubes/day} \tag{8.8}
$$

$$
\text{Two-week tube stock} = 96 \times 10 = 960 \text{ tubes} \tag{8.9}
$$

A practical saw-kerf allowance of 2 mm reduces the usable yield from 40 to 39 sections per tube. Adopting that allowance lifts the two-week stock to approximately 990 tubes. The cantilever rack area is therefore sized against the conservative figure of 990 tubes so that the design is not changed if kerf is later confirmed.

**Figure 8.1: Cutting yield from one 6 m aluminium tube**
*[Original drawing — to be inserted from `05_Working/5.4_MFP_and_Layouts/`. Caption to show a 6 000 mm tube divided into 40 × 150 mm sections, with a note that practical saw kerf reduces the yield to 39 sections.]*
Reference for the tube-cutting saw used as the market example: ProfiFeedTech A420 (https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/).

### 8.2.2 Aluminium Sheet or Coil Requirement

Each shovel requires one shovel head and one hinge connector. Both are stamped from 2.5 mm aluminium sheet or coil, and both attract the 5 % scrap allowance:

$$
\text{Stamped shovel heads/day} = \frac{1\,819}{0.95} = 1\,914.74 \approx 1\,915 \text{ heads/day} \tag{8.10}
$$

$$
\text{Stamped hinge connectors/day} = \frac{1\,819}{0.95} = 1\,914.74 \approx 1\,915 \text{ connectors/day} \tag{8.11}
$$

The finished shovel head is 150 mm × 120 mm:

$$
A_{\text{head}} = 0.150 \times 0.120 = 0.018 \text{ m}^2 \tag{8.12}
$$

$$
\text{Two-week shovel-head sheet area} = 1\,915 \times 10 \times 0.018 = 344.70 \text{ m}^2 \tag{8.13}
$$

The brief does not specify the hinge connector blank size. For sizing purposes a designer assumption is adopted of a 100 mm × 120 mm flat blank (i.e. before bending):

$$
A_{\text{hinge blank}} = 0.100 \times 0.120 = 0.012 \text{ m}^2 \tag{8.14}
$$

$$
\text{Two-week hinge-connector sheet area} = 1\,915 \times 10 \times 0.012 = 229.80 \text{ m}^2 \tag{8.15}
$$

The combined two-week sheet area is therefore $344.70 + 229.80 = 574.50 \text{ m}^2$. Assuming standard 2 500 mm × 1 250 mm aluminium sheets (3.125 m² each), this is approximately **184 sheets** for two weeks, or **18 sheets/day**. The actual sheet count must be re-derived once the supplier sheet size and nesting layout are confirmed; the nesting efficiency of the press die will lower the usable area per sheet to roughly 70 %–80 %, raising the requirement to about 230–260 sheets per two-week cycle.

**Figure 8.2: Sheet-metal blanking concept for shovel head and hinge connector**
*[Original drawing — a rectangular 2.5 mm aluminium sheet with nested shovel-head blanks (150 × 120 mm) and hinge-connector blanks (100 × 120 mm), with the skeleton scrap shown. The figure labels the blanks and notes that stamping scrap is allowed only at this stage.]*
Reference for the stamping press used as the market example: Stamtec OCP gap-frame press (https://www.stamtec.com/presses/mechanical-presses/1-point-gap-frame-press/ocp-series-gap-frame-press).

**Table 8.2: Raw-material inventory requirement**

| Raw material / component | Daily requirement | Two-week requirement | Basis | Layout implication |
|---|---:|---:|---|---|
| Aluminium round tube, 6 m | 96 tubes | 960–990 tubes | Two handle sections per shovel, adjusted for cutting scrap and a kerf allowance | Long-material storage close to cutting |
| Shovel head blanks | 1 915 blanks | 19 150 blanks | One head per shovel, adjusted for stamping scrap | Sheet/coil storage close to stamping |
| Hinge connector blanks | 1 915 blanks | 19 150 blanks | One connector per shovel, adjusted for stamping scrap | Same as above |
| Aluminium sheet (combined) | ≈ 18 sheets | ≈ 184 sheets (≈ 230–260 with nesting loss) | Two-week head + hinge area ÷ standard sheet area | Sheet rack within forklift reach of presses |
| Packaging bags | 1 819 bags | 18 190 bags | One bag per shovel | Store close to packaging |
| Rivets | 1 819 (single) or 3 638 (double) | 18 190 or 36 380 | One or two rivets per shovel — to be confirmed in joint-design review | Small-parts shelving near riveting |
| Carton boxes | 182 cartons | 1 819 cartons | Ten shovels per carton — designer assumption | Flat-pack storage near packaging and dispatch |

The raw-material calculations show that the facility needs three distinct storage approaches: long-material storage for tubes, palletised or coil storage for flat aluminium, and small-component shelving for bought-in items. Tube cutting and sheet stamping should therefore be positioned close to raw-material storage to reduce repeated long-distance movement of heavy aluminium stock.

---

## 8.3 Raw-Material Receiving, Storage and Handling

For the base design, aluminium tubes are assumed to be delivered in strapped 6 m bundles. Sheet material is assumed to be delivered as palletised sheet packs unless a coil-fed press is selected, in which case coil cradles are required. Bought-in components are delivered in cartons or flat-packed bundles.

**Table 8.3: Raw-material delivery and storage basis**

| Material / component | Delivery assumption | Storage method | Handling method | Layout implication |
|---|---|---|---|---|
| Aluminium round tubes | Strapped 6 m tube bundles | Cantilever or long-material racks | Forklift for bundles; tube trolley for daily issue | Place adjacent to receiving and tube cutting |
| Aluminium sheet packs | Palletised packs or skids | Sheet rack or pallet rack | Forklift or pallet jack | Place adjacent to stamping |
| Aluminium coils (alt.) | Coil pallet / cradle | Coil cradle or coil rack | Forklift with coil attachment | Protected coil staging near press |
| Packaging bags | Cartons | Shelving | Manual trolley | Place near packaging |
| Rivets | Small cartons or bins | Small-parts shelving | Manual handling | Place near riveting |
| Carton boxes | Flat-packed bundles or pallets | Shelving or pallet position | Manual trolley or pallet jack | Place near packaging and dispatch |

**Figure 8.3: Raw-material receiving and storage concept**
*[Original block-flow diagram showing: supplier truck → receiving bay → incoming inspection → (tube cantilever racks ∥ sheet rack ∥ small-parts shelving) → (tube cutting ∥ sheet stamping ∥ assembly & packaging).]*
References: cantilever racks (https://www.krostshelving.com/warehouse-storage-solutions/industrial-racking-systems/cantilever-racking/) and sheet-metal storage racks (https://www.leanmanufacturingproducts.com/our-products/sheet-metal-storage-racks).

**Figure 8.4: Electric counterbalance forklift used for raw-material and finished-goods handling**
*[Simplified original icon to be used throughout the layout drawings.]*
Reference: Toyota Material Handling South Africa (https://www.toyotaforklift.co.za/).

### 8.3.1 Raw-Material Storage Area

The tube stock is stored on cantilever racks because the tubes are 6 m long. Sheet packs are stored on pallet positions until the final stamping equipment confirms whether sheet-fed or coil-fed material is used.

**Table 8.4: Preliminary raw-material storage basis**

| Storage element | Design basis | Layout allowance |
|---|---|---:|
| Tube cantilever rack bay | 6 m rack face with 1.5 m arm allowance | 6.0 m × 1.5 m per bay |
| Forklift aisle | Straight aisle for 6 m stock handling | 3.5 m wide |
| Sheet pack storage | Palletised sheet packs or sheet rack | 1.2 m × 1.0 m per pallet position |
| Bought-in component shelving | Bags, rivets, cartons | 2.0 m × 1.0 m per shelving zone |
| Daily issue trolley parking | Tube cart or small-parts trolley | 1.5 m × 1.2 m per trolley |

**Table 8.5: Raw-material storage summary**

| Storage element | Quantity | Unit area (m²) | Subtotal (m²) |
|---|---:|---:|---:|
| Tube cantilever rack bays (12 bays @ 9.0 m²) | 12 | 9.0 | 108.0 |
| Sheet pallet positions (3 @ 1.2 m²) | 3 | 1.2 | 3.6 |
| Forklift aisles (≈ 42 m²) | — | — | 42.0 |
| Subtotal | | | **153.6** |
| Handling allowance (20 % for movement, labelling and trolley parking) | | | 30.7 |
| **Total raw-material storage area** | | | **≈ 185 m²** |

The raw-material storage area must be placed adjacent to receiving, tube cutting and sheet stamping. The 6 m tube length controls the aisle layout because the handling equipment must move long stock without crossing pedestrian routes.

**Figure 8.5: Tube bundle and cantilever rack storage concept**
*[Original drawing of a tube bundle (front view) and cantilever rack (side view), showing a 3.5 m forklift aisle and a 6 m rack face.]*
Reference: https://www.krostshelving.com/warehouse-storage-solutions/industrial-racking-systems/cantilever-racking/

---

## 8.4 Manufacturing Capacity Requirements

The number of machines, workstations or operators is calculated by dividing the daily processing load by the available productive time per shift. The base calculation uses 480 productive minutes per day:

$$
\text{Number required} = \frac{\text{Daily quantity processed} \times \text{Processing time per unit}}{480} \tag{8.16}
$$

Processing times stated in seconds are converted to minutes. The processing times below are taken from the brief Table 1 (locked in CLAUDE.md). Where the brief flags an operation as equipment-dependent, no value is forced.

**Table 8.6: Base manufacturing capacity requirements (fixed-time operations)**

| Stream | Process | Time/unit (s) | Time/unit (min) | Daily quantity | Total time (min/day) | Stations required | Utilisation |
|---|---|---:|---:|---:|---:|---:|---:|
| Handle | Tube cutting | 15 | 0.250 | 3 830 | 957.5 | 2 | 99.7 % |
| Handle | Internal threading (middle) | 20 | 0.333 | 1 915 | 638.3 | 2 | 66.5 % |
| Handle | Grip-end forming (back) | 5 | 0.083 | 1 915 | 159.6 | 1 | 33.2 % |
| Handle | Knurling + external threading (back) — single combined op | 60 | 1.000 | 1 915 | 1 915.0 | 4 | 99.7 % |
| Sheet | Hinge connector stamping | 2 | 0.033 | 1 915 | 63.8 | 1 | 13.3 % |
| Sheet | Hinge connector bending | 5 | 0.083 | 1 819 | 151.6 | 1 | 31.6 % |
| Sheet | Shovel-head stamping | 2 | 0.033 | 1 915 | 63.8 | 1 | 13.3 % |
| Sheet | Shovel-head shaping | 2 | 0.033 | 1 819 | 60.6 | 1 | 12.6 % |
| Sheet | Blade sharpening | 120 | 2.000 | 1 819 | 3 638.0 | 8 | 94.7 % |
| Sheet | Blade serrating | 60 | 1.000 | 1 819 | 1 819.0 | 4 | 94.7 % |
| Sub-assy | Riveting hinge → head | 5 | 0.083 | 1 819 | 151.6 | 1 | 31.6 % |
| Finishing | Hand polishing / deburring | 60 | 1.000 | 1 819 | 1 819.0 | 4 | 94.7 % |
| Final | Final assembly | 30 | 0.500 | 1 819 | 909.5 | 2 | 94.7 % |
| Final | Packaging + final visual check | 30 | 0.500 | 1 819 | 909.5 | 2 | 94.7 % |
| | **Subtotal** | | | | **13 256.8** | **34** | |

The 30 s per shovel allowance for packaging is a designer assumption based on a manual bagging-and-cartoning cycle that includes the final visual inspection step required by the brief. It must be re-confirmed once the packaging workstation layout is finalised.

The results show that tube cutting, the knurling/external-threading bank, sharpening, serrating, polishing, assembly and packaging operate above 94 % utilisation. These processes need controlled WIP, short material travel distances and direct line feeding so that operators do not leave their station to fetch material. Sharpening is the largest single workload driver at 3 638 min/day and is treated as the bottleneck bank in the layout.

**Table 8.7: Equipment-dependent process basis**

| Process | Required equipment data to finalise | Current design action |
|---|---|---|
| Heat treatment | Batch size, cycle time, load / unload time | Provisional area allowance only; finalise after oven selection |
| Sandblasting | Parts per hour or batch cycle time | Provisional area allowance only; finalise after blast equipment selection |
| Powder coating | Booth capacity, conveyor speed, hanger density, cure time | Reserve fully enclosed area; finalise after coating line selection |
| Packaging | Manual cycle time, bagging method, cartons / pallet, inspection method | Confirm during workstation design |

Equipment-dependent processes are deliberately not assigned a fabricated cycle time. Their space allowance is reserved on the layout and updated when the supplier specification is locked in.

---

## 8.5 Manufacturing Process and Workstation Design

Each workstation below converts the capacity requirement into a physical design basis. The workstation layouts show the machine footprint, operator position, WIP before and after, local handling, safety clearance and main flow direction. Detailed workstation drawings are held in `05_Working/5.4_MFP_and_Layouts/` and are reproduced as appendix figures in the final report.

### 8.5.1 Tube Cutting Workstation

Tube cutting is the first operation in the handle stream. Aluminium round tubes are cut into 150 mm handle sections for the back and middle handles. The process attracts the 5 % cutting scrap and must produce 3 830 input sections per day.

**Table 8.8: Tube cutting workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Automatic aluminium saw with 6 m bar feed |
| Market example | ProfiFeed A420 automatic aluminium saw |
| Machines / operators | 2 / 2 |
| Cell size per saw | 9.0 m × 2.0 m |
| Area per saw | 18.0 m² |
| Total cutting area | 36.0 m² |
| WIP before | Tube rack face / 6 m bar feed |
| WIP after | Labelled section bins or tube carts (back ∥ middle) |
| Scrap handling | Aluminium scrap bin at saw outfeed |
| Main handling | Forklift for tube bundles; tube cart for cut sections |
| Safety | Guarded blade, clear loading side, no pedestrian crossing at the infeed |

**Figure 8.6: Automatic aluminium saw with 6 m bar feed (market example)**
*[Original drawing — supplier image used as reference only.]*
Reference: https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/

**Figure 8.7: Tube cutting workstation layout**
*[Original 2D plan — two mirrored 9.0 m × 2.0 m cells. Shows the 6 m tube rack / infeed face, automatic saw, 0.9 m operator aisle, WIP section bins (back ∥ middle), scrap bin and flow arrows.]*

**Layout implication.** Tube cutting must be placed against the raw-material storage area so that the 6 m tubes do not have to be turned, lifted twice or carried across pedestrian routes. The rack face and saw infeed face should be aligned.

### 8.5.2 Internal Threading Workstation

The internal threading operation cuts the internal thread on the middle handle section. Two threading stations are required to absorb the 638 min/day load.

**Table 8.9: Internal threading workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Torque-limited electric tapping machine |
| Market example | Roscamat Tiger electric tapping machine |
| Machines / operators | 2 / 2 |
| Cell size per station | 3.0 m × 2.0 m |
| Area per station | 6.0 m² |
| Total area | 12.0 m² |
| WIP before / after | Bench-height bins on both sides |
| Safety / ergonomics | Reaction-arm fixture; swarf bin; task lighting |

**Figure 8.8: Electric tapping machine for internal threading (market example)**
Reference: https://www.cotswold-machinery-sales.co.uk/roscamat-tapping-machines/electric-tapping-machines/roscamat-tiger-electric-tapping-machine/

**Figure 8.9: Internal threading workstation layout**
*[Original 2D plan — 3.0 m × 2.0 m bench cell with WIP-in bin, tapping machine, operator position, swarf bin, WIP-out bin and flow arrow.]*

### 8.5.3 Grip-End Forming Workstation

The grip-end forming operation narrows one end of the back handle section in preparation for knurling and external threading. One station is sufficient.

**Table 8.10: Grip-end forming workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Tube end-forming / swaging machine |
| Market example | Hippo tube end former class |
| Machines / operators | 1 / 1 |
| Cell size | 3.0 m × 2.0 m |
| Area | 6.0 m² |
| WIP before / after | Small tube bins or trolleys |
| Safety / ergonomics | Two-position loading; guarded forming area |

**Figure 8.10: Tube end-forming machine (market example)**
Reference: https://www.hippobender.com/tube-end-former/

**Figure 8.11: Grip-end forming workstation layout**
*[Original 2D plan — 3.0 m × 2.0 m cell with WIP-in, tube end former, operator position and WIP-out feeding the knurling bank.]*

### 8.5.4 Knurling and External Threading Bank

This is a **single combined operation** that simultaneously knurls the grip and rolls the external thread on the back handle. The brief gives a cycle time of 1 min/pipe. Four machines are required and the bank runs at 99.7 % utilisation, so it must be protected by an inbound buffer.

**Table 8.11: Knurling and external threading specifications**

| Item | Specification |
|---|---|
| Equipment class | Two-roll thread / profile rolling machine |
| Market example | Profimach PTR-42 two-roll thread roll machine |
| Machines / operators | 4 / 4 |
| Bank size | 8.4 m × 3.4 m |
| Area | 28.6 m² |
| WIP before | Full-length inbound buffer strip |
| WIP after | Outbound buffer strip |
| Safety / ergonomics | Elbow-height loading, coolant/mist control, maintenance clearance |

**Figure 8.12: Two-roll thread / profile rolling machine (market example)**
Reference: https://profimach.com/special-machine/2-roll-thread-roll-machines-ptr-series

**Figure 8.13: Knurling and external-threading bank layout**
*[Original 2D plan — four machines in a row, WIP-in buffer, operator aisle, WIP-out buffer and flow arrows.]*

### 8.5.5 Sheet-Metal Press Cell

The press cell stamps shovel-head blanks (150 × 120 mm) and hinge-connector blanks (100 × 120 mm) from 2.5 mm aluminium. Although the per-piece cycle time is only 2 s, two presses are kept in the design so that one die change does not stop both blanks. The cell includes sheet staging, blank bins and a skeleton-scrap bin.

**Table 8.12: Sheet-metal press cell specifications**

| Item | Specification |
|---|---|
| Equipment class | Gap-frame mechanical press with progression die |
| Market example | Stamtec OCP-series gap-frame press |
| Machines / operators | 2 / 2 |
| Cell size | 6.4 m × 4.0 m |
| Area | 25.6 m² |
| WIP before | Sheet packs or coil staging |
| WIP after | Head-blank bins and hinge-blank bins |
| Scrap | Skeleton scrap bin |
| Safety | Light curtains or fixed guards; die-change access |

**Figure 8.14: Gap-frame mechanical press (market example)**
Reference: https://www.stamtec.com/presses/mechanical-presses/1-point-gap-frame-press/ocp-series-gap-frame-press

**Figure 8.15: Sheet-metal press cell layout**
*[Original 2D plan — two presses sharing one sheet staging area, two blank-out bins and one skeleton-scrap bin.]*

### 8.5.6 Hinge Bending and Shovel-Head Shaping

The hinge connector is bent to form the hinge geometry, and the shovel head is shaped to its final form. Both operations stay close to the press cell to keep sheet-metal flow compact.

**Table 8.13: Hinge bending and head shaping specifications**

| Process | Equipment class | Stations | Area allowance (m²) | Layout note |
|---|---|---:|---:|---|
| Hinge bending | Small electric press brake | 1 | 8.5 | Place immediately after hinge stamping |
| Shovel-head shaping | Forming press / bending fixture | 1 | 6.0 | Place after head stamping, before sharpening |
| **Subtotal** | | **2** | **14.5** | |

**Figure 8.16: Electric press brake for hinge bending (market example)**
Reference: https://www.cotswold-machinery-sales.co.uk/euromac-bending-machines/electric-press-brakes/fx-bend-850/

**Figure 8.17: Hinge bending and head shaping workstation layout**
*[Original 2D plan — two adjacent cells, both fed from the press cell.]*

### 8.5.7 Blade Sharpening Bank

Blade sharpening is the largest single workload driver. Eight stations are required and they are arranged in two rows of four around a central WIP lane.

**Table 8.14: Blade sharpening bank specifications**

| Item | Specification |
|---|---|
| Equipment class | Pedestal abrasive belt grinder with extraction |
| Market example | Fein GRIT GI75 abrasive belt grinder |
| Machines / operators | 8 / 8 |
| Bank size | 8.4 m × 6.2 m |
| Area | 52.1 m² |
| WIP before | Central WIP lane |
| WIP after | Trolley or bin transfer to serrating |
| Safety | Eye protection, hearing protection, dust extraction, lock-out for belt changes |

**Figure 8.18: Abrasive belt grinder (market example)**
Reference: https://www.echopkins.com/shop/fabrication/large-abrasive-machines/belt-grinders/pedestal/fein-gi75-abrasive-belt-grinder/

**Figure 8.19: Blade sharpening bank layout**
*[Original 2D plan — two rows of four grinders facing a central WIP lane. Shows the rear dust-extraction line, operator positions and flow direction.]*

**Layout implication.** Sharpening is the binding constraint of the facility. It must be fed by a controlled WIP lane and must not require operators to fetch material from another area.

### 8.5.8 Blade Serrating and Hand Polishing

Blade serrating runs immediately after sharpening; hand polishing / deburring prepares the head subassembly for the finishing route. Both have high utilisation and stay close to sharpening and to the coating route.

**Table 8.15: Serrating and polishing specifications**

| Process | Workstation class | Stations | Area allowance (m²) | Layout note |
|---|---|---:|---:|---|
| Blade serrating | Profiled abrasive / serrating station with extraction | 4 | 26.9 | In-line after sharpening |
| Hand polishing / deburring | Manual benches with extraction | 4 | 26.0 | Before coating route |
| **Subtotal** | | **8** | **52.9** | |

**Figure 8.20: Serrating station reference (hydraulic notching machine class)**
Reference: https://www.cotswold-machinery-sales.co.uk/euromac-bending-machines/notching-machines/va-multi-220-6r-notching-machine/

**Figure 8.21: Serrating and polishing row layout**
*[Original 2D plan — serrating stations in sequence after sharpening, followed by polishing benches with WIP-in and WIP-out bins.]*

### 8.5.9 Riveting Workstation

Riveting joins the hinge connector to the shovel head, which is the convergence point of the two sheet-metal sub-streams.

**Table 8.16: Riveting workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Pneumatic radial riveting machine |
| Market example | AGME radial riveting machine |
| Machines / operators | 1 / 1 |
| Cell size | 3.7 m × 2.6 m |
| Area | 9.6 m² |
| WIP before | Matched head and hinge connector buffers |
| WIP after | Head sub-assembly bin or trolley |
| Safety | Two-hand control, task lighting, compressed-air drop |

**Figure 8.22: Radial riveting machine (market example)**
Reference: https://www.agme.net/en/riveting-machines/radial-riveting-machines

**Figure 8.23: Riveting workstation layout**
*[Original 2D plan — WIP-in for heads, WIP-in for hinges, rivet shelf, riveter, operator position, WIP-out for head sub-assemblies.]*

### 8.5.10 Heat Treatment Area

Heat treatment is equipment-dependent. The provisional area allowance covers the oven, inbound buffer, cooling space and outbound buffer.

**Table 8.17: Heat treatment area specifications**

| Item | Specification |
|---|---|
| Equipment class | Aluminium ageing batch oven |
| Market example | Wisconsin Oven aluminium age oven |
| Area allowance | 80 m² zone (oven plus buffers) |
| WIP basis | One-day buffer before and after the oven |
| Safety | Thermal clearance, hot-part handling, PPE, ventilation |

**Figure 8.24: Aluminium ageing batch oven (market example)**
Reference: https://www.wisoven.com/products/batch-ovens/aluminum-age-ovens

**Figure 8.25: Heat treatment area layout**
*[Original 2D plan — oven, loading area, WIP-before pallets, cooling area, WIP-after pallets and pallet-truck access.]*

### 8.5.11 Sandblasting Area

Sandblasting prepares the surface of the head sub-assembly for finishing. It must be enclosed and connected to dust and media recovery.

**Table 8.18: Sandblasting area specifications**

| Item | Specification |
|---|---|
| Equipment class | Enclosed blast booth or blast room |
| Market example | Airblast AFC blast rooms |
| Area allowance | 6.4 m × 5.0 m = 32.0 m² |
| WIP before / after | Racked subassemblies |
| Safety | Dust collection, PPE, controlled entry, sealed waste drums |

**Figure 8.26: Enclosed sandblasting booth / blast room (market example)**
Reference: https://airblastafc.com/blast-solutions/blast-rooms/

**Figure 8.27: Sandblasting area layout**
*[Original 2D plan — blast booth, media recovery, dust collector, WIP-in rack, WIP-out rack, sealed waste drums.]*

### 8.5.12 Powder Coating Enclosure

Powder coating is mandated by the brief to be located in a **fully enclosed area**. The line coats the handle sections and the head sub-assembly before final assembly.

**Table 8.19: Powder coating enclosure specifications**

| Item | Specification |
|---|---|
| Equipment class | Conveyorised powder-coating line |
| Market example | P.I. Marketing powder-coating system |
| Enclosure size | 15.0 m × 8.0 m = 120 m² |
| Layout elements | Hang/load, booth, cure oven, cooling leg, unload |
| Safety | Fully enclosed area, extraction, make-up air, controlled entry / exit |

**Figure 8.28: Conveyorised powder-coating line (market example)**
Reference: https://www.pimarketing.co.za/

**Figure 8.29: Fully enclosed powder-coating workstation layout**
*[Original 2D plan — 15.0 m × 8.0 m enclosure with loading point, booth, oven, cooling path, unload point, airlock and extraction unit.]*

### 8.5.13 Final Assembly and Packaging

Final assembly is where the handle stream and the coated head sub-assembly converge. Packaging is performed manually and also serves as the final visual check before finished goods are transferred to storage.

**Table 8.20: Final assembly and packaging specifications**

| Area | Specification |
|---|---|
| Assembly equipment | Manual benches with holding fixtures |
| Assembly stations / operators | 2 / 2 |
| Assembly area | 13.6 m² |
| Packaging equipment | Manual packing benches, bag and carton storage, pallet-build position |
| Packaging stations / operators | 2 / 2 |
| Packaging area | 19.8 m² (drawn); 18.0 m² (planning allowance) |
| Quality control | Final visual check, quarantine bin |
| Handling | Hand pallet truck to finished-goods storage |

**Figure 8.30: Final assembly bench reference**
Reference: https://www.uline.com/Cls_05/Workbenches-and-Packing-Tables

**Figure 8.31: Hand pallet truck (market example)**
Reference: https://www.adendorff.co.za/mac-afric-2-ton-pallet-truck-685-x-1220-mm-gpallt000

**Figure 8.32: Final assembly and manual packaging layout**
*[Original 2D plan — two assembly benches followed by two packaging benches, with three inbound part flows, bag/carton shelving, final visual check, quarantine bin and pallet-build area.]*

### 8.5.14 Workstation Space Roll-Up

The bottom-up workstation total used in §8.10 is built up from the cell sizes above:

**Table 8.21: Workstation space roll-up (excludes finishing zone and storage)**

| Workstation / bank | Stations | Area (m²) |
|---|---:|---:|
| Tube cutting | 2 | 36.0 |
| Internal threading | 2 | 12.0 |
| Grip-end forming | 1 | 6.0 |
| Knurling + external threading bank | 4 | 28.6 |
| Sheet-metal press cell | 2 | 25.6 |
| Hinge bending + head shaping | 2 | 14.5 |
| Blade sharpening bank | 8 | 52.1 |
| Blade serrating + hand polishing | 8 | 52.9 |
| Riveting | 1 | 9.6 |
| Final assembly + packaging | 4 | 31.6 |
| **Workstation subtotal (bottom-up)** | **34** | **268.9** |
| Local WIP, operator clearance and intra-cell aisles (≈ 55 %) | | 148.1 |
| **Production workstation area (rounded)** | | **≈ 420 m²** |

The 268.9 m² figure is the pure machine and bench footprint. The 55 % uplift to 420 m² is consistent with Stephens & Meyers' allowance for operator working space, local WIP, intra-cell aisles and maintenance access in a one-shift mixed-process facility and is the value carried forward into Table 8.27.

---

## 8.6 Labour Requirement

The labour requirement is built up from the active station count in Table 8.6, plus the equipment-dependent crew, plus the material-handling and quality support roles required by the brief. Office headcount is sized separately in §8.10.

**Table 8.22: Labour planning summary**

| Labour group | Basis | Estimated operators |
|---|---|---:|
| Fixed-time manufacturing stations (Table 8.6) | One operator per active station | 34 |
| Heat treatment crew | One operator per shift (loading, oven supervision) | 1 |
| Sandblasting crew | One operator per shift inside the booth area | 1 |
| Powder coating crew | Two operators (hang/load + unload) | 2 |
| Forklift / material-handling operators | Receiving, storage, dispatch, milk-run support | 2 |
| Quality / final inspection support | Embedded in packaging unless separated | 0 (embedded) |
| **Production headcount** | | **40** |

Adding the office headcount derived in §8.10 (≈ 20 management, administration and supervisory staff) gives a total facility headcount of approximately **60**, which matches the figure carried in the capacity workbook. High-utilisation stations (sharpening, knurling, polishing, assembly, packaging) must not rely on operators leaving the workstation to collect material — short interruptions at 94 %–99 % utilisation cause the station to miss the daily target.

---

## 8.7 Work-in-Progress Staging

WIP storage is provided only where the process flow needs temporary staging between operations. The purpose is to protect flow between processes with different cycle times, batch behaviour or safety separation, not to create excess inventory.

**Table 8.23: WIP staging basis**

| WIP location | Reason for staging | Recommended container |
|---|---|---|
| After tube cutting | Separates back and middle handle sections | Labelled section bins or tube trolleys |
| After internal threading and grip forming | Holds completed handle sections before coating or assembly | Small-part bins or carts |
| After sheet stamping | Separates shovel heads and hinge connectors | Flat trays or labelled bins |
| Before sharpening | Prevents starvation at the bottleneck bank | Central WIP lane / bins |
| Before heat treatment | Allows batch loading | Heat-resistant trays or racks |
| Before sandblasting | Controls feed into the enclosed blast equipment | Bins or racks |
| Before powder coating | Controls movement into the enclosed coating area | Hanging racks or coating carts |
| After final assembly | Stages completed shovels before manual packaging | Packing trolleys or bins |

**Table 8.24: WIP container requirement**

| Part type | Daily volume | Containers required |
|---|---:|---:|
| Cut handle sections | 0.56 m³ | 4 |
| Stamped shovel heads | 0.16 m³ | 1 |
| Stamped hinge connectors | 0.04 m³ | 1 |
| Head sub-assemblies before finishing | 0.98 m³ | 6 |
| **Total** | | **12 containers** |

For block-layout planning, **12 m² is allocated to distributed WIP staging**. This is more practical than using only the theoretical container footprint, because real WIP areas must include access, labelling, trolley movement and separation between part types.

**Figure 8.33: WIP container and trolley concept**
*[Original drawing — labelled bins / trolleys for cut sections, stamped parts and assembled shovels.]*
Reference for industrial carts: https://www.multitube.com/en/systems/heavy-duty

---

## 8.8 Finished-Goods Storage

Finished-goods storage must hold four weeks of completed shovels. With five working days per week, the basis is twenty working days:

$$
\text{Finished-goods stock} = 1\,819 \times 20 = 36\,380 \text{ shovels} \tag{8.17}
$$

For planning purposes a designer assumption is adopted of ten shovels per carton:

$$
\text{Cartons required} = \frac{36\,380}{10} = 3\,638 \text{ cartons} \tag{8.18}
$$

If one pallet holds 240 shovels (24 cartons):

$$
\text{Pallets required} = \frac{36\,380}{240} = 151.58 \approx 152 \text{ pallets} \tag{8.19}
$$

If pallets are stored three levels high in selective racking:

$$
\text{Floor positions} = \frac{152}{3} = 50.67 \approx 51 \text{ pallet positions} \tag{8.20}
$$

$$
\text{Net pallet footprint} = 51 \times 1.2 = 61.2 \text{ m}^2 \tag{8.21}
$$

A 40 % allowance is added for access aisles, order picking and dispatch movement:

$$
\text{Finished-goods storage area} = 61.2 \times 1.40 = 85.68 \approx 86 \text{ m}^2 \tag{8.22}
$$

**Table 8.25: Finished-goods storage basis**

| Item | Value |
|---|---:|
| Finished-goods stock | 36 380 shovels |
| Cartons required | 3 638 cartons |
| Pallets required | 152 pallets |
| Floor pallet positions | 51 positions |
| Storage area including access | 86 m² |

Finished-goods storage must be placed against dispatch so that completed product does not move back through production. Customer collection of small orders must be controlled separately from production and forklift movement, in line with the brief.

**Figure 8.34: Finished-goods racking and dispatch storage concept**
*[Original drawing — pallet racking, FIFO flow arrows, dispatch staging and customer collection point.]*
Reference: https://www.krostshelving.com/warehouse-storage-solutions-industrial-racking-systems/selective-pallet-racking/

---

## 8.9 Receiving, Dispatch and Material Handling

The receiving and dispatch design must support supplier deliveries, customer collections and large-order dispatch. Receiving and dispatch are placed so that external vehicle movement does not interfere with internal production movement.

**Table 8.26: Material-handling equipment basis**

| Equipment | Main use | Quantity | Layout requirement |
|---|---|---:|---|
| Electric counterbalance forklift | Tube bundles, sheet packs, finished-goods pallets | 2 | Forklift aisles + charging / parking bay |
| Tube trolley | Daily issue of tube sections | As required | Between raw storage and cutting |
| Small-parts trolley | Rivets, packaging bags, small components | As required | Near assembly and packaging |
| Pallet jack | Cartons and light palletised items | 1–2 | Near packaging and dispatch |
| WIP containers / bins | Cut parts and stamped parts | 12 (minimum) | Distributed at the WIP points of Table 8.23 |

**Table 8.27: Receiving and dispatch area basis**

| Area | Basis | Space allowance (m²) |
|---|---|---:|
| Receiving dock / unloading staging | Supplier deliveries and incoming inspection | 24 |
| Dispatch dock / loading staging | Finished-goods loading | 24 |
| Customer collection point | Small orders, controlled access | 15 |
| Dispatch staging | Orders waiting for loading or collection | 20 |
| **Total internal receiving and dispatch area** | | **83** |

The final site layout must also provide external truck manoeuvring space and parking for DigMore's delivery fleet. These areas are shown outside the building footprint in the Master Facility Plan (Section 10).

**Figure 8.35: Receiving and dispatch dock interface**
*[Original drawing — receiving dock, dispatch dock, truck approach, customer collection point, dispatch staging and forklift route. Customer movement is kept separate from forklift movement.]*
Reference: dock equipment https://www.maxiflex.co.za/ ; forklift symbol https://www.dimensions.com/element/forklift .

---

## 8.10 Production and Support Space Summary

The production area is developed from the workstation-level requirements above. The area includes machines, workbenches, operators, local material staging and internal movement. The equipment-dependent areas are reserved at provisional values and updated after final machine selection.

The office area is sized from the occupants listed in the brief:

**Table 8.28: Office area derivation**

| Role | Workspace | Area (m²) |
|---|---|---:|
| Senior Plant Manager | Private office, 12 m² | 12 |
| Operations Manager | Private office, 12 m² | 12 |
| Inventory Manager | Private office, 10 m² | 10 |
| Reception | Reception desk + waiting area | 18 |
| Purchasing, Sales, Finance, Marketing, HR | Open-plan, 6 desks × 5.5 m² | 33 |
| Production supervisors (2) | Shared desk space | 12 |
| Meeting room / file storage | Boardroom + records | 18 |
| Office circulation (12 %) | | 13 |
| **Total office area** | | **≈ 128 m²** |

The amenities area is sized from the production headcount and the brief:

**Table 8.29: Amenities derivation**

| Element | Basis | Area (m²) |
|---|---|---:|
| Male restroom + change | 60 % of 40 ops + lockers | 30 |
| Female restroom + change | 40 % of 40 ops + lockers | 25 |
| Accessible WC | 1 unit | 6 |
| Office restrooms | Male + female | 12 |
| Cafeteria (seating + servery) | 40 seats × 1.4 m² + servery | 60 |
| Cleaning / janitorial | | 7 |
| **Total amenities area** | | **≈ 140 m²** |

The internal building area is then assembled in Table 8.30. Future expansion is kept as a separate, visibly-reserved strip on the Master Facility Plan and is not used to absorb shortfalls elsewhere.

**Table 8.30: Corrected internal building space summary**

| Area category | Space required (m²) | Basis |
|---|---:|---|
| Raw-material storage | 185 | Cantilever racks, sheet storage, forklift aisles (Table 8.5) |
| Distributed WIP staging | 12 | Container and trolley staging (Table 8.24) |
| Production workstations | 420 | Bottom-up roll-up from §8.5.14 (Table 8.21) |
| Heat treatment, sandblasting, powder coating | 232 | 80 + 32 + 120 (Tables 8.17 – 8.19) |
| Finished-goods storage | 86 | Four-week palletised storage (Table 8.25) |
| Receiving and dispatch, internal | 83 | Table 8.27 |
| Offices and administration | 128 | Table 8.28 |
| Amenities | 140 | Table 8.29 |
| Utilities, maintenance, plant support | 80 | Electrical, compressor, maintenance, support services |
| Scrap and waste handling | 15 | Tube and sheet stamping scrap |
| **Functional subtotal** | **1 381** | Rounded planning basis |
| Circulation and internal movement allowance | **414** | 30 % planning allowance |
| Future expansion reserve | **180** | ≈ 10 % of building area before expansion |
| **Estimated internal building area** | **≈ 1 975 m²** | Rounded to 1 980 m² for layout |

$$
\text{Functional} + \text{Circulation} + \text{Expansion} = 1\,381 + 414 + 180 = 1\,975 \text{ m}^2 \tag{8.23}
$$

**Table 8.31: Preliminary external site space summary**

| Area category | Space required (m²) |
|---|---:|
| Staff and visitor parking | 660 |
| Company truck parking | 360 |
| Truck manoeuvring and access lanes | 700 |
| Security and gate control allowance | 40 |
| External receiving / dispatch apron | 350 |
| **Estimated external site area** | **2 110** |

$$
\text{Preliminary total site area} = 1\,975 + 2\,110 = 4\,085 \text{ m}^2 \tag{8.24}
$$

For planning the total site area is rounded to approximately **4 100 m²**. The internal building area (≈ 1 980 m²) and external site area (≈ 2 110 m²) are shown separately on the Master Facility Plan. The 10 % future expansion strip remains visible and must not be used to absorb shortfalls in current production or storage space.

> **Note on workbook reconciliation.** The capacity workbook (`05_Working/5.1_Capacity_Model/417.xlsx`) was originally drafted at 1 867 m² internal / 3 977 m² site. The values in Tables 8.30 – 8.31 supersede those figures because the workstation roll-up, office derivation and amenities derivation in this section are itemised, traceable and defensible. The workbook must be updated to match.

---

## 8.11 Section 8 Design Implications and Traceability

The calculations and workstation specifications above create the following layout implications, which drive the design choices made in Section 9 (Alternative Layouts) and Section 10 (Master Facility Plan):

- **Raw-material storage** must be against receiving, tube cutting and sheet stamping.
- **Tube storage** requires long-material handling space because the incoming tubes are 6 m long.
- **Tube cutting and the knurling/external-threading bank** have limited spare capacity (99.7 % utilisation) and must receive direct material supply with no detour.
- **Sharpening** is the single largest workload driver and must be treated as a bottleneck workstation bank, fed by a central WIP lane.
- **Heat treatment, sandblasting and powder coating** need controlled separation because of heat, dust and fume-related risks.
- **Powder coating** is mandated to be a fully enclosed area with controlled entry and exit.
- **Packaging** must be placed after assembly and before finished-goods storage because it doubles as the final visual check.
- **Finished-goods storage** must be next to dispatch and isolated from production movement.
- **Customer collection** must be controlled so that customers do not enter production, storage or forklift routes.
- **Future expansion** must be visibly reserved on the layout, not absorbed into current space.

**Traceability into Sections 9 and 10.** Each line in Tables 8.6, 8.21, 8.23, 8.27, 8.30 and 8.31 maps directly to a department block in Section 9 and to a numbered zone on the Master Facility Plan in Section 10. The layout alternatives in Section 9 are scored against their ability to (i) support demand at takt, (ii) reduce unnecessary material travel, (iii) protect high-utilisation stations from starvation, (iv) separate hazardous processes, (v) provide controlled receiving and dispatch, and (vi) preserve the 10 % future expansion strip. The preferred alternative is refined into the final Master Facility Plan in Section 10.
