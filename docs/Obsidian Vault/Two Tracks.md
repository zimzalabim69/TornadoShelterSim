---
title: Two Tracks
type: guide
tags: [guide, overview]
updated: 2026-05-31
---

# Two Tracks — What This Vault Covers

This vault intentionally serves two related but distinct projects that share a codebase and Godot infrastructure.

---

## Track 1: Game Jam Build (Active — Spring Jam 26)

**What it is**: A low-poly PS1/PS2-style first-person survival prep sim. You scavenge supplies, manage weight, fortify a shelter, and survive a tornado.

**Timeline**: 63-hour jam — Spring Jam 26 (deadline: end of May 2026)

**Entry point**: [[00 Dashboard/Dashboard]]

**Key notes**:
- [[01 Projects/Tornado Shelter Sim/Project Overview]]
- [[02 Design/Core Gameplay Loop]]
- [[03 Systems/Systems MOC]]
- [[06 Tasks & Progress/Spring Jam 26]]

---

## Track 2: Engineering Simulation (Long-Term, Post-Jam)

**What it is**: A physics-accurate simulator of tornado-induced loads on shelter structures. Intended as a serious engineering tool for shelter design validation (EF3–EF5 range).

**Timeline**: Post-jam, multi-phase — see roadmap.

**Entry point**: [[00 - MOC/Home]]

**Key notes**:
- [[01 - Simulation Models/Main Simulation]]
- [[00 - MOC/Physics & Engineering]]
- [[07 - Tasks & Roadmap/Roadmap]]

---

## Relationship Between Tracks

Track 2 is built on top of the Track 1 codebase. The game jam prototype provides the 3D infrastructure (Player3D controller, world systems, Godot project) that the engineering sim will extend. They are not competing projects — the jam build is Track 2's foundation.
