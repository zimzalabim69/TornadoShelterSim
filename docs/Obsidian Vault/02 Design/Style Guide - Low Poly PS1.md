---
title: Style Guide - Low Poly PS1
type: design
tags: [design, style, aesthetic]
updated: 2026-05-31
---

# Low-Poly PS1 / PS2 Style Guide

## Core Principles

- **Unshaded materials** (`SHADING_MODE_UNSHADED`)
- **Chunky geometry** — avoid thin details
- **Limited color palette** per asset
- **Vertex snapping** (0.5 or 1.0 grid where possible)
- **No modern PBR** — flat colors + simple gradients

## Material Rules

All world meshes should use:
```gdscript
mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
```

## Recommended Grid Sizes

- Player movement & placement: 1.0 or 2.0
- GridMap tiles: 2.0 (current)
- Small props: 0.5 snapping

## Color Approach

- Desaturated, slightly dirty tones
- Strong value contrast over hue
- Avoid pure black or pure white

## References

- Original PS1 Resident Evil / Silent Hill
- PS2 early 3D (Shadow of the Colossus low-poly areas)
- Modern retro games: "Crow Country", "Nightmare Kart", "Dread X"

## Implementation Notes

- All placed fortifications currently follow this (see [[03 Systems/Placement System|PlacementManager]])
- Player capsule was removed for proper FPS feel
- GridMap tiles should be created in the same style

## Related

- [[01 Projects/Tornado Shelter Sim/Project Overview]]
- [[03 Systems/Placement System]]
