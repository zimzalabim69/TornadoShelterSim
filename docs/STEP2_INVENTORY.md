# STEP 2 — Item Pickup + Basic Inventory

**Status**: Complete

## What Was Implemented

### 1. Item System
- `ItemResource` class (in `scripts/items/ItemResource.gd`)
- 9 test items created as `.tres` resources in `items/resources/`:
  - WaterBottle, CannedFood, Plywood, Medkit, Sandbags, GeneratorFuel, Flashlight, RadioBattery, Toolbox

### 2. Pickup System
- `Pickup.tscn` + `Pickup.gd`
- Items in the world that show name when player approaches
- Press **E** to pick up (if carry weight allows)

### 3. Inventory System
- Expanded `InventoryManager` autoload with weight limits (25.0 max)
- Stacking support
- `current_weight` tracking

### 4. Inventory UI
- `InventoryUI.tscn` (press **Tab** to toggle)
- Grid layout (5 columns)
- Weight display at bottom
- `InventorySlot.tscn` + `InventorySlot.gd` for reusable slots

### 5. Player Integration
- Player now belongs to group "Player"
- `_try_pickup()` logic using interaction area

## How to Test Right Now

1. Open `scenes/world/Main.tscn`
2. Add some `Pickup` scenes into the world (from `scenes/items/Pickup.tscn`)
3. In the Inspector, assign one of the `.tres` files to the `item` property
4. Run the game
5. Walk up to an item → Press **E** to pick it up
6. Press **Tab** to open the inventory

## Next Steps (Step 3)
- Drag & drop between player carry and shelter storage
- Shelter storage limits
- Proper icons from Kenney packs

## Recommended Assets (Kenney)
- https://kenney.nl/assets/1-bit
- https://kenney.nl/assets/topdown
- https://kenney.nl/assets/pixel-rpg
- https://kenney.nl/assets/furniture-kit

Replace the placeholder icons in the ItemResource `.tres` files with real 32x32 or 48x48 sprites.
