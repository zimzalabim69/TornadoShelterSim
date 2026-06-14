## Swarm Delivery — Verified Code

### Streams Completed
- **Stream A (Backend)**: StormManager autoload — water level tick, rainfall→flooding linkage via storm intensity, player damage signal, bailing mechanic
- **Stream B (UI/UX)**: WaterLevelHUD CanvasLayer scene with ProgressBar + color-coded danger states (green < 40%, yellow 40-70%, red > 70%)
- **Stream C (Player + Testing)**: Player3D health system (100 HP), contextual E-key bailing (bails when flooding, picks up items when dry), headless test suite

### Verification Evidence
- Build status: ✅ Godot 4.6.3 loads with zero script errors
- Test status: ✅ 10/10 headless unit tests pass (`godot --headless --script tests/test_flooding.gd`)
- Lint status: ✅ N/A (GDScript has no linter in use)

### Architecture Impact
- New autoload: StormManager.gd registered in project.godot
- New UI scene: WaterLevelHUD.tscn wired into Main.tscn UI CanvasLayer
- Player3D extended with player_health, _on_player_damaged, _die, _respawn
- Refactored all scripts to use runtime `get_node_or_null("/root/...")` instead of compile-time autoload globals for headless testability

### Checklist
- [x] Code follows Godot/GDScript guidelines (type hints, signals, @onready)
- [x] No hardcoded secrets
- [x] Tests cover new logic (water rise, damage threshold, bailing, cooldown)
- [x] Documentation updated (README God Mode section remains accurate)
- [x] No regressions in existing systems (inventory, placement, storm phases)
