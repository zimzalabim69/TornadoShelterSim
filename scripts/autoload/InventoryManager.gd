# scripts/autoload/InventoryManager.gd

extends Node

signal inventory_changed

var inventory: Array[Dictionary] = []          # [{resource: ItemResource, quantity: int}, ...]
var max_carry_weight: float = 25.0
var current_weight: float = 0.0

func _ready() -> void:
	print("[InventoryManager] Step 2 ready")

func add_item(new_item: ItemResource, qty: int = 1) -> bool:
	if not new_item or qty <= 0:
		return false
	
	var added_weight: float = new_item.weight * qty
	if current_weight + added_weight > max_carry_weight:
		print("Too heavy! Cannot carry more.")
		return false
	
	var remaining: int = qty
	
	# Fill existing stacks first
	for slot in inventory:
		if remaining <= 0:
			break
		if slot.resource == new_item and slot.quantity < new_item.max_stack:
			var space_left: int = new_item.max_stack - int(slot.quantity)
			var to_add: int = min(remaining, space_left)
			slot.quantity += to_add
			remaining -= to_add
	
	# Spill whatever is left into new stacks, respecting max_stack.
	# Guard against max_stack <= 0 (editable in the inspector) so a single
	# stack absorbs everything instead of looping forever.
	var stack_cap: int = new_item.max_stack if new_item.max_stack > 0 else remaining
	while remaining > 0:
		var to_add: int = min(remaining, stack_cap)
		inventory.append({
			"resource": new_item,
			"quantity": to_add
		})
		remaining -= to_add
	
	current_weight += added_weight
	inventory_changed.emit()
	return true

func remove_item(item_resource: ItemResource, qty: int = 1) -> bool:
	if not item_resource or qty <= 0:
		return false
	
	var remaining: int = qty
	var i: int = 0
	# Span every matching stack, since add_item may have split the item.
	while i < inventory.size() and remaining > 0:
		var slot: Dictionary = inventory[i]
		if slot.resource == item_resource:
			var remove_amount: int = min(remaining, int(slot.quantity))
			slot.quantity -= remove_amount
			remaining -= remove_amount
			current_weight -= item_resource.weight * remove_amount
			if slot.quantity <= 0:
				inventory.remove_at(i)
				continue  # next slot shifted into index i
		i += 1
	
	if remaining < qty:
		inventory_changed.emit()
	return remaining == 0

func get_total_weight() -> float:
	return current_weight

func clear_inventory() -> void:
	inventory.clear()
	current_weight = 0.0
	inventory_changed.emit()
