# TornadoShelterSim — Spring Jam 26

**EASIEST WAY TO OPEN (Recommended):**

**Double-click the file called:**
`Launch TornadoShelterSim.bat`

It will try to automatically open Godot with this project.

If that doesn't work, open the file `README_FIRST.txt` (it has big clear instructions).

---

## Getting Started

### Prerequisites
- **Godot Engine 4.x**: Download from [godotengine.org](https://godotengine.org/download)
- **Windows OS**: This project is currently Windows-focused
- **Basic Godot knowledge**: Familiarity with the Godot editor interface

### Project Setup

#### Quick Start (Recommended)
1. **Double-click `Launch TornadoShelterSim.bat`** - This will attempt to automatically open Godot with this project
2. If the batch file doesn't work, follow the manual setup below

#### Manual Setup
1. Clone or download this repository
2. Open Godot Engine
3. Click "Import" and select the `project.godot` file in this directory
4. Godot will import the project and open the editor
5. If import errors occur, check `README_FIRST.txt` for troubleshooting

### Running the Project

#### In Editor
- Press `F5` or click the "Play" button in the top-right corner
- Use `F6` to run the current scene for quick testing

#### Standalone Build
- Use `Launch TornadoShelterSim.bat` (recommended)
- Or manually run the exported executable from the exports folder

#### HTML5 Export
- Project is configured for web export
- Go to Export menu → Export Project → HTML5
- Requires Godot HTML5 export templates to be installed

### Project Structure
```
TornadoShelterSim/
├── scenes/           # Game scenes (player, items, environment)
├── scripts/          # GDScript logic files
├── assets/           # Textures, audio, and other resources
├── addons/           # Third-party plugins and extensions
├── demo/             # Demo content and test scenes
├── project.godot     # Godot project configuration
└── README_FIRST.txt  # Detailed troubleshooting and setup guide
```

### Development Workflow
1. **Scene Editing**: Edit scenes in the Godot editor
2. **Scripting**: Write scripts in GDScript using the built-in script editor
3. **Testing**: Test frequently using `F5` to run the full project or `F6` for current scene
4. **Iteration**: Use the hot-reload feature (Ctrl+Shift+R) for quick script updates
5. **Troubleshooting**: Check `README_FIRST.txt` for detailed setup and issue resolution

### Next Steps
- [ ] Set up Godot and import the project successfully
- [ ] Run the project using F5 to verify basic functionality
- [ ] Explore the demo scenes to understand current features
- [ ] Review the project structure and existing scripts
- [ ] Check `README_FIRST.txt` for any platform-specific setup instructions

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
