# TornadoShelterSim — Project Memory

> Created: 2026-06-14
> Last updated: 2026-06-14
> Canonical path: `C:\Users\sikke\Projects\godot\tornado-shelter-sim (Godot)\.devin\memory.md`

## Project Overview

Tense, low-poly survival preparation simulator built in Godot 4.6 for Spring Jam 26 (SHELTER theme). Player has limited time before a deadly tornado hits — scavenge supplies from a rural property, manage carry weight, fortify the shelter, and survive the storm.

**Jam Status:** Step 2 (Item Pickup + Basic Inventory) — Fully playable
**Renderer:** GL Compatibility (optimized for HTML5 export)
**Resolution:** 1280x720, viewport stretch mode
**Style:** PS1/PS2 low-poly aesthetic

---

## Architecture

### Autoload Singletons

| Singleton | Script | Purpose |
|-----------|--------|---------|
| `GameManager` | `scripts/autoload/GameManager.gd` | Storm phase state (enum), timer, game lifecycle, scoring |
| `InventoryManager` | `scripts/autoload/InventoryManager.gd` | Carry inventory + shelter storage data, weight-based |
| `PlacementManager` | `scripts/autoload/PlacementManager.gd` | Fortification preview + placement (raycast → snap grid → spawn) |
| `StormManager` | `scripts/autoload/StormManager.gd` | Shelter flooding, water level, player damage, bailing |

### Storm Phases (GameManager.StormPhase enum)

```gdscript
CALM      -> WARNING -> SEVERE -> SIRENS -> HUNKER -> ENDED
```

- Auto-progression based on timer percentage:
  - 35% elapsed → WARNING
  - 65% elapsed → SEVERE
  - 85% elapsed → SIRENS
- Total prep time: 18 minutes (1080s), adjustable
- Storm intensity: 1=Low, 2=Medium, 3=High (randomized at start)

### Communication Pattern

- All autoloads use `signal`-based communication
- UI nodes connect to autoload signals in `_ready()`
- Player references `PlacementManager` for placement input
- StormManager listens to GameManager for phase/intensity changes

---

## Project Structure

```
TornadoShelterSim/
├── assets/
│   ├── scenes/            # Building and prop scenes (House, Garage, Shed, Shelter)
│   └── ui/                # Icons, textures
├── scenes/
│   ├── items/
│   ├── player/            # Player3D.tscn (FPS controller)
│   ├── ui/                # InventoryUI, ShelterStorageUI, WaterLevelHUD
│   └── world/             # Main.tscn (master scene)
├── scripts/
│   ├── autoload/          # 4 global singletons
│   ├── items/             # ItemResource, Pickup3D
│   ├── player/            # Player3D.gd
│   ├── ui/                # InventorySlot, InventoryUI, ShelterStorageUI, WaterLevelHUD
│   └── world/             # World.gd
├── addons/
│   ├── terrain_3d/        # Terrain3D plugin (active)
│   ├── godot_mcp/         # MCP native plugin (active, localhost:9080)
│   └── godotversionupdater/
├── demo/                  # Demo scenes (CodeGeneratedDemo, NavigationDemo, Demo)
├── tests/
│   └── test_flooding.gd
├── tools/
│   └── terrain_pipeline/
│       └── terrain_automate.gd
└── project.godot
```

---

## Current State

### Implemented (Step 2)

- **Player3D**: FPS controller with WASD, mouse look, sprint (Shift), jump (Space), interact (E)
- **Item Pickup**: Proximity-based collection, 9 test items with stacking
- **Inventory**: Weight-based (25.0 max), grid UI (5 columns), Tab to open
- **Item Resources**: `ItemResource` custom resource with weight, stack size, category, icon
- **Storm Timer**: 18-minute countdown with automatic phase progression
- **Flooding System**: Water level rises during storm; bailing (E when flooding); damage above threshold (70%)
- **Shelter Storage**: Separate UI (F key) for dumping excess items
- **Placement System**: LMB to place fortifications (boards/sandbags) snapped to 1.0 grid
- **Multi-Area Property**: House, Garage, Shed, Shelter with item spawn zones
- **Autoload Architecture**: 4 singletons handling all global state

### Test Items (9)

