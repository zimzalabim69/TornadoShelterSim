# test_inventory.gd
# Headless unit tests for the InventoryManager stacking / weight logic.
# Run: godot --headless --path . --script tests/test_inventory.gd

extends SceneTree

var _pass_count := 0
var _fail_count := 0

func _init():
	print("\n=== Inventory Unit Tests ===\n")

	_test_overflow_into_new_stack()
	_test_new_item_respects_max_stack()
	_test_weight_limit_rejects()
	_test_remove_item()

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

func _make_manager():
	var im = preload("res://scripts/autoload/InventoryManager.gd").new()
	return im

func _make_item(stack: int, weight: float) -> ItemResource:
	var it := ItemResource.new()
	it.item_name = "TestItem"
	it.max_stack = stack
	it.weight = weight
	return it

func _total_qty(im) -> int:
	var total := 0
	for slot in im.inventory:
		total += int(slot.quantity)
	return total

func _test_overflow_into_new_stack() -> void:
	print("-- Test: adding more than a stack holds keeps every item --")
	var im = _make_manager()
	var item := _make_item(10, 0.0)  # weight 0 so the limit never interferes

	# Pre-fill a stack to 8/10, then add 5 more (3 fit, 2 overflow).
	im.add_item(item, 8)
	im.add_item(item, 5)

	_assert(_total_qty(im) == 13, "All 13 items retained (got %d)" % _total_qty(im))
	for slot in im.inventory:
		_assert(int(slot.quantity) <= item.max_stack, "No slot exceeds max_stack (got %d)" % int(slot.quantity))

func _test_new_item_respects_max_stack() -> void:
	print("\n-- Test: a single large add splits across stacks --")
	var im = _make_manager()
	var item := _make_item(10, 0.0)
	im.add_item(item, 25)
	_assert(_total_qty(im) == 25, "All 25 items retained (got %d)" % _total_qty(im))
	_assert(im.inventory.size() == 3, "Split into 3 stacks of <=10 (got %d)" % im.inventory.size())

func _test_weight_limit_rejects() -> void:
	print("\n-- Test: weight limit still rejects over-heavy adds --")
	var im = _make_manager()
	var heavy := _make_item(10, 30.0)  # 30 > max_carry_weight (25)
	var ok: bool = im.add_item(heavy, 1)
	_assert(not ok, "Over-weight add is rejected")
	_assert(_total_qty(im) == 0, "Nothing added when rejected")

func _test_remove_item() -> void:
	print("\n-- Test: remove_item decrements and clears empty slots --")
	var im = _make_manager()
	var item := _make_item(10, 1.0)
	im.add_item(item, 3)
	im.remove_item(item, 2)
	_assert(_total_qty(im) == 1, "1 item left after removing 2 of 3 (got %d)" % _total_qty(im))
	im.remove_item(item, 5)
	_assert(im.inventory.size() == 0, "Slot cleared when emptied")
