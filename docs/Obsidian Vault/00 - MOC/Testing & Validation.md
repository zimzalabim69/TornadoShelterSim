---
title: Testing & Validation MOC
type: MOC
tags: [moc, simulation, testing]
updated: 2026-05-31
---

# Testing & Validation MOC

> **Track**: Engineering Simulation (long-term). For the game jam build, see [[00 Dashboard/Dashboard]].

Central hub for all simulation verification, validation, and test data.

## Validation Strategy

- Comparison against analytical solutions (simple cases)
- Benchmark against published tornado engineering studies
- Sensitivity analysis
- Full-scale or large-scale test data (where available)

## Current Test Cases

> No `04 - Testing & Validation/` folder exists yet. Create test case notes there and this query will populate automatically.

```dataview
TABLE status, priority, due
FROM "04 - Testing & Validation"
SORT priority DESC
```

## Key Metrics

- Error vs. reference data (%)
- Computational performance (real-time factor)
- Robustness across EF0–EF5 range

## Related

- [[00 - MOC/Physics & Engineering]]
- [[07 - Tasks & Roadmap/Roadmap]] (validation milestones)
- [[07 - Tasks & Roadmap/Backlog]]
