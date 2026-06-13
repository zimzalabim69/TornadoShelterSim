---
title: Project Overview
type: project
tags: [project, overview]
status: active
jam: "Spring Jam 26"
engine: "Godot 4.6.3"
renderer: "Compatibility"
updated: 2026-05-31
---

# Tornado Shelter Sim — Project Overview

**Tagline**: Prep. Fortify. Survive.

## High Concept

A tense, low-poly PS1/PS2-era first-person survival preparation simulator. You have a limited time before a deadly tornado hits. Scavenge supplies from a rural property, manage your carry weight, and fortify your shelter before the storm arrives.

## Core Pillars

1. **Preparation Under Pressure** — Time is the enemy
2. **Weight & Inventory Management** — Every decision has cost
3. **Meaningful Fortification** — What you place actually matters
4. **Lo-fi Retro Aesthetic** — Chunky, unshaded, nostalgic

## Genre & Inspiration

- **Primary**: Survival / Preparation Sim
- **Secondary**: Light resource management + light horror tension
- **Visuals**: Low-poly PS1 / PS2 style (unshaded materials, limited palette, chunky geometry)

## Technical Constraints (Godot 4.6.3)

- Compatibility renderer only (HTML5 export friendly)
- No heavy threads
- Audio preloading preferred
- GridMap-based yard terrain (2x2 tiles)

## Current Scope (Jam Version)

**In**:
- First-person character controller (mouse look + WASD + sprint + jump)
- Drag-and-drop inventory + shelter storage
- Item pickup system (Resource-based)
- Real-time fortification placement (right-click item → LMB place)
- Basic storm phase system with timer
- Low-poly GridMap yard

**Out (Post-Jam)**:
- Full scoring system
- Multiple storm difficulties
- NPC survivors
- Advanced fortification interactions (windows, doors)
- Sound design pass
- Polish & juice

## Key Files

- `scenes/world/Main.tscn`
- `scripts/player/Player3D.gd`
- `scripts/autoload/PlacementManager.gd`
- `scripts/autoload/InventoryManager.gd`
- `scripts/autoload/GameManager.gd`

## Team

Solo project for Spring Jam 26 (63-hour game jam).

---

**Links**:
- [[00 Dashboard/Dashboard]]
- [[02 Design/Core Gameplay Loop]]
- [[03 Systems/Systems MOC]]