extends RigidBody3D
class_name Pickup3D

@export var item: ItemResource
@export var quantity: int = 1

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var label: Label3D = $Label3D

func _ready():
	if item:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(randf_range(0.2, 0.8), randf_range(0.2, 0.8), randf_range(0.2, 0.8))
		mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		mesh.material_override = mat
		label.text = item.item_name
	else:
		label.text = "?"
	label.hide()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.show()

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.hide()

func interact(_player):
	var inv := get_node_or_null("/root/InventoryManager")
	if item and inv and inv.add_item(item, quantity):
		queue_free()
	else:
		print("Can't carry more")
