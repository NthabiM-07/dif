# 8. Detailed Design Specifications

This section presents the calculations and workstation design specifications used to size the proposed DigMore Co. folding mini shovel manufacturing facility. The calculations are based on the production demand, operating schedule, process flow, raw-material policy and processing times established in the previous sections. The purpose of this section is to convert the brief into measurable production, storage, capacity, workstation, material-handling and space requirements that can be used to develop the alternative block layouts and the final Master Facility Plan.

The equipment named in this section is used as a market example for sizing and layout development only. Final equipment selection, costs, service requirements and installation allowances must be confirmed through supplier quotations. Supplier images should be used as references only. Workstation drawings should be redrawn as original figures with the source acknowledged in the caption.

---

## 8.1 Demand Calculation

The production demand was calculated from the projected annual demand and the available working days per year. The facility operates one 9-hour shift per day. After deducting one 30-minute lunch break and two 15-minute tea breaks, 480 productive minutes are available per shift.

\[
\text{Daily shovel production}=
\frac{\text{Annual demand}}{\text{Working days per year}}
\tag{8.1}
\]

\[
=\frac{400\,000}{220}=1\,818.18\approx1\,819\text{ shovels/day}
\]

\[
\text{Hourly shovel production}=
\frac{\text{Daily shovel production}}{\text{Productive hours per day}}
\tag{8.2}
\]

\[
=\frac{1\,819}{8}=227.38\approx228\text{ shovels/hour}
\]

\[
\text{Takt time}=
\frac{480\times60}{1\,819}=15.83\text{ seconds/shovel}
\tag{8.3}
\]

**Table 8.1: Production demand requirements**

| Parameter | Calculation basis | Result |
|---|---:|---:|
| Annual demand | Given in brief | 400 000 shovels/year |
| Working days | Given in brief | 220 days/year |
| Productive time | 9-hour shift less breaks | 480 min/day |
| Daily production | 400 000 ÷ 220 | 1 819 shovels/day |
| Hourly production | 1 819 ÷ 8 | 228 shovels/hour |
| Takt time | 28 800 seconds ÷ 1 819 | 15.83 seconds/shovel |

The daily demand is the main sizing value for the facility. It determines the raw-material stock level, machine requirements, labour requirements, WIP staging, finished-goods storage and dispatch load. The short takt time also shows that the design cannot rely on one machine per process. The longer operations, especially sharpening, serrating, knurling and polishing, require parallel stations.

---

## 8.2 Raw-Material Inventory Requirements

The facility must store two weeks of raw materials. Since the facility operates five days per week, the raw-material inventory calculation is based on ten working days of production.

The following design basis is used:

- One finished shovel requires one back handle section and one middle handle section.
- Both handle sections are cut from aluminium round tube.
- Each handle section is 150 mm long.
- One finished shovel requires one shovel head and one hinge connector.
- The shovel head and hinge connector are stamped from 2.5 mm aluminium sheet or coil.
- A 5% scrap allowance applies only to tube cutting and sheet stamping.
- Packaging bags, rivets and carton boxes are bought-in components.

\[
\text{Two-week production requirement}=1\,819\times10=18\,190\text{ shovels}
\tag{8.4}
\]

### 8.2.1 Aluminium Round Tube Requirement

Each shovel requires two handle sections. Therefore, the number of good handle sections required per day is:

\[
\text{Good handle sections/day}=1\,819\times2=3\,638\text{ sections/day}
\tag{8.5}
\]

Because scrap occurs during tube cutting, the required input quantity is:

\[
\text{Input handle sections/day}=\frac{3\,638}{0.95}=3\,829.47\approx3\,830\text{ sections/day}
\tag{8.6}
\]

The theoretical number of sections obtained from one 6 m tube is:

\[
\text{Sections per 6 m tube}=\frac{6\,000}{150}=40\text{ sections/tube}
\tag{8.7}
\]

\[
\text{Daily 6 m tubes required}=\frac{3\,830}{40}=95.75\approx96\text{ tubes/day}
\tag{8.8}
\]

\[
\text{Two-week tube stock}=96\times10=960\text{ tubes}
\tag{8.9}
\]

A practical saw-kerf allowance may reduce the actual yield from 40 to 39 sections per 6 m tube. If this allowance is adopted during final equipment selection, the two-week stock increases to approximately 990 tubes. The storage layout therefore allows for a conservative tube quantity rather than designing the rack area at the theoretical minimum.

**Figure 8.1: Cutting yield from one 6 m aluminium tube**  
*Draw a 6 000 mm tube divided into 40 sections of 150 mm each. Add a note that practical saw kerf may reduce the usable yield to 39 sections.*  
Reference for tube-cutting machine: https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/

### 8.2.2 Aluminium Sheet or Coil Requirement

Each shovel requires one shovel head and one hinge connector. Both components are stamped from 2.5 mm aluminium sheet or coil. The 5% scrap allowance applies to sheet stamping.

