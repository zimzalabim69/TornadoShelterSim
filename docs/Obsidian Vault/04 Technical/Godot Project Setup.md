---
title: Godot Project Setup
type: technical
tags: [technical, godot]
updated: 2026-05-31
---

# Godot Project Setup

**Version**: Godot 4.6.3  
**Renderer**: Compatibility (required for HTML5)

## Project Settings Highlights

- `application/config/features` = 4.6 + GL Compatibility
- Input map includes custom FPS actions (forward/backward/left/right + sprint/jump/place)
- Three Autoloads:
  - GameManager
  - InventoryManager
  - PlacementManager

## Folder Structure (Current)

```
scenes/
  world/Main.tscn
  player/Player3D.tscn
  ui/
scripts/
  autoload/
  player/
  items/
  ui/
  world/
assets/
  models/
  scenes/terrain/   ← GridMap source
items/resources/    ← ItemResource .tres files
```

## Export Notes

- HTML5 friendly (no heavy threads)
- Preload audio where possible

## Related

- [[01 Projects/Tornado Shelter Sim/Project Overview]]
- [[04 Technical/Scene Hierarchy]]
- [[04 Technical/Code Architecture]]
- [[03 Systems/Autoloads Overview]]