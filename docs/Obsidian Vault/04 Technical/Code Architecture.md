---
title: Code Architecture
type: technical
tags: [technical, architecture]
status: in-progress
updated: 2026-05-31
---

# Code Architecture

> **Stub** — Fill in as the architecture stabilises post-jam.

## High-Level Structure

```
Autoloads (global singletons)
  GameManager       ← game state machine
  InventoryManager  ← all item data
  PlacementManager  ← placement mode controller

Player
  Player3D.gd       ← movement, input, raycast interaction

World
  World.gd          ← scene root, initialisation

UI
  InventoryUI.gd    ← drag & drop display
  ShelterStorageUI.gd
  InventorySlot.gd
```

## Signal Flow

```
GameManager.phase_changed → UI updates, world events
InventoryManager.inventory_changed → InventoryUI refresh
PlacementManager.placement_started → Player3D enables placement input
```

## Conventions

- All autoloads are stateful singletons
- UI nodes are display-only; business logic lives in autoloads
- Items defined as `ItemResource` (.tres files), never hardcoded

## Known Issues / TODOs

- [ ] Document full signal list per autoload
- [ ] Consider a dedicated `WorldManager` for building/prop state

## Related

- [[03 Systems/Autoloads Overview]]
- [[04 Technical/Godot Project Setup]]
- [[04 Technical/Scene Hierarchy]]
- [[03 Systems/Systems MOC]]