\[
\text{Stamped shovel heads/day}=\frac{1\,819}{0.95}=1\,914.74\approx1\,915\text{ heads/day}
\tag{8.10}
\]

\[
\text{Stamped hinge connectors/day}=\frac{1\,819}{0.95}=1\,914.74\approx1\,915\text{ connectors/day}
\tag{8.11}
\]

The shovel head has a finished size of 150 mm by 120 mm.

\[
\text{Shovel head area}=0.150\times0.120=0.018\text{ m}^2
\tag{8.12}
\]

\[
\text{Two-week shovel head sheet area}=1\,915\times10\times0.018=344.70\text{ m}^2
\tag{8.13}
\]

The hinge connector blank size is not specified in the brief. The hinge connector sheet requirement is therefore calculated after the final blank size is selected:

\[
\text{Two-week hinge connector sheet area}=1\,915\times10\times A_{\text{hinge blank}}
\tag{8.14}
\]

where \(A_{\text{hinge blank}}\) is the selected hinge connector blank area in square metres.

**Figure 8.2: Sheet-metal blanking concept for shovel head and hinge connector**  
*Draw a rectangular 2.5 mm aluminium sheet with nested shovel-head blanks, hinge-connector blanks and a scrap skeleton. Label the blank types and indicate that stamping scrap is allowed only at this stage.*  
Reference for stamping press: https://www.stamtec.com/presses/mechanical-presses/1-point-gap-frame-press/ocp-series-gap-frame-press

**Table 8.2: Raw-material inventory requirement**

| Raw material / component | Daily requirement | Two-week requirement | Basis / source | Layout implication |
|---|---:|---:|---|---|
| Aluminium round tube, 6 m lengths | 96 tubes/day | 960 tubes | Two handle sections per shovel, adjusted for cutting scrap | Long-material storage close to cutting |
| Shovel head blanks | 1 915 blanks/day | 19 150 blanks | One head per shovel, adjusted for stamping scrap | Sheet/coil storage close to stamping |
| Hinge connector blanks | 1 915 blanks/day | 19 150 blanks | One connector per shovel, adjusted for stamping scrap | Store close to hinge stamping and bending |
| Packaging bags | 1 819 bags/day | 18 190 bags | One bag per shovel | Store close to packaging |
| Rivets | To be confirmed | To be confirmed | Final fastening design | Store close to riveting |
| Carton boxes | To be confirmed | To be confirmed | Final packaging design | Store close to packaging and dispatch |

The raw-material calculations show that the facility requires three different storage approaches: long-material storage for tubes, sheet or coil storage for flat aluminium, and small-component storage for bought-in items. Tube cutting and sheet stamping should therefore be positioned close to raw-material storage to reduce repeated movement of heavy aluminium stock.

---

## 8.3 Raw-Material Receiving, Storage and Handling

For the base design, aluminium tubes are assumed to be delivered in strapped 6 m bundles. Sheet material is assumed to be delivered as palletised sheet packs unless coil-fed stamping equipment is selected. Bought-in components are delivered in cartons or flat-packed bundles.

**Table 8.3: Raw-material delivery and storage basis**

| Material / component | Delivery assumption | Storage method | Handling method | Layout implication |
|---|---|---|---|---|
| Aluminium round tubes | Strapped 6 m tube bundles | Cantilever or long-material racks | Forklift for bundles; tube trolley for daily issue | Place near receiving and tube cutting |
| Aluminium sheet packs | Palletised sheet packs or skids | Sheet rack or pallet rack | Forklift or pallet jack | Place near stamping |
| Aluminium coils | Coil pallet, skid or cradle if coil-fed stamping is selected | Coil cradle or coil rack | Forklift with suitable attachment | Requires protected coil staging near stamping |
| Packaging bags | Cartons | Shelving | Manual trolley | Place near packaging |
| Rivets | Small cartons or bins | Small-parts shelving | Manual handling | Place near riveting |
| Carton boxes | Flat-packed bundles or pallets | Shelving or pallet storage | Manual trolley or pallet jack | Place near packaging and dispatch |

**Figure 8.3: Raw-material receiving and storage concept**  
*Draw a block diagram showing supplier truck → receiving bay → incoming inspection → tube racks / sheet rack / bought-in component shelving → tube cutting / sheet stamping / assembly-packaging.*  
Drawing tool: https://app.diagrams.net  
Cantilever rack reference: https://www.krostshelving.com/warehouse-storage-solutions/industrial-racking-systems/cantilever-racking/  
Sheet rack reference: https://www.leanmanufacturingproducts.com/our-products/sheet-metal-storage-racks

**Figure 8.4: Electric counterbalance forklift for raw-material and finished-goods handling**  
*Use a simplified icon or redrawn forklift in the layout. Do not copy the supplier image directly unless permitted.*  
Forklift reference: https://www.toyotaforklift.co.za/

