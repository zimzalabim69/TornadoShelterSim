# STEP 1 — Basic Project + Player Movement + Map

**Goal**: Get a playable top-down character moving around a multi-area property with a basic TileMap.

## Folder Structure (Already Created)
```
TornadoShelterSim/
├── assets/
│   ├── tilesets/           # Kenney tiles go here
│   ├── sprites/
│   │   ├── player/
│   │   └── items/
│   ├── ui/
│   └── audio/
├── scenes/
│   ├── world/
│   │   └── Main.tscn
│   └── player/
│       └── Player.tscn
├── scripts/
│   ├── autoload/
│   │   ├── GameManager.gd
│   │   └── InventoryManager.gd
│   ├── player/
│   │   └── Player.gd
│   └── world/
│       └── World.gd
├── resources/
│   └── ItemResource.gd
├── docs/
│   └── STEP1_SETUP.md
└── project.godot
```

## 1. Open the Project in Godot 4.4+
- Open Godot 4.4+
- Import → Select the `TornadoShelterSim` folder
- Make sure **Compatibility** renderer is active (already set in project.godot)

## 2. Recommended Free Assets from Kenney.nl (Step 1 Priority)

**Best packs for fast pixel top-down work:**

1. **1-Bit Pack** (extremely recommended for jam speed)
   - https://kenney.nl/assets/1-bit
   - Great for walls, floors, simple objects

2. **Top-Down City** or **Top-Down** series
   - https://kenney.nl/assets/topdown (search Kenney for "top down")

3. **Pixel RPG Pack** / Tiny variants
   - https://kenney.nl/assets/pixel-rpg

4. **Furniture Pack** or **Interior** elements (for house rooms)
   - https://kenney.nl/assets/furniture-kit (or pixel versions)

5. **Nature / Farm / Road** packs for Yard, Garage, Shed areas
   - https://kenney.nl/assets/nature-kit
   - https://kenney.nl/assets/road-tiles

**For this step you mainly need:**
- 32x32 floor tiles (grass, wood, concrete, dirt)
- Wall tiles
- A few object tiles (table, shelf, car, boxes)

**Quick start tip**: Use the 1-Bit pack + recolor in Godot. You can paint a very readable map in under 30 minutes.

## 3. TileMap Setup (Do This in Editor)

In `Main.tscn` → `TileMap`:

**Create these layers** (already partially set up):
1. **Ground** (z_index = -1)
2. **WallsFloors** (main walkable surfaces + walls)
3. **Objects** (y_sort_enabled = true) ← important for visual depth
4. **Fortifications** (will be used in Step 5)

**How to set up a basic map quickly**:
- Create a new TileSet resource on the TileMap
- Add a TextureAtlas from one of the Kenney packs (32x32)
- Paint:
  - Grass/dirt in the Yard
  - Wood/concrete floors inside House
  - Separate "rooms" using wall tiles (Kitchen, Living, Bedroom)
  - Garage area outside with car shape
  - Shed (small building)
  - Stairs symbol leading down to shelter area (you can fake the shelter as another section of the same map for Step 1, or make a separate room)

**Scavenge Zones** (already placed as Area2D):
- KitchenZone
- GarageZone
- ShedZone
- ShelterStairs (this will later trigger camera switch + shelter view)

## 4. Player Sprite (Temporary)

The Player scene currently references:
`res://assets/sprites/player/player_placeholder.png`

**Quick solution**:
1. Create a 32x32 or 64x64 placeholder image (colored square or simple stick figure)
2. Or download any top-down character from Kenney (1-Bit has some)
3. Put it at that path, or update the path in Player.tscn

For animations (Step 1 uses placeholder single-frame animations):
- Later you will add proper 4-direction walk cycles.

## 5. Input Map (Already Configured in project.godot)

- WASD + Arrow keys → Movement
- **E** → Interact (currently just prints)

## 6. Run the Scene

- Open `scenes/world/Main.tscn`
- Press F5 or the Play button
- You should be able to walk around with WASD

## What Works in Step 1
- Top-down movement (good acceleration/friction feel)
- 4-direction animation stubs (easy to expand)
- Basic multi-layer TileMap ready for painting
- Scavenge zone Area2Ds in place (for Step 2)
- GameManager autoload with storm phases
- InventoryManager stub

## Next (When You Say "Next")
We will implement:
- Real items as Resources
- Pickup with E when near scavenge zones
- Basic inventory UI (grid)

## Tips for Fast Progress
- Paint the map **ugly but readable** first. Beauty comes in polish.
- Keep everything on a 32-pixel grid.
- Use the Compatibility renderer the entire jam.

You are now ready to paint the world.
