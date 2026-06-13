---
title: Interaction System
type: system
tags: [stub, system]
status: in-progress
updated: 2026-05-31
---

# Interaction System

> **Stub** — Fill in when implemented.

**File**: `scripts/player/Player3D.gd` (interaction raycast inline) → may be extracted to its own script post-jam

## Overview

Handles E key raycast interaction from the player camera. Currently inline in Player3D. Triggers item pickup and potentially shelter door/window interactions post-jam.

## Current Features

- E key raycast from Camera3D
- `interact` input action mapped

## Known Issues / TODOs

- [ ] Extract interaction logic into standalone `InteractionManager.gd`
- [ ] Add on-screen interaction prompt (e.g. "Press E to pick up")
- [ ] Support interactable world objects beyond pickups (doors, shelves)

## Related

- [[03 Systems/Player Controller]]
- [[03 Systems/Inventory System]]
- [[03 Systems/Systems MOC]]