### 8.3.1 Raw-Material Storage Area

The tube stock is stored using cantilever racks because the tubes are 6 m long. Sheet packs are stored on pallet or sheet-rack positions until the final stamping equipment confirms whether sheet-fed or coil-fed material will be used.

**Table 8.4: Preliminary raw-material storage basis**

| Storage element | Design basis | Suggested layout allowance |
|---|---|---:|
| Tube cantilever rack bay | 6 m rack face with arm allowance | 6.0 m × 1.5 m per rack bay |
| Forklift aisle | Straight aisle for long-material movement | 3.5 m wide |
| Sheet pack storage | Palletised sheet packs or sheet rack | 1.2 m × 1.0 m per pallet position |
| Bought-in component shelving | Bags, rivets and cartons | 2.0 m × 1.0 m shelving zone |
| Daily issue trolley parking | Tube cart or small-parts trolley | 1.5 m × 1.2 m per trolley |

**Table 8.5: Raw-material storage summary**

| Storage element | Area (m²) |
|---|---:|
| Tube cantilever racks | 108.0 |
| Sheet pallet positions | 3.6 |
| Forklift aisles | 42.0 |
| Subtotal | 153.6 |
| Handling allowance, 20% | 30.7 |
| **Total raw-material storage area** | **185 m²** |

The raw-material storage area must be positioned close to receiving, tube cutting and sheet stamping. The 6 m tube length affects aisle design because the handling equipment must be able to move long stock without crossing pedestrian routes.

**Figure 8.5: Tube bundle and cantilever rack storage concept**  
*Draw a front view of a tube bundle and a side view of the cantilever rack. Show a 3.5 m forklift aisle and the 6 m rack face.*  
Reference: https://www.krostshelving.com/warehouse-storage-solutions/industrial-racking-systems/cantilever-racking/

---

## 8.4 Manufacturing Capacity Requirements

The number of machines, workstations or operators is calculated by dividing the daily processing load by the available productive time per shift. The base calculation uses 480 minutes per day.

\[
\text{Number required}=\frac{\text{Daily quantity processed}\times\text{Processing time per unit}}{480}
\tag{8.15}
\]

Processing times stated in seconds are converted to minutes.

**Table 8.6: Base manufacturing capacity requirements**

| Production stream | Process | Daily quantity processed | Time per unit (min) | Total time (min/day) | Stations required | Utilisation |
|---|---|---:|---:|---:|---:|---:|
| Handle production | Tube cutting | 3 830 sections | 0.250 | 957.5 | 2 | 99.7% |
| Handle production | Internal threading | 1 915 middle sections | 0.333 | 638.3 | 2 | 66.5% |
| Handle production | Grip-end forming | 1 915 back sections | 0.083 | 159.6 | 1 | 33.2% |
| Handle production | Knurling and external threading | 1 915 back sections | 1.000 | 1 915.0 | 4 | 99.7% |
| Sheet-metal production | Hinge connector stamping | 1 915 blanks | 0.033 | 63.8 | 1 | 13.3% |
| Sheet-metal production | Hinge connector bending | 1 819 parts | 0.083 | 151.6 | 1 | 31.6% |
| Sheet-metal production | Shovel head stamping | 1 915 blanks | 0.033 | 63.8 | 1 | 13.3% |
| Sheet-metal production | Shovel head shaping | 1 819 heads | 0.033 | 60.6 | 1 | 12.6% |
| Sheet-metal production | Blade sharpening | 1 819 heads | 2.000 | 3 638.0 | 8 | 94.7% |
| Sheet-metal production | Blade serrating | 1 819 heads | 1.000 | 1 819.0 | 4 | 94.7% |
| Head subassembly | Riveting | 1 819 units | 0.083 | 151.6 | 1 | 31.6% |
| Finishing | Hand polishing / deburring | 1 819 heads | 1.000 | 1 819.0 | 4 | 94.7% |
| Final production | Final assembly | 1 819 shovels | 0.500 | 909.5 | 2 | 94.7% |
| Final production | Packaging and final visual check | 1 819 shovels | 0.500 | 909.5 | 2 | 94.7% |

The capacity results show that tube cutting, knurling, sharpening, serrating, polishing, assembly and packaging operate at high utilisation. These processes require controlled WIP, short material travel distances and direct line feeding so that operators do not leave their stations to collect material. Sharpening is the main workload driver and must be treated as a bottleneck bank in the layout.

**Table 8.7: Equipment-dependent process basis**

| Process | Required equipment data | Current design action |
|---|---|---|
| Heat treatment | Batch size, cycle time, loading time and unloading time | Finalise after oven selection |
| Sandblasting | Parts per hour or batch cycle time | Finalise after blasting equipment selection |
| Powder coating | Booth capacity, conveyor speed, hanging density and curing time | Fully enclosed area required |
| Packaging | Manual cycle time, bagging method, carton quantity and inspection method | Confirm during workstation design |

