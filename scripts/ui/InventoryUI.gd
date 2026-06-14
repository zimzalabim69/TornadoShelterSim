# scripts/ui/InventoryUI.gd
extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var item_grid: GridContainer = $Panel/MarginContainer/VBoxContainer/ItemGrid
@onready var weight_label: Label = $Panel/MarginContainer/VBoxContainer/WeightLabel
@onready var close_button: Button = $Panel/MarginContainer/VBoxContainer/CloseButton

var slot_scene: PackedScene = preload("res://scenes/ui/InventorySlot.tscn")

func _ready() -> void:
	var inv := get_node_or_null("/root/InventoryManager")
	if inv:
		inv.inventory_changed.connect(_on_inventory_changed)
	panel.visible = false

	# Connect close button if it exists
	if close_button:
		close_button.pressed.connect(_close_inventory)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	panel.visible = not panel.visible
	if panel.visible:
		_refresh_inventory()
	else:
		# Optional: pause game or not
		pass

func _close_inventory() -> void:
	panel.visible = false

func _on_inventory_changed() -> void:
	if panel.visible:
		_refresh_inventory()

func _refresh_inventory() -> void:
	# Clear old slots
	for child in item_grid.get_children():
		child.queue_free()
	
	var inv := get_node_or_null("/root/InventoryManager")
	if not inv:
		return
	
	for slot_data in inv.inventory:
		var slot = slot_scene.instantiate()
		slot.setup(slot_data.resource, slot_data.quantity)
		item_grid.add_child(slot)
	
	weight_label.text = "Carry Weight: %.1f / %.1f" % [
		inv.current_weight, 
		inv.max_carry_weight
	]
