# TornadoShelterSim Obsidian Vault

**Development knowledge base for Tornado Shelter Sim — Spring Jam 26**

A low-poly PS1/PS2-style 3D first-person survival preparation game built in Godot 4.6.3.

## What This Vault Is

This vault documents design decisions, systems, and task tracking for the game jam build of Tornado Shelter Sim. A secondary long-term track (serious engineering simulation) also lives here — see the Two Tracks note below.

**Start inside Obsidian at**: `Index.md` → `00 Dashboard/Dashboard.md`

---

## Actual Vault Structure

| Folder                    | Contents                                              |
|---------------------------|-------------------------------------------------------|
| `00 Dashboard/`           | Dashboard, how-to-use guide — start here daily        |
| `00 - MOC/`               | Maps of Content for the long-term simulation track    |
| `01 Projects/`            | Project Overview for the game jam build               |
| `01 - Simulation Models/` | Physics simulation model notes (long-term track)      |
| `02 Design/`              | Core gameplay loop, style guide, mechanics            |
| `03 Systems/`             | All gameplay and technical system documentation       |
| `04 Technical/`           | Godot setup, scene hierarchy, architecture            |
| `06 Tasks & Progress/`    | Jam-specific task tracking (Spring Jam 26)            |
| `07 - Tasks & Roadmap/`   | Long-term project roadmap (post-jam engineering sim)  |
| `02 - Physics & Engineering/` | Physics references and standards (long-term track) |
| `03 - Design & Blueprints/`   | Shelter design specs and blueprints (long-term track) |
| `Templates/`              | Reusable note templates                               |
| `Inbox/`                  | Quick capture area (use `Inbox/Inbox.md`)             |

---

## Two Tracks

This vault serves two related but distinct purposes:

1. **Game Jam Build (active)** — Low-poly PS1/PS2 survival sim for Spring Jam 26 (63 hours). Entry point: `00 Dashboard/Dashboard.md`
2. **Engineering Simulation (long-term)** — Physics-accurate tornado shelter analysis tool. Entry point: `00 - MOC/Home.md`

---

## Project Summary

**Concept**: You have limited time before a deadly tornado hits. Scavenge supplies, manage carry weight, fortify your shelter, survive.

**Tech**: Godot 4.6.3 (Compatibility renderer, HTML5 friendly)

**Core Systems**:
- First-person CharacterBody3D controller (WASD + sprint + jump + mouse look)
- Resource-based item system with weight limits
- Drag & drop inventory + shelter storage
- Real-time fortification placement
- Storm phase system with timer

---

## Recommended Plugins

- Dataview
- Tasks
- Templater
- Minimal theme + Style Settings

The `.obsidian` folder is pre-configured for these.

---

**Engine**: Godot 4.6.3 (Compatibility)  
**Style**: Low-poly PS1/PS2  
**Timeline**: Spring Jam 26 (63 hours)  
**Status**: Active development
