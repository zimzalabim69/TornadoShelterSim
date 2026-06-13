---
title: Scene Hierarchy
type: technical
tags: [technical, scene]
updated: 2026-05-31
---

# Main Scene Hierarchy (Main.tscn)

## Current Structure

- Main3D (World.gd)
  - WorldEnvironment
  - DirectionalLight3D
  - Ground (StaticBody3D)
  - Yard
    - GridMap (cell_size = 2,2,2)
  - Environment
  - Buildings (placeholder)
  - Props
    - TestPickup1/2/3
  - Player3D
  - UI (CanvasLayer)
    - InventoryUI
    - ShelterStorageUI

## Notes

- GridMap is ready but needs a proper MeshLibrary assigned
- Props is the current home for world pickups
- Buildings folder will hold House.tscn, Shed.tscn, etc.

## Related

- [[04 Technical/Godot Project Setup]]
- [[03 Systems/Player Controller]]
- [[03 Systems/Placement System]]