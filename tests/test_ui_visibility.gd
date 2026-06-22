# test_ui_visibility.gd
# Headless test: opening the inventory / shelter-storage HUDs must actually
# make them visible. Regression guard for the CanvasLayer hide() bug where the
# layer stayed hidden while only panel.visible was toggled.
# Run: godot --headless --path . --script tests/test_ui_visibility.gd

extends SceneTree

var _pass_count := 0
var _fail_count := 0

func _init():
	print("\n=== UI Visibility Tests ===\n")
	_test_inventory_opens()
	_test_shelter_storage_opens()
	print("\n=== Results ===")
	print("Passed: ", _pass_count)
	print("Failed: ", _fail_count)
	quit(0 if _fail_count == 0 else 1)

func _assert(condition: bool, message: String) -> void:
	if condition:
		_pass_count += 1
		print("[PASS] ", message)
	else:
		_fail_count += 1
		print("[FAIL] ", message)

func _test_inventory_opens() -> void:
	print("-- Test: Tab opens the inventory (layer + panel visible) --")
	var ui = preload("res://scenes/ui/InventoryUI.tscn").instantiate()
	root.add_child(ui)
	ui._ready()  # _ready does not auto-fire from a SceneTree _init harness
	ui.toggle_inventory()
	_assert(ui.visible and ui.panel.visible, "InventoryUI visible after toggle (layer=%s panel=%s)" % [ui.visible, ui.panel.visible])
	root.remove_child(ui)
	ui.free()

func _test_shelter_storage_opens() -> void:
	print("\n-- Test: F opens shelter storage (layer + panel visible) --")
	var ui = preload("res://scenes/ui/ShelterStorageUI.tscn").instantiate()
	root.add_child(ui)
	ui._ready()  # _ready does not auto-fire from a SceneTree _init harness
	ui.toggle()
	_assert(ui.visible and ui.panel.visible, "ShelterStorageUI visible after toggle (layer=%s panel=%s)" % [ui.visible, ui.panel.visible])
	root.remove_child(ui)
	ui.free()