Equipment-dependent processes are not finalised using guessed capacities. They are calculated from selected machine specifications and then added to the final space summary.

---

## 8.5 Manufacturing Process and Workstation Design

Each workstation below translates the capacity requirement into a physical design basis. The workstation layouts must show the machine footprint, operator position, WIP before and after the process, local handling method, safety space and main direction of material flow.

### 8.5.1 Tube Cutting Workstation

Tube cutting is the first operation in the handle production stream. Aluminium round tubes are cut into 150 mm handle sections for the back and middle handle components. This process is subject to the 5% scrap allowance and must process 3 830 tube sections per day.

**Table 8.8: Tube cutting workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Automatic aluminium saw with 6 m bar feed |
| Market example | ProfiFeed A420 automatic aluminium saw |
| Machines / operators | 2 machines / 2 operators |
| Cell size per saw | 9.0 m × 2.0 m |
| Area per saw | 18.0 m² |
| Total cutting area | 36.0 m² |
| WIP before | Tube rack face / 6 m tube supply |
| WIP after | Section bins or tube carts |
| Scrap handling | Aluminium scrap bin beside saw outfeed |
| Main handling method | Forklift for tube bundles; tube cart for cut sections |
| Safety requirement | Guarded blade, clear loading side, no pedestrian crossing at infeed |

**Figure 8.6: Automatic aluminium saw with 6 m bar feed**  
Reference: https://profifeedtech.com/products/aluminium-fully-automatic-saw-a420/

**Figure 8.7: Tube cutting workstation layout**  
*Draw two mirrored 9.0 m × 2.0 m cells. Show the 6 m tube rack/infeed face, automatic saw, operator aisle of approximately 0.9 m, WIP section bins and scrap bin.*

**Layout implication:** Tube cutting should be located next to raw-material storage because the 6 m tube stock is long and awkward to handle. The rack face and saw feed face should be aligned to avoid unnecessary lifting or turning of full-length tubes.

### 8.5.2 Internal Threading Workstation

The internal threading operation produces the internal thread on the middle handle section. Two threading stations are required.

**Table 8.9: Internal threading workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Torque-limited tapping machine |
| Market example | Roscamat Tiger electric tapping machine |
| Machines / operators | 2 machines / 2 operators |
| Cell size per station | 3.0 m × 2.0 m |
| Area per station | 6.0 m² |
| WIP before / after | Bench-height bins on both sides |
| Safety / ergonomics | Fixture to reduce wrist torque; swarf bin; task lighting |

**Figure 8.8: Electric tapping machine for internal threading**  
Reference: https://www.cotswold-machinery-sales.co.uk/roscamat-tapping-machines/electric-tapping-machines/roscamat-tiger-electric-tapping-machine/

**Figure 8.9: Internal threading workstation layout**  
*Draw a 3.0 m × 2.0 m bench cell with WIP-in bin, tapping machine, operator position, swarf bin and WIP-out bin.*

### 8.5.3 Grip-End Forming Workstation

The grip-end forming operation narrows one end of the back handle section. One station is required.

**Table 8.10: Grip-end forming workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Tube end-forming / swaging machine |
| Market example | Hippo tube end former class |
| Machines / operators | 1 machine / 1 operator |
| Cell size | 3.0 m × 2.0 m |
| Area | 6.0 m² |
| WIP before / after | Small tube bins or trolleys |
| Safety / ergonomics | Two-position loading, guarded forming area |

**Figure 8.10: Tube end-forming machine**  
Reference: https://www.hippobender.com/tube-end-former/

**Figure 8.11: Grip-end forming workstation layout**  
*Draw a 3.0 m × 2.0 m cell with WIP-in, tube end former, operator position and WIP-out to knurling.*

### 8.5.4 Knurling and External Threading Bank

This operation knurls the grip and forms the external thread on the back handle section. Four machines are required and the utilisation is high, so this bank requires a controlled infeed buffer.

**Table 8.11: Knurling and external threading specifications**

| Item | Specification |
|---|---|
| Equipment class | Two-roll thread/profile rolling machine |
| Market example | Profimach PTR 42 |
| Machines / operators | 4 machines / 4 operators |
| Bank size | 8.4 m × 3.4 m |
| Area | 28.6 m² |
| WIP before | Full-length infeed buffer strip |
| WIP after | Outfeed buffer strip |
| Safety / ergonomics | Elbow-height loading, coolant/mist control, maintenance clearance |

**Figure 8.12: Thread/profile rolling machine**  
Reference: https://profimach.com/special-machine/2-roll-thread-roll-machines-ptr-series

**Figure 8.13: Knurling and external-threading bank layout**  
*Draw four machines in a row, with WIP-in buffer, operator aisle, WIP-out buffer and flow arrows.*

### 8.5.5 Sheet-Metal Press Cell

The press cell stamps the shovel head and hinge connector blanks from 2.5 mm aluminium sheet or coil. The cell must include sheet staging, blank bins and scrap skeleton handling.

**Table 8.12: Sheet-metal press cell specifications**

| Item | Specification |
|---|---|
| Equipment class | Gap-frame mechanical press with dies |
| Market example | Stamtec OCP series gap-frame press |
| Machines / operators | 2 presses / 2 operators |
| Cell size | 6.4 m × 4.0 m |
| Area | 25.6 m² |
| WIP before | Sheet packs or coil-fed staging |
| WIP after | Head blank bins and hinge blank bins |
| Scrap handling | Skeleton scrap bin |
| Safety requirement | Guards or light curtains; die-change access |

**Figure 8.14: Gap-frame mechanical press for sheet stamping**  
Reference: https://www.stamtec.com/presses/mechanical-presses/1-point-gap-frame-press/ocp-series-gap-frame-press

**Figure 8.15: Sheet-metal press cell layout**  
*Draw two presses sharing one sheet staging area, two blank-out bins and one scrap skeleton bin.*

### 8.5.6 Hinge Bending and Shovel Head Shaping

The hinge connector is bent to form the hinge geometry, while the shovel head is shaped to its required form. These operations should remain close to the press cell to keep sheet-metal flow compact.

**Table 8.13: Hinge bending and head shaping specifications**

| Process | Equipment class | Stations | Area allowance | Layout note |
|---|---|---:|---:|---|
| Hinge bending | Small electric press brake | 1 | 8.5 m² | Place after hinge stamping |
| Shovel head shaping | Forming press / bending machine | 1 | 6.0 m² | Place after head stamping and before sharpening |

**Figure 8.16: Electric press brake for hinge bending**  
Reference: https://www.cotswold-machinery-sales.co.uk/euromac-bending-machines/electric-press-brakes/fx-bend-850/

**Figure 8.17: Hinge bending and head shaping workstation layout**  
*Draw two adjacent cells: hinge bending cell and shovel-head shaping cell, both fed from the press cell.*

### 8.5.7 Blade Sharpening Bank

Blade sharpening is the major workload driver in the facility. Eight sharpening stations are required and should be arranged as a bank with central WIP supply.

**Table 8.14: Blade sharpening bank specifications**

| Item | Specification |
|---|---|
| Equipment class | Belt grinder with extraction |
| Market example | Fein GRIT GI75 abrasive belt grinder |
| Machines / operators | 8 machines / 8 operators |
| Bank size | 8.4 m × 6.2 m |
| Area | 52.1 m² |
| WIP before | Central WIP lane |
| WIP after | Trolley or bin transfer to serrating |
| Safety requirement | Eye protection, hearing protection, dust extraction, lockout for belt changes |

**Figure 8.18: Abrasive belt grinder for sharpening**  
Reference: https://www.echopkins.com/shop/fabrication/large-abrasive-machines/belt-grinders/pedestal/fein-gi75-abrasive-belt-grinder/

**Figure 8.19: Blade sharpening bank layout**  
*Draw two rows of four grinders facing a central WIP lane. Show rear dust extraction line, operator positions and flow direction.*

**Layout implication:** Sharpening must be treated as a bottleneck department. It should be fed by a controlled WIP lane and should not require operators to fetch material from another area.

### 8.5.8 Blade Serrating and Hand Polishing

Blade serrating follows sharpening, while polishing/deburring prepares the head subassembly for surface treatment. These processes have high utilisation and must be placed close to the sharpening and coating route.

**Table 8.15: Serrating and polishing specifications**

| Process | Equipment / workstation class | Stations | Area allowance | Layout note |
|---|---|---:|---:|---|
| Blade serrating | Profiled abrasive / serrating stations | 4 | 26.9 m² | In-line after sharpening |
| Hand polishing / deburring | Manual benches with extraction | 4 | 26.0 m² | Before coating route |

**Figure 8.20: Serrating station or hydraulic notching reference**  
Reference: https://www.cotswold-machinery-sales.co.uk/euromac-bending-machines/notching-machines/va-multi-220-6r-notching-machine/

**Figure 8.21: Serrating and polishing row layout**  
*Draw serrating stations in sequence after sharpening, followed by polishing benches with WIP-in and WIP-out bins.*

### 8.5.9 Riveting Workstation

The riveting operation joins the hinge connector to the shovel head. This is the convergence point of the two sheet-metal components.

**Table 8.16: Riveting workstation specifications**

| Item | Specification |
|---|---|
| Equipment class | Pneumatic radial riveting machine |
| Market example | AGME radial riveting machine |
| Machines / operators | 1 machine / 1 operator |
| Cell size | 3.7 m × 2.6 m |
| Area | 9.6 m² |
| WIP before | Matched head and hinge connector buffers |
| WIP after | Head subassembly bin or trolley |
| Safety requirement | Two-hand control, task lighting, compressed-air drop |

**Figure 8.22: Radial riveting machine**  
Reference: https://www.agme.net/en/riveting-machines/radial-riveting-machines

