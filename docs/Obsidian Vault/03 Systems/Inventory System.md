---
title: Inventory System
type: system
tags: [system, inventory]
status: functional
updated: 2026-05-31
---

# Inventory System

**Core Files**:
- `scripts/autoload/InventoryManager.gd`
- `scenes/ui/InventoryUI.tscn` + `InventoryUI.gd`
- `scenes/ui/ShelterStorageUI.tscn` + `ShelterStorageUI.gd`
- `scenes/ui/InventorySlot.tscn` + `InventorySlot.gd`

## Features

- Carry weight limit (25.0 default)
- Stacking support
- Drag & drop between player inventory and shelter storage
- Right-click on valid items opens placement mode
- Weight display

## ItemResource

All items are `ItemResource` (extends Resource):

- `item_name`
- `weight`
- `max_stack`
- `category` (WATER, FOOD, BOARDS, FORTIFICATION, MEDICAL, etc.)
- `icon`

## Current State

Basic drag & drop works. Shelter storage is currently demo-only (no persistent storage array yet).

## TODO

- Proper shelter storage data model in InventoryManager
- Weight transfer validation between carry and shelter
- Better visual feedback on drag

## Related

- [[03 Systems/Placement System]]
- [[03 Systems/ItemResource System]]
- [[03 Systems/Systems MOC]]