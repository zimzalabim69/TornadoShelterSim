---
title: Autoloads Overview
type: technical
tags: [technical, autoload]
status: in-progress
updated: 2026-05-31
---

# Autoloads Overview

> **Stub** — Fill in when architecture stabilises.

**Registered in**: Project Settings → Autoload

## Current Autoloads

| Singleton Name     | Script Path                          | Purpose                                  |
|--------------------|--------------------------------------|------------------------------------------|
| `GameManager`      | `scripts/autoload/GameManager.gd`    | Storm phase state, timer, game lifecycle |
| `InventoryManager` | `scripts/autoload/InventoryManager.gd` | Carry inventory + shelter storage data |
| `PlacementManager` | `scripts/autoload/PlacementManager.gd` | Fortification preview + placement        |

## Communication Pattern

- Autoloads communicate via signals
- UI nodes connect to autoload signals on `_ready()`
- Player3D references `PlacementManager` for LMB placement input

## Known Issues / TODOs

- [ ] Document all public signals per autoload
- [ ] Consider splitting `InventoryManager` shelter storage into its own autoload post-jam

## Related

- [[03 Systems/GameManager - Storm Phases]]
- [[03 Systems/Inventory System]]
- [[03 Systems/Placement System]]
- [[04 Technical/Godot Project Setup]]
- [[03 Systems/Systems MOC]]