WaterBottle, CannedFood, Plywood, Medkit, Sandbags, GeneratorFuel, Flashlight, RadioBattery, Toolbox

### Planned / Not Yet Implemented

- Drag-and-drop between player carry and shelter storage
- Shelter storage capacity limits (volume-based)
- Real-time fortification effectiveness scoring
- Proper item icons and sprites
- Full scoring system (prep + fortification + survival)
- Multiple storm difficulty levels
- NPC survivor mechanics
- Advanced fortification (windows, doors)
- Sound design and polish

---

## Input Mappings

| Action | Key |
|--------|-----|
| Move | WASD / Arrow Keys |
| Sprint | Shift |
| Jump | Space |
| Interact / Pickup | E |
| Inventory | Tab |
| Shelter Storage | F |
| Place Fortification | LMB (when placing) |
| Cancel Placement | RMB |
| Release Mouse | Escape |

**Note:** `move_left/right` AND `left/right` actions exist (legacy). Player3D uses `left/right/forward/backward` (the FPS set). Top-down controller (if any) may use `move_left/right/up/down`.

---

## Physics Layers

| Layer | Name |
|-------|------|
| 1 | World |
| 2 | Player |
| 3 | Items |
| 4 | ScavengeZones |
| 5 | Shelter |

---

## Key Technical Details

### ItemResource (`scripts/items/ItemResource.gd`)

```gdscript
class_name ItemResource extends Resource
@export var item_name: String
@export var icon: Texture2D
@export var category: String       # WATER, FOOD, MEDICAL, TOOLS, BOARDS, FUEL, GENERATOR_PART
@export var max_stack: int = 10
@export var volume: float = 1.0    # For shelter storage limits (future)
@export var weight: float = 1.0    # Carry weight limit
@export var description: String
```

### PlacementManager

- Raycast from camera center to find placement surface
- Snaps to 1.0 grid (PS1 chunky feel)
- Preview mesh: translucent unshaded box
- Real placement: StaticBody3D + CollisionShape3D + MeshInstance3D
- Requires item category `BOARDS` or `FORTIFICATION`
- Consumes item from inventory on place
- Creates `Fortifications` Node3D container in current scene if missing

### StormManager Flooding

- Activated on phases WARNING → SIRENS → HUNKER
- Water level 0.0–100.0, rises at rate based on intensity:
  - Low: 2.5/s, Medium: 5.0/s, High: 9.0/s
- Danger threshold: 70.0 → player takes 5 HP/s damage
- Bail: removes 15.0 water per action, 0.4s cooldown
- Player respawns 2s after death (health reset to 100)

### Player3D Controller

- `CharacterBody3D` with `move_and_slide()`
- `Input.get_vector("left", "right", "forward", "backward")` for movement
- Sprint multiplier: 1.7x
- Interaction raycast from camera, 3 units ahead (configurable in scene)
- LMB recaptures mouse when visible
- Escape toggles mouse capture

---

## Devin MCP Setup

- Godot MCP Native plugin running inside Godot Editor
- HTTP server on localhost:9080
- Devin config: `mcpServers.godot` with `"url": "http://localhost:9080/mcp"`
- Permission: `mcp__godot__*` auto-allowed in Devin config

---

## Environment

- **Godot**: 4.6.3-stable (GL Compatibility renderer)
- **Plugins**: Terrain3D, godot_mcp, godotversionupdater
- **Physics Engine**: Godot Physics 3D
- **Target Export**: Windows Desktop + HTML5

---

## Known Issues / Watchpoints

1. **Dual input action sets**: `move_left/right` (top-down) and `left/right` (FPS) both exist. Ensure Player3D uses the correct set.
2. **PlacementManager** spawns `Fortifications` container dynamically — make sure it persists across saves.
3. **StormManager** uses `get_node_or_null("/root/GameManager")` for intensity/phase lookups — fragile if node names change.
4. **No save/load system** yet — everything is session-only.
5. **HTML5 export** requires GL Compatibility renderer (already set).

---

## Next Actions (from README)

- Drag-and-drop inventory ↔ shelter storage
- Shelter storage volume limits
- Fortification scoring (how well did you fortify?)
- Proper item art/icons
- Sound design pass
- NPC survivors
