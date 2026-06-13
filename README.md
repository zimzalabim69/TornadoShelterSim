# TornadoShelterSim — Spring Jam 26

**EASIEST WAY TO OPEN (Recommended):**

**Double-click the file called:**
`Launch TornadoShelterSim.bat`

It will try to automatically open Godot with this project.

If that doesn't work, open the file `README_FIRST.txt` (it has big clear instructions).

---

**Current Step**: Step 2 (Item Pickup + Basic Inventory) — Fully playable

## Quick Controls (when running)
- **WASD** / Arrow Keys → Move
- **E** → Pick up items (walk close first)
- **Tab** → Open / Close Inventory

Test items are already placed in the world near the house and garage.

## God Mode Environment

This project is developed under an **AI-managed SDLC pipeline** with the following enforced constraints:

- **Pre-Response Audit**: Every AI interaction is preceded by a 3-layer audit (Dependency, Architecture, Risk).
- **Swarm Protocol**: Parallel task streams (UI/UX, Backend, Testing) are coordinated via `@C:\Users\sikke\Projects\windsurf\.devin\rules\swarm.mdc`.
- **Verification Covenant**: No code is considered delivered until build, test, and lint verification succeed.
- **Auto-PR Delivery**: Verified changes are committed to feature branches and delivered via the Post-Swarm PR workflow (`@C:\Users\sikke\Projects\windsurf\.devin\workflows\post-swarm-pr.md`).

## Important Notes
- All autoloads are wired correctly
- The project uses Compatibility renderer (best for HTML5 later)
- Player is a gray square for now (we'll add real art later)
- The project is set up for HTML5 export from the start
