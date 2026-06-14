# TornadoShelterSim

![Godot 4.6](https://img.shields.io/badge/Godot-4.6-478cbf?style=flat-square&logo=godot-engine)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Windows-blue?style=flat-square)
![HTML5](https://img.shields.io/badge/Export-HTML5-orange?style=flat-square)
![Spring Jam 26](https://img.shields.io/badge/Jam-Spring%20Jam%2026-green?style=flat-square)

**Prep. Fortify. Survive.**

A tense, low-poly survival preparation simulator built for Spring Jam 26. You have limited time before a deadly tornado hits. Scavenge supplies from a rural property, manage your carry weight, and fortify your shelter before the storm arrives.

---

## 📋 Overview

TornadoShelterSim is a preparation and survival simulation game that challenges players to make strategic decisions under time pressure. The game features weight-based inventory management, item scavenging across multiple locations, shelter fortification mechanics, and a dynamic storm phase system.

**Current Status:** Step 2 (Item Pickup + Basic Inventory) — Fully playable

### Core Gameplay Loop

1. **Scavenge** the property for supplies (limited time)
2. **Manage Weight** — decide what to carry vs leave
3. **Return** to shelter and store excess
4. **Fortify** using placement system
5. **Survive** the storm phases

### Key Features

#### Currently Implemented
- **Player Movement**: Smooth top-down character controller with WASD/Arrow key support
- **Item Pickup System**: Interactive item collection with proximity-based prompts
- **Inventory Management**: Weight-based inventory (25.0 unit limit) with stacking support
- **Inventory UI**: Grid-based inventory interface (5 columns) with weight display
- **Item Resource System**: 9 test items (WaterBottle, CannedFood, Plywood, Medkit, Sandbags, GeneratorFuel, Flashlight, RadioBattery, Toolbox)
- **Multi-Area Property**: House, Garage, Shed, and Shelter locations
- **Scavenge Zones**: Kitchen, Garage, and Shed areas with item spawns
- **Storm Phase System**: Basic timer and phase management
- **Autoload Architecture**: Global singletons for game state management

#### Planned Features
- Drag-and-drop between player carry and shelter storage
- Shelter storage capacity limits
- Real-time fortification placement system
- Proper item icons and sprites
- Full scoring system
- Multiple storm difficulty levels
- NPC survivor mechanics
- Advanced fortification interactions (windows, doors)
- Sound design and polish

---

## 🏗️ Architecture

### Autoload Singletons

The game uses Godot's autoload system for global state management:

| Singleton | Script | Purpose |
|-----------|--------|---------|
| `GameManager` | `scripts/autoload/GameManager.gd` | Storm phase state, timer, game lifecycle |
| `InventoryManager` | `scripts/autoload/InventoryManager.gd` | Carry inventory + shelter storage data |
| `PlacementManager` | `scripts/autoload/PlacementManager.gd` | Fortification preview + placement |
| `StormManager` | `scripts/autoload/StormManager.gd` | Storm simulation and effects |

### System Communication

- Autoloads communicate via signals
- UI nodes connect to autoload signals on `_ready()`
- Player references `PlacementManager` for placement input
- Signal-based architecture ensures loose coupling between systems

### Project Structure

```
TornadoShelterSim/
├── assets/                 # Textures, models, audio, and resources
│   ├── scenes/            # Building and prop scenes
│   └── ui/                # UI elements and icons
├── scenes/                # Game scenes
│   ├── items/             # Pickup and item scenes
│   ├── player/            # Player character
│   ├── ui/                # Inventory and HUD scenes
│   └── world/             # Main game world
├── scripts/               # GDScript logic files
│   ├── autoload/          # Global singleton scripts
│   ├── items/             # Item and pickup logic
│   ├── player/            # Player controller
│   ├── ui/                # UI controllers
│   └── world/             # World management
├── addons/                # Third-party plugins
│   ├── terrain_3d/        # Terrain generation system
│   └── godotversionupdater/ # Version management
├── demo/                  # Demo content and test scenes
├── docs/                  # Project documentation
├── tests/                 # Test scripts
└── project.godot          # Godot project configuration
```

### Technical Details

- **Engine**: Godot 4.6
- **Language**: GDScript
- **Renderer**: Compatibility (optimized for HTML5 export)
- **Resolution**: 1280x720 (viewport stretch mode)
- **Physics Layers**: World, Player, Items, ScavengeZones, Shelter
- **Asset Sources**: Kenney.nl assets (1-Bit, Top-Down, Pixel RPG packs recommended)

---

## 🚀 Getting Started

### Prerequisites

- **Godot Engine 4.6+**: Download from [godotengine.org](https://godotengine.org/download)
- **Windows OS**: This project is currently Windows-focused
- **HTML5 Export Templates**: Required for web export (optional)

### Quick Start (Recommended)

1. **Double-click `Launch TornadoShelterSim.bat`**
   - This batch file will attempt to automatically open Godot with this project
   - If Godot is not found, follow the on-screen prompts to locate it

2. If the batch file doesn't work, see Manual Setup below

### Manual Setup

1. Clone or download this repository
2. Open Godot Engine 4.6+
3. Click "Import" and select the `project.godot` file in the project directory
4. Godot will import the project and open the editor
5. Verify the Compatibility renderer is active (Project Settings → Rendering → Rendering Method)

### Running the Project

#### In Editor
- Press `F5` or click the "Play" button to run the main scene
- Use `F6` to run the current scene for quick testing
- Use `Ctrl+Shift+R` for hot-reload script updates

#### Standalone Build
- Use `Launch TornadoShelterSim.bat` (recommended)
- Or manually run the exported executable from the exports folder

#### HTML5 Export
1. Install Godot HTML5 export templates
2. Go to Project → Export
3. Select HTML5 preset
4. Click "Export Project"
5. Requires a local web server to test

### Exporting the Project

#### Creating an Executable Build
1. Go to **Project → Export** in the Godot editor
2. Click **Add Preset** and select **Windows Desktop**
3. Configure export settings:
   - **Export Path**: Choose a folder (e.g., `exports/windows/`)
   - **Dedicated Server**: OFF
   - **Debug**: OFF (for release builds)
4. Click **Export Project** and select the destination folder
5. The executable will be created in your chosen export folder

#### HTML5 Web Export
1. Go to **Project → Export** in the Godot editor
2. Click **Add Preset** and select **Web**
3. Ensure HTML5 export templates are installed:
   - If not, Godot will prompt you to download them
4. Configure export settings as needed
5. Click **Export Project** and select the destination folder
6. Open the generated `index.html` in a web browser

**Note:** HTML5 export requires the GL Compatibility renderer (already configured in this project).

### Advanced Launch Options

#### Command-Line Launching
If you prefer command-line control, you can launch Godot directly:

**Launch Editor:**
```bash
godot --path "C:\Users\sikke\Projects\TornadoShelterSim" --editor
```

**Run Game:**
```bash
godot --path "C:\Users\sikke\Projects\TornadoShelterSim"
```

**Run Specific Scene:**
```bash
godot --path "C:\Users\sikke\Projects\TornadoShelterSim" "res://scenes/world/Main.tscn"
```

**Run in Windowed Mode:**
```bash
godot --path "C:\Users\sikke\Projects\TornadoShelterSim" --windowed
```

**Note:** Replace `godot` with the full path to your Godot executable if it's not in your system PATH.

---

## 🎮 Controls

### Movement & Interaction
| Action | Key/Button |
|--------|------------|
| Move | WASD / Arrow Keys |
| Sprint | Shift |
| Jump | Space |
| Pick Up Item | E (when close) |
| Release Mouse / Cancel UI | Escape |

### Inventory & Storage
| Action | Key/Button |
|--------|------------|
| Open/Close Inventory | Tab |
| Open/Close Shelter Storage | F |
| Place Fortification | Left Mouse Button (when in placement mode) |

> **Note:** Test items are already placed in the world near the house and garage.

---

## 📸 Screenshots

<!-- TODO: Add screenshots of gameplay
![Gameplay Screenshot 1](screenshots/gameplay1.png)
![Gameplay Screenshot 2](screenshots/gameplay2.png)
![Inventory UI](screenshots/inventory.png)
-->

---

## 🛠️ Development

### Recommended Assets

For development and asset replacement, the following Kenney.nl asset packs are recommended:

- **1-Bit Pack**: https://kenney.nl/assets/1-bit (great for walls, floors, objects)
- **Top-Down City**: https://kenney.nl/assets/topdown (search Kenney for "top down")
- **Pixel RPG Pack**: https://kenney.nl/assets/pixel-rpg
- **Furniture Kit**: https://kenney.nl/assets/furniture-kit (for interior elements)
- **Nature Kit**: https://kenney.nl/assets/nature-kit (for yard areas)

### Development Workflow

1. **Scene Editing**: Edit scenes in the Godot editor
2. **Scripting**: Write scripts in GDScript using the built-in script editor
3. **Testing**: Test frequently using `F5` for full project or `F6` for current scene
4. **Iteration**: Use hot-reload (Ctrl+Shift+R) for quick script updates
5. **Asset Integration**: Replace placeholder assets with Kenney sprites as needed

### Adding New Items

1. Create a new `ItemResource` in `items/resources/`
2. Configure properties (name, weight, icon, description)
3. Create a `Pickup` scene and assign the resource
4. Place the pickup in the world
5. Test pickup and inventory functionality

---

## 🔧 Troubleshooting

### Godot Won't Open Project

**Issue**: Import errors or missing files
- **Solution**: Check that all autoload scripts exist in `scripts/autoload/`
- **Solution**: Verify `project.godot` is in the project root
- **Solution**: Ensure you're using Godot 4.6 or later

### Items Not Appearing

**Issue**: Pickups don't show in the world
- **Solution**: Verify the `Pickup` scene has an ItemResource assigned
- **Solution**: Check that the item sprite is properly loaded
- **Solution**: Ensure the item is within the camera view

### Inventory Not Opening

**Issue**: Tab key doesn't open inventory
- **Solution**: Check that `InventoryUI.tscn` is properly set up
- **Solution**: Verify the `inventory` input action is mapped in Project Settings
- **Solution**: Ensure `InventoryManager` autoload is registered

### HTML5 Export Issues

**Issue**: Web export fails or doesn't run
- **Solution**: Install HTML5 export templates in Godot
- **Solution**: Use a local web server (Python: `python -m http.server`)
- **Solution**: Check browser console for JavaScript errors
- **Solution**: Verify Compatibility renderer is active

### Performance Issues

**Issue**: Low frame rate or stuttering
- **Solution**: Reduce number of items in the world
- **Solution**: Check for infinite loops in scripts
- **Solution**: Verify physics layers are properly configured
- **Solution**: Use Godot's profiler to identify bottlenecks

---

## 🗺️ Roadmap

### Immediate Next Steps (Step 3)
- [ ] Drag-and-drop between player carry and shelter storage
- [ ] Shelter storage capacity limits
- [ ] Real-time fortification placement system
- [ ] Proper item icons from Kenney asset packs

### Short-term Goals
- [ ] Full scoring system based on survival and preparation
- [ ] Multiple storm difficulty levels
- [ ] Audio design and sound effects
- [ ] Visual polish and "juice" (particles, animations)

### Long-term Vision (Post-Jam)
- [ ] NPC survivor mechanics with rescue objectives
- [ ] Multiple properties/locations
- [ ] Dynamic weather affecting placement
- [ ] Advanced fortification interactions (windows, doors)
- [ ] VR/AR visualization support (engineering simulation track)

---

## 🤝 Contributing

Contributions are welcome! This is a solo jam project, but feedback and improvements are appreciated.

### Contribution Guidelines

1. **Code Style**: Follow Godot's GDScript style guide
2. **Commit Messages**: Use clear, descriptive commit messages
3. **Testing**: Test changes thoroughly before submitting
4. **Documentation**: Update relevant documentation when adding features
5. **Assets**: Use only CC0 or properly licensed assets

### Reporting Issues

When reporting bugs or issues, please include:
- Godot version
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots or error logs if applicable

### Feature Requests

Feature requests should be aligned with the core gameplay pillars:
- Preparation under pressure
- Weight and inventory management
- Meaningful fortification
- Lo-fi retro aesthetic

---

## 📄 License

This project is open source under the MIT License. See [LICENSE](LICENSE) file for details.

---

## 👏 Credits

- **Development**: Solo project for Spring Jam 26
- **Engine**: Godot 4.6
- **Assets**: Kenney.nl (CC0 license)
- **Terrain System**: Terrain3D addon

---

## 📚 Documentation

Additional project documentation is available in the `docs/` folder:
- `STEP1_SETUP.md` - Initial setup and configuration
- `STEP2_INVENTORY.md` - Inventory system implementation
- `docs/Obsidian Vault/` - Comprehensive design and technical documentation

---

## 🙏 Acknowledgments

Built for Spring Jam 26 with the theme "SHELTER". Special thanks to the Godot community and Kenney.nl for providing excellent free assets.

---

**Current Version**: Step 2 (Item Pickup + Basic Inventory)  
**Last Updated**: 2026-06-13  
**Godot Version**: 4.6