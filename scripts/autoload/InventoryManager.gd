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
	
	# Spill whatever is left into new stacks, respecting max_stack
	while remaining > 0:
		var to_add: int = min(remaining, new_item.max_stack)
		inventory.append({
			"resource": new_item,
			"quantity": to_add
		})
		remaining -= to_add
	
	current_weight += added_weight
	inventory_changed.emit()
	return true

func remove_item(item_resource: ItemResource, qty: int = 1) -> bool:
	for i in range(inventory.size()):
		var slot: Dictionary = inventory[i]
		if slot.resource == item_resource:
			var remove_amount: int = min(qty, int(slot.quantity))
			slot.quantity -= remove_amount
			current_weight -= item_resource.weight * remove_amount
			
			if slot.quantity <= 0:
				inventory.remove_at(i)
			
			inventory_changed.emit()
			return true
	return false

func get_total_weight() -> float:
	return current_weight

func clear_inventory() -> void:
	inventory.clear()
	current_weight = 0.0
	inventory_changed.emit()
