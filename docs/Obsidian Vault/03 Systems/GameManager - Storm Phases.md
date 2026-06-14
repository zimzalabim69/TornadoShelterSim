---
title: GameManager - Storm Phases
type: system
tags: [system, storm, gamemanager]
status: basic
updated: 2026-05-31
---

# GameManager - Storm Phases

**File**: `scripts/autoload/GameManager.gd`

## Storm Phases Enum

```gdscript
enum StormPhase {
    CALM,
    WARNING,
    SEVERE,
    SIRENS,
    HUNKER,
    ENDED
}
```

## Current Behavior

- 18 minute default prep timer
- Automatic phase progression based on time
- Signals: `phase_changed`, `storm_timer_updated`

## Issues Fixed Recently

- `_process` delta bug
- Parameter naming issues in `set_phase` and `start_storm`

## Future Work

- Visual/audio feedback per phase
- Wind intensity
- Random events
- Proper scoring on `end_game()`

## Related

- [[01 Projects/Tornado Shelter Sim/Project Overview]]
- [[02 Design/Core Gameplay Loop]]
- [[03 Systems/Systems MOC]]