**Figure 8.23: Riveting workstation layout**  
*Draw WIP-in for shovel heads, WIP-in for hinge connectors, rivet shelf, riveting machine, operator position and WIP-out for head subassemblies.*

### 8.5.10 Heat Treatment Area

Heat treatment is equipment-dependent and must be finalised after oven selection. The layout must include an oven, WIP before the oven, cooling space and WIP after heat treatment.

**Table 8.17: Heat treatment area specifications**

| Item | Specification |
|---|---|
| Equipment class | Aluminium ageing batch oven |
| Market example | Wisconsin Oven aluminium age oven |
| Area allowance | 80 m² zone including oven and buffers |
| WIP basis | Day buffer before and after heat treatment |
| Safety requirement | Thermal clearance, hot-part handling, PPE, ventilation |

**Figure 8.24: Aluminium ageing batch oven**  
Reference: https://www.wisoven.com/products/batch-ovens/aluminum-age-ovens

**Figure 8.25: Heat treatment area layout**  
*Draw oven, loading area, WIP-before pallets/racks, cooling area, WIP-after pallets/racks and forklift/pallet-truck access.*

### 8.5.11 Sandblasting Area

Sandblasting prepares the surface of the head subassembly for finishing. The sandblasting area must be enclosed and connected to dust and media recovery.

**Table 8.18: Sandblasting area specifications**

| Item | Specification |
|---|---|
| Equipment class | Enclosed blast booth or blast room |
| Market example | Airblast AFC blast rooms |
| Area allowance | 6.4 m × 5.0 m |
| Area | 32.0 m² |
| WIP before / after | Racked subassemblies |
| Safety requirement | Dust collection, PPE, entry control, sealed waste drums |

**Figure 8.26: Enclosed sandblasting booth / blast room**  
Reference: https://airblastafc.com/blast-solutions/blast-rooms/

**Figure 8.27: Sandblasting area layout**  
*Draw enclosed blast booth, media recovery, dust collector, WIP-in rack, WIP-out rack and sealed waste drum area.*

### 8.5.12 Powder Coating Enclosure

Powder coating must be located in a separate, fully enclosed area because of fume-related safety concerns. The process coats the handle sections and the head subassembly before final assembly.

**Table 8.19: Powder coating enclosure specifications**

| Item | Specification |
|---|---|
| Equipment class | Conveyorised powder-coating line |
| Market example | P.I. Marketing powder-coating system |
| Enclosure size | 15.0 m × 8.0 m |
| Area | 120 m² |
| Layout elements | Load/hang station, booth, cure oven, cooling leg, unload station |
| Safety requirement | Fully enclosed area, extraction, make-up air, controlled entry/exit |

**Figure 8.28: Conveyorised powder-coating line**  
Reference: https://www.pimarketing.co.za/

**Figure 8.29: Fully enclosed powder-coating workstation layout**  
*Draw a 15.0 m × 8.0 m enclosed room with loading point, booth, oven, cooling path, unload point, airlock and extraction unit.*

### 8.5.13 Final Assembly and Packaging

Final assembly is where the handle stream and coated head subassembly converge. Packaging is performed manually and also serves as the final visual check before finished goods are transferred to storage.

**Table 8.20: Final assembly and packaging specifications**

| Area | Specification |
|---|---|
| Final assembly equipment | Manual benches with holding fixtures |
| Assembly stations / operators | 2 stations / 2 operators |
| Assembly area | 13.6 m² |
| Packaging equipment | Manual packing benches, bag/carton storage, pallet-build position |
| Packaging stations / operators | 2 stations / 2 operators |
| Packaging area | 19.8 m² drawn; 18 m² corrected planning allowance |
| Quality control | Final visual check and reject/quarantine bin |
| Handling method | Hand pallet truck to finished-goods storage |

**Figure 8.30: Final assembly bench / workstation reference**  
Reference: https://www.uline.com/Cls_05/Workbenches-and-Packing-Tables

**Figure 8.31: Hand pallet truck for packed goods movement**  
Reference: https://www.adendorff.co.za/mac-afric-2-ton-pallet-truck-685-x-1220-mm-gpallt000

**Figure 8.32: Final assembly and manual packaging layout**  
*Draw two assembly benches followed by two packaging benches. Show three inbound part flows, bag/carton shelving, final visual check point, quarantine bin and pallet-build area.*

---

## 8.6 Labour Requirement

The labour requirement depends on whether each station is independently staffed or whether one operator can supervise more than one short-cycle machine. For the base layout, one operator is assigned to each active station unless the final workstation layout shows that shared supervision is practical.

**Table 8.21: Labour planning summary**

| Labour group | Basis | Estimated operators |
|---|---|---:|
| Fixed-time manufacturing stations | One operator per active station from Table 8.6 | 34 |
| Heat treatment, sandblasting and powder coating | Equipment-dependent crew | To be confirmed |
| Forklift / material-handling operators | Receiving, storage, dispatch and milk-run support | 2–5 |
| Quality / final inspection support | Included in packaging unless separated | To be confirmed |
| **Base production labour before final equipment crew** | To be finalised after equipment selection | **At least 36** |

The final labour number must be updated once heat treatment, sandblasting, powder coating and packaging equipment have been selected. High-utilisation stations should not rely on operators leaving the workstation to collect material, because short interruptions can reduce the ability of the station to meet the daily target.

---

## 8.7 Work-in-Progress Staging

WIP storage is provided only where the process flow requires temporary staging between operations. The purpose is to protect flow between processes with different cycle times, batch behaviour or safety separation, not to create excess inventory.

**Table 8.22: WIP staging basis**

| WIP location | Reason for staging | Recommended storage method |
|---|---|---|
| After tube cutting | Separates back and middle handle sections | Labelled section bins or tube trolleys |
| After internal threading and grip forming | Holds completed handle sections before coating or assembly | Small-part bins or carts |
| After sheet stamping | Separates shovel heads and hinge connectors | Flat trays or labelled bins |
| Before sharpening | Prevents starvation at the bottleneck | Central WIP lane or bins |
| Before heat treatment | Allows batch loading | Heat-resistant trays or racks |
| Before sandblasting | Controls feed into blasting equipment | Bins or racks |
| Before powder coating | Controls movement into enclosed coating area | Hanging racks or coating carts |
| After final assembly | Stages completed shovels before manual packaging | Packing trolleys or bins |

**Table 8.23: WIP container requirement**

| Part type | Approximate daily volume | Containers required |
|---|---:|---:|
| Cut handle sections | 0.56 m³ | 4 |
| Stamped shovel heads | 0.16 m³ | 1 |
| Stamped hinge connectors | 0.04 m³ | 1 |
| Head subassemblies before finishing | 0.98 m³ | 6 |
| **Total** |  | **12 containers** |

For block-layout planning, 12 m² is allocated to distributed WIP staging. This is more practical than using only the theoretical container footprint because WIP areas must include access, labelling, trolley movement and separation between part types.

**Figure 8.33: WIP container and trolley concept**  
*Draw labelled bins/trolleys for cut sections, stamped parts and assembled shovels.*  
Reference for industrial carts: https://www.multitube.com/en/systems/heavy-duty

---

## 8.8 Finished-Goods Storage

Finished-goods storage must accommodate four weeks of completed shovels. Since the facility operates five days per week, the finished-goods storage basis is twenty working days.

\[
\text{Finished-goods stock}=1\,819\times20=36\,380\text{ shovels}
\tag{8.16}
\]

For planning purposes, the finished shovel is assumed to be bagged individually, with ten shovels packed into one carton. The final carton and pallet configuration must be confirmed during packaging workstation design.

\[
\text{Cartons required}=\frac{36\,380}{10}=3\,638\text{ cartons}
\tag{8.17}
\]

If one pallet holds 240 shovels:

\[
\text{Pallets required}=\frac{36\,380}{240}=151.58\approx152\text{ pallets}
\tag{8.18}
\]

If pallets are stored three levels high:

\[
\text{Floor positions}=\frac{152}{3}=50.67\approx51\text{ pallet positions}
\tag{8.19}
\]

\[
\text{Net pallet footprint}=51\times1.2=61.2\text{ m}^2
\tag{8.20}
\]

A 40% allowance is added for access aisles, order picking and dispatch movement.

\[
\text{Finished-goods storage area}=61.2\times1.40=85.68\approx86\text{ m}^2
\tag{8.21}
\]

**Table 8.24: Finished-goods storage basis**

| Item | Value |
|---|---:|
| Finished-goods stock | 36 380 shovels |
| Cartons required | 3 638 cartons |
| Pallets required | 152 pallets |
| Floor pallet positions | 51 positions |
| Storage area including access | 86 m² |

Finished-goods storage should be located close to dispatch so that completed products do not move back through production areas. Customer collection must be controlled separately from production and forklift movement.

**Figure 8.34: Finished-goods racking and dispatch storage concept**  
*Draw pallet racking, FIFO flow arrows, dispatch staging and customer collection point.*  
Selective pallet racking reference: https://www.krostshelving.com/warehouse-storage-solutions-industrial-racking-systems/selective-pallet-racking/

---

## 8.9 Receiving, Dispatch and Material Handling

The receiving and dispatch design must support supplier deliveries, customer collections and large-order dispatch. Receiving and dispatch should be placed so that external vehicle movement does not interfere with internal production movement.

**Table 8.25: Material-handling equipment basis**

