---
title: Simulation Models MOC
type: MOC
tags: [moc, simulation]
updated: 2026-05-31
---

# Simulation Models MOC

> **Track**: Engineering Simulation (long-term). For the game jam build, see [[00 Dashboard/Dashboard]].

Central hub for all simulation code and configurations.

## Active Models

- [[01 - Simulation Models/Main Simulation|Main Tornado Shelter Simulator]]
- [[01 - Simulation Models/Wind Field Generator|Wind Field Generator]]
- [[01 - Simulation Models/Structural Response|Structural Response Model]]
- [[01 - Simulation Models/Structural Dynamics|Structural Dynamics]]
- [[01 - Simulation Models/Fluid-Structure Interaction|Fluid-Structure Interaction]]
- [[01 - Simulation Models/Debris Impact|Debris Impact]] *(future)*

## Model Versions

> Lists notes in `01 - Simulation Models/` that have a version tag set.

```dataview
TABLE status, version
FROM "01 - Simulation Models"
WHERE type = "model"
SORT file.mtime DESC
```

## Parameters

- Tornado intensity scales (EF0–EF5)
- Shelter material properties (density, Young's modulus, yield strength)
- Wind velocity profiles (Rankine vortex, modified for terrain)
- Shelter geometry parameters
- Debris impact parameters (future)

## Related

- [[00 - MOC/Physics & Engineering|Physics & Engineering MOC]]
- [[07 - Tasks & Roadmap/Roadmap|Current Development Roadmap]]
