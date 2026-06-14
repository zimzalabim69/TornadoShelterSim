# scripts/ui/InventorySlot.gd
extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/VBoxContainer/Icon
@onready var quantity_label: Label = $MarginContainer/VBoxContainer/QuantityLabel

var item_resource: ItemResource
var quantity: int = 0

func setup(resource: ItemResource, qty: int) -> void:
	item_resource = resource
	quantity = qty
	if resource:
		if resource.icon:
			icon.texture = resource.icon
		else:
			icon.modulate = Color(0.6, 0.6, 0.65)
	quantity_label.text = str(qty)

# Drag & Drop support
func _get_drag_data(_at_position):
	if not item_resource:
		return null
	var preview = TextureRect.new()
	preview.texture = icon.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.size = Vector2(48, 48)
	set_drag_preview(preview)
	return {"resource": item_resource, "quantity": quantity, "from": "inventory"}

func _can_drop_data(_at_position, data):
	return data is Dictionary and data.has("resource")

func _drop_data(_at_position, data):
	# Dropped onto this slot from shelter or elsewhere - for now just refresh
	# Full swap logic can be added later
	pass

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var pm := get_node_or_null("/root/PlacementManager")
		if item_resource and pm:
			# Item is consumed only when placement is confirmed (PlacementManager.try_place),
			# so non-placeable items and cancelled placements are no longer lost.
			pm.start_placing(item_resource)
