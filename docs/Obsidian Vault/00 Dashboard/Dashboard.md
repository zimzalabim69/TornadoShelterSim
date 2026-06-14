---
title: Dashboard
type: MOC
tags: [dashboard, moc]
status: active
updated: 2026-05-31
---

# Tornado Shelter Sim — Dashboard

> **Current Status**: Core systems functional. Player controller, inventory, and placement system working. GridMap yard ready for painting.

## Quick Links

- [[01 Projects/Tornado Shelter Sim/Project Overview | Project Overview]]
- [[03 Systems/Systems MOC | Systems MOC]]
- [[06 Tasks & Progress/Spring Jam 26 | Current Tasks & Jam Progress]]

## At a Glance

**Core Loop**: Scavenge → Manage Inventory Weight → Fortify Shelter → Survive Storm

**Key Systems**:
- [[03 Systems/Player Controller | Player Controller]] (FPS, low-poly)
- [[03 Systems/Inventory System | Inventory + Shelter Storage]]
- [[03 Systems/Placement System | Fortification Placement]]
- [[03 Systems/GameManager - Storm Phases | Storm Phases & Timing]]

## Recent Work

- Player3D controller fully cleaned and working (mouse capture + Escape toggle)
- PlacementManager now spawns real unshaded fortifications
- Main.tscn cleaned (proper Props hierarchy, GridMap node added)
- GameManager bugs fixed

## Daily Priorities (Spring Jam)

```dataview
TASK
FROM "06 Tasks & Progress"
WHERE !completed
SORT file.name ASC
```

## Vault Stats

- Systems documented: Growing
- Design docs: In progress
- Open tasks: See [[06 Tasks & Progress/Spring Jam 26]]

---

*Vault maintained for professional game jam development.*