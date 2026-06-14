---
title: Player Controller
type: system
tags: [system, player, fps]
status: working
updated: 2026-05-31
---

# Player Controller

**File**: `scripts/player/Player3D.gd`  
**Scene**: `scenes/player/Player3D.tscn`

## Overview

First-person low-poly PS1/PS2 style CharacterBody3D controller.

## Current Features

- Mouse look (captured by default)
- WASD movement (using custom input actions: forward/backward/left/right)
- Sprint (Shift)
- Jump (Space)
- Gravity
- Interaction raycast (E key)
- Placement mode support (LMB when active)
- Escape key toggles mouse capture (critical for editor testing)

## Key Constants

```gdscript
const SPEED = 5.0
const SPRINT_MULTIPLIER = 1.7
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002
```

## Input Actions Used

- `forward`, `backward`, `left`, `right`
- `sprint`, `jump`
- `interact`
- `place`

## Known Issues / TODOs

- No head bob yet
- No footstep audio
- No weapon / hand visuals (post-jam)
- Consider adding simple interaction prompt UI

## Related

- [[03 Systems/Interaction System]]
- [[03 Systems/Placement System]]
- [[04 Technical/Scene Hierarchy]]
- [[03 Systems/Systems MOC]]
