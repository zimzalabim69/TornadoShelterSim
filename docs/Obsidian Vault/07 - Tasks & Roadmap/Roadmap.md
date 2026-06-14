---
title: Long-Term Roadmap
type: roadmap
tags: [roadmap, simulation]
updated: 2026-05-31
---

# Project Roadmap — TornadoShelterSim (Engineering Sim Track)

> **Scope**: Long-term engineering simulation development — post-jam. For the active jam task list, see [[06 Tasks & Progress/Spring Jam 26]].

## Vision

Accurate, real-time capable simulation of tornado-induced forces on shelter structures for design optimization and safety validation.

## Phases

### Phase 0: Foundations (Done)
- Vault setup with professional PARA-inspired structure
- Basic folder organization
- Initial physics literature review planning
- Godot 4.6.3 base project (from original game jam prototype)

### Phase 1: Core Simulation (Current)
- Implement wind field model (vortex, velocity profiles)
- Basic rigid-body structural response
- Visualization of pressure/force in 3D (Godot-based)
- Integration with existing Player3D and world systems where relevant

**Target Date**: 2026-07-15

### Phase 2: Fluid-Structure Interaction
- CFD coupling (or simplified particle-based approach in Godot)
- Deformable materials / finite element basics
- Mesh optimization and performance tuning

### Phase 3: Validation & UI
- Compare against real tornado data / standards (ASCE 7, FEMA P-361, ICC 500)
- Parameter sweeping / optimization tools
- User-friendly interface for shelter designers

### Phase 4: Advanced Features
- Multi-physics (debris impact)
- VR/AR visualization support
- Machine learning surrogate models for fast approximation

## Milestones

```dataview
TASK
FROM "07 - Tasks & Roadmap"
WHERE contains(text, "Milestone")
GROUP BY file.link
```

## Related

- [[00 - MOC/Home]]
- [[01 - Simulation Models/Main Simulation]]
