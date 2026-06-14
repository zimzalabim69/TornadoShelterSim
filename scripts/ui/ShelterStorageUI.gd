extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var grid: GridContainer = $Panel/Grid

var slot_scene = preload("res://scenes/ui/InventorySlot.tscn")  # reuse for simplicity

func _ready():
	panel.visible = false
	# Populate with empty slots for shelter storage
	for i in 24:
		var slot = slot_scene.instantiate()
		grid.add_child(slot)

func _input(event):
	if event.is_action_pressed("shelter_storage"):
		toggle()

func toggle():
	panel.visible = !panel.visible
	if panel.visible:
		_refresh_shelter()

func _refresh_shelter():
	# For demo, just show current shelter items (extend InventoryManager as needed)
	for i in grid.get_child_count():
		var slot = grid.get_child(i)
		slot.setup(null, 0)  # clear for now
	# In full version, populate from a shelter_items array in InventoryManager

func _can_drop_data(_at_position, data):
	return data is Dictionary and data.has("resource")

func _drop_data(_at_position, data):
	if data and data.has("resource"):
		var inv := get_node_or_null("/root/InventoryManager")
		if inv:
			inv.remove_item(data.resource, data.get("quantity", 1))
		# For demo: just print. In full version store in shelter_items array
		print("Item moved to shelter storage via drag: ", data.resource.item_name)
		_refresh_shelter()
		# Also refresh inventory if open
		var inv_ui = get_parent().get_node_or_null("InventoryUI")
		if inv_ui:
			inv_ui._refresh_inventory()