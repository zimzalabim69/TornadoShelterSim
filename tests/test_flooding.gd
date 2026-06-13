# test_flooding.gd
# Headless unit tests for Shelter Flooding system.
# Run: godot --headless --script tests/test_flooding.gd
# Or from project root: godot --headless --path . --script tests/test_flooding.gd

extends SceneTree

var _pass_count := 0
var _fail_count := 0

func _init():
	print("\n=== Shelter Flooding Unit Tests ===\n")
	
	_test_water_level_rise()
	_test_damage_above_threshold()
	_test_bail_reduces_water()
	_test_damage_stops_below_threshold()
	_test_bail_cooldown()
	
	print("\n=== Results ===")
	print("Passed: ", _pass_count)
	print("Failed: ", _fail_count)
	
	var exit_code := 0 if _fail_count == 0 else 1
	quit(exit_code)

func _assert(condition: bool, message: String) -> void:
	if condition:
		_pass_count += 1
		print("[PASS] ", message)
	else:
		_fail_count += 1
		print("[FAIL] ", message)

func _test_water_level_rise() -> void:
	print("-- Test: Water level rises with storm intensity --")
	
	# Manually instantiate dependencies — must name them so get_node("/root/...") works
	var gm := preload("res://scripts/autoload/GameManager.gd").new()
	gm.name = "GameManager"
	root.add_child(gm)
	var sm := preload("res://scripts/autoload/StormManager.gd").new()
	sm.name = "StormManager"
	root.add_child(sm)
	
	gm.storm_intensity = 2
	gm.set_phase(gm.StormPhase.SEVERE)
	
	# Activate StormManager directly (signal integration verified in manual playtest)
	sm._active = true
	
	var initial_level := sm.water_level
	# Simulate 1 second of _process at intensity 2 (rise_rate_medium = 5.0)
	sm._process(1.0)
	var new_level := sm.water_level
	
	_assert(new_level > initial_level, "Water level should rise over 1 second (intensity 2)")
	_assert(abs(new_level - 5.0) < 0.1, "Water level should be ~5.0 after 1s at medium intensity (got %.2f)" % new_level)
	
	root.remove_child(gm)
	gm.free()
	root.remove_child(sm)
	sm.free()

func _test_damage_above_threshold() -> void:
	print("\n-- Test: Health drains when water level > 70% --")
	
	var sm := preload("res://scripts/autoload/StormManager.gd").new()
	root.add_child(sm)
	
	# Use Dictionary for mutable closure capture (GDScript captures primitives by value)
	var tracker := {"damage": 0}
	var damage_callback := func(amount: int): tracker.damage += amount
	sm.player_damaged.connect(damage_callback)
	
	# Force water above danger threshold and tick damage
	sm._set_water_level(75.0)
	sm._active = true
	sm._damage_tick = 0.0
	sm._process(1.1)  # Should trigger one damage tick after 1 second
	
	_assert(tracker.damage == sm.damage_per_second, "Should receive %d damage when water > 70%% (got %d)" % [sm.damage_per_second, tracker.damage])
	
	sm.player_damaged.disconnect(damage_callback)
	root.remove_child(sm)
	sm.free()

func _test_bail_reduces_water() -> void:
	print("\n-- Test: Bailing reduces water level --")
	
	var sm := preload("res://scripts/autoload/StormManager.gd").new()
	root.add_child(sm)
	sm._set_water_level(50.0)
	
	var before := sm.water_level
	var success := sm.bail_water()
	var after := sm.water_level
	
	_assert(success, "bail_water() should return true when water is present")
	_assert(after < before, "Water level should decrease after bailing (%.1f -> %.1f)" % [before, after])
	_assert(abs(after - (before - sm.bail_amount)) < 0.1, "Water should drop by bail_amount (~%.1f, got %.1f)" % [sm.bail_amount, before - after])
	
	root.remove_child(sm)
	sm.free()

func _test_damage_stops_below_threshold() -> void:
	print("\n-- Test: No health drain when water level <= 70% --")
	
	var sm := preload("res://scripts/autoload/StormManager.gd").new()
	root.add_child(sm)
	
	var tracker := {"damage": 0}
	var damage_callback := func(amount: int): tracker.damage += amount
	sm.player_damaged.connect(damage_callback)
	
	# Set water exactly at threshold
	sm._set_water_level(70.0)
	sm._active = true
	sm._damage_tick = 0.0
	sm._process(1.1)
	
	_assert(tracker.damage == sm.damage_per_second, "Damage should still occur at exactly 70%%")
	
	# Now drop well below threshold (50 + 5 rise = 55, still under 70)
	sm._set_water_level(50.0)
	sm._damage_tick = 0.0
	tracker.damage = 0
	sm._process(1.0)
	
	_assert(tracker.damage == 0, "Damage should NOT occur below 70%% (water = 50%%)")
	
	sm.player_damaged.disconnect(damage_callback)
	root.remove_child(sm)
	sm.free()

func _test_bail_cooldown() -> void:
	print("\n-- Test: Bail cooldown prevents spam --")
	
	var sm := preload("res://scripts/autoload/StormManager.gd").new()
	root.add_child(sm)
	sm._set_water_level(80.0)
	sm._bail_timer = 0.0
	
	var first := sm.bail_water()
	var second := sm.bail_water()  # Should fail due to cooldown
	
	_assert(first, "First bail should succeed")
	_assert(not second, "Second bail should fail due to cooldown")
	
	root.remove_child(sm)
	sm.free()
