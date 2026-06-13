---
title: Main Tornado Shelter Simulator
type: model
tags: [simulation, model, core]
status: in-progress
version: v0.1
updated: 2026-05-31
---

# Main Tornado Shelter Simulator

**Type**: Core Simulation Component
**Version**: v0.1 (Prototype)
**Status**: In Progress
**Engine**: Godot 4.6.3 (using existing game infrastructure + simulation layers)

## Description

Central simulation that combines wind field generation with structural response on shelter geometry. Currently evolving from the original game jam prototype toward a serious engineering tool.

## Current Architecture

- Wind Field Generator → produces velocity and pressure fields
- Structural Response Model → applies forces to rigid or deformable bodies
- Visualization Layer → pressure maps, force vectors, deformation (using existing 3D scene)
- Data Logging → time histories of forces, displacements, stresses

## Integration Notes

- Reuses Player3D controller and world systems for interactive camera/inspection
- Placement system concepts may be adapted for "placing" virtual sensors or test shelters
- GridMap yard system being evaluated for terrain/wind interaction

## Next Steps

- Implement basic Rankine vortex wind field in 3D space
- Apply pressure loads to static shelter meshes
- Record and plot force time histories

## Related

- [[00 - MOC/Simulation Models]]
- [[01 - Simulation Models/Wind Field Generator]]
- [[01 - Simulation Models/Structural Response]]
- [[01 - Simulation Models/Structural Dynamics]]
