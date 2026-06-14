---
title: ItemResource System
type: system
tags: [stub, system]
status: in-progress
updated: 2026-05-31
---

# ItemResource System

> **Stub** — Fill in when implemented.

**File**: `scripts/items/ItemResource.gd`  
**Resource path**: `items/resources/*.tres`

## Overview

`ItemResource` is a custom `Resource` subclass that defines all data for a single item type. Used by the inventory, pickup, and placement systems.

## Current Fields

- `item_name: String`
- `weight: float`
- `max_stack: int`
- `category: ItemCategory` (enum: WATER, FOOD, BOARDS, FORTIFICATION, MEDICAL, etc.)
- `icon: Texture2D`

## Known Issues / TODOs

- [ ] Add `placed_scene: PackedScene` field for placement mesh per item type
- [ ] Add `description: String` for UI tooltip
- [ ] Create `.tres` files for all jam items (Plywood, Sandbags, Water Jug, First Aid Kit)

## Related

- [[03 Systems/Inventory System]]
- [[03 Systems/Placement System]]
- [[03 Systems/Systems MOC]]
