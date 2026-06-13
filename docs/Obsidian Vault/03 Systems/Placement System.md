---
title: Placement System
type: system
tags: [system, placement, fortification]
status: working
updated: 2026-05-31
---

# Placement System

**File**: `scripts/autoload/PlacementManager.gd`

## Purpose

Allows the player to place fortifications (Plywood, Sandbags, etc.) from inventory into the world.

## How It Works

1. Right-click a valid item (category: BOARDS or FORTIFICATION) in InventoryUI
2. Preview appears (unshaded translucent box)
3. Move mouse to aim — snaps to grid
4. Left-click to place real StaticBody3D fortification
5. Right-click cancels placement

## Technical Details

- Uses `PhysicsRayQueryParameters3D` from camera
- Snaps to 1.0 grid with slight Y lift
- All placed objects use `SHADING_MODE_UNSHADED` for PS1 look
- Creates "Fortifications" node in scene if it doesn't exist
- Consumes 1 unit from inventory

## Current Limitations

- Only basic box meshes
- No rotation during placement
- No collision between placed objects (future)
- Preview is added to current scene root

## Future Improvements

- Different mesh per item type
- Snapping to GridMap cells
- Preview cost / validation

## Related

- [[03 Systems/Inventory System]]
- [[03 Systems/Player Controller]]
- [[03 Systems/ItemResource System]]
- [[03 Systems/Systems MOC]]