| Equipment | Main use | Quantity | Layout requirement |
|---|---|---:|---|
| Electric counterbalance forklift | Tube bundles, sheet packs and finished-goods pallets | 2 | Forklift aisles and charging / parking space |
| Tube trolley | Daily issue of tube sections | As required | Between raw storage and cutting |
| Small-parts trolley | Rivets, packaging bags and small components | As required | Near assembly and packaging |
| Pallet jack | Cartons and light palletised items | 1–2 | Near packaging and dispatch |
| WIP containers / bins | Cut parts and stamped parts | 12 minimum | Distributed at relevant WIP points |

**Table 8.26: Receiving and dispatch area basis**

| Area | Basis | Space allowance |
|---|---|---:|
| Receiving dock / unloading staging | Supplier deliveries and raw-material inspection | 24 m² |
| Dispatch dock / loading staging | Finished-goods loading | 24 m² |
| Customer collection point | Small orders, controlled access | 15 m² |
| Dispatch staging | Orders waiting for loading or collection | 20 m² |
| **Total internal receiving and dispatch area** |  | **83 m²** |

The final site layout must also provide external truck manoeuvring space and parking for DigMore Co.’s delivery vehicles. These areas should be shown outside the building area in the Master Facility Plan.

**Figure 8.35: Receiving and dispatch dock interface**  
*Draw receiving dock, dispatch dock, truck approach, customer collection point, dispatch staging and forklift route. Keep customer movement separate from forklift movement.*  
Dock equipment reference: https://www.maxiflex.co.za/  
Forklift symbol reference: https://www.dimensions.com/element/forklift

---

## 8.10 Production and Support Space Summary

The production area is developed from workstation-level requirements. The area includes machines, workbenches, operators, local material staging and internal movement allowance. Equipment-dependent areas must be updated after final machine selection.

The space summary below uses a corrected design basis. It includes raw-material storage, workstation space, distributed WIP, finished-goods storage, receiving and dispatch, support facilities, circulation and future expansion. The future expansion allowance is kept separate and is not used to compensate for current production or storage needs.

**Table 8.27: Corrected internal building space summary**

| Area category | Space required (m²) | Basis |
|---|---:|---|
| Raw-material storage | 185 | Cantilever racks, sheet storage and forklift aisles |
| Distributed WIP staging | 12 | Container and trolley staging |
| Production workstations | 420 | Bottom-up workstation estimate from process cells |
| Heat treatment, sandblasting and powder coating zones | 232 | Equipment-dependent finishing and enclosed coating spaces |
| Finished-goods storage | 86 | Four-week palletised storage |
| Receiving and dispatch, internal | 83 | Receiving, dispatch and customer collection staging |
| Offices and administration | 127 | Management and administrative staff |
| Amenities | 140 | Restrooms, lockers and cafeteria |
| Utilities, maintenance and plant support | 80 | Electrical, compressor, maintenance and support services |
| Scrap and waste handling | 15 | Tube cutting and sheet stamping scrap |
| **Functional subtotal** | **1 380 m²** | Rounded planning basis |
| Circulation and internal movement allowance | **414 m²** | 30% planning allowance |
| Future expansion reserve | **179 m²** | 10% of building area before expansion |
| **Estimated internal building area** | **1 973 m²** | Rounded to approximately 1 970 m² |

**Table 8.28: Preliminary external site space summary**

| Area category | Space required (m²) |
|---|---:|
| Staff and visitor parking | 660 |
| Company truck parking | 360 |
| Truck manoeuvring and access lanes | 700 |
| Security and gate control allowance | 40 |
| External receiving / dispatch apron | 350 |
| **Estimated external site area** | **2 110 m²** |

\[
\text{Preliminary total site area}=1\,973+2\,110=4\,083\text{ m}^2
\tag{8.22}
\]

For planning purposes, the total site area may be rounded to approximately 4 100 m². The internal building area and external site area must be shown separately in the Master Facility Plan. The 10% future expansion area must remain visible and must not be used to compensate for insufficient current production or storage space.

---

## 8.11 Section 8 Design Implications

The calculations and workstation specifications above create the following layout implications:

- Raw-material storage should be close to receiving, tube cutting and sheet stamping.
- Tube storage requires long-material handling space because the incoming tubes are 6 m long.
- Tube cutting and knurling have limited spare capacity and should receive direct material supply.
- Sharpening is the largest workload driver and should be treated as a bottleneck workstation bank.
- Heat treatment, sandblasting and powder coating require controlled separation because of heat, dust and fume-related risks.
- Powder coating must be placed in a fully enclosed area and should have controlled entry and exit for coated parts.
- Packaging must be located after assembly and before finished-goods storage because it also serves as the final visual check.
- Finished-goods storage should be close to dispatch and separate from production movement.
- Customer collection should be controlled so that customers do not enter production, storage or forklift routes.
- The final block layouts must be developed from the space values and workstation relationships established in this section.

The layout alternatives that follow should therefore be assessed according to their ability to support demand at takt, reduce unnecessary material travel, protect high-utilisation stations from starvation, separate hazardous processes, provide controlled receiving and dispatch, and reserve visible space for future expansion.
