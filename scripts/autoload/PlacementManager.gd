# autoload/PlacementManager.gd
# Handles fortification placement preview + actual spawning (PS1 low-poly style)

extends Node

var preview: MeshInstance3D
var is_placing := false
var current_item: ItemResource

# Chunky grid for PS1/PS2 feel (matches 2x2 GridMap tiles)
const PLACEMENT_GRID := 1.0

func start_placing(item: ItemResource):
	if not item or item.category not in ["BOARDS", "FORTIFICATION"]:
		print("Cannot place: ", item.item_name if item else "null", " (needs BOARDS or FORTIFICATION category)")
		return

	is_placing = true
	current_item = item

	if not preview:
		_create_preview()

	preview.visible = false

func _create_preview():
	preview = MeshInstance3D.new()
	preview.mesh = BoxMesh.new()
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.6, 0.5, 0.35, 0.55)  # chunky plywood / sandbag tone
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED  # PS1 style
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	preview.material_override = mat
	# Add to current scene root (will be re-parented on place if needed)
	get_tree().current_scene.add_child(preview)

func _process(_delta):
	if not is_placing or not preview:
		return

	var cam := get_viewport().get_camera_3d()
	if not cam:
		return

	var from := cam.global_position
	var dir := -cam.global_transform.basis.z

	# Explicit type required - deep chain defeats inference in Godot 4.6
	var space_state: PhysicsDirectSpaceState3D = get_tree().current_scene.get_world_3d().direct_space_state
	if not space_state:
		return

	var query := PhysicsRayQueryParameters3D.create(from, from + dir * 12.0)
	query.collide_with_bodies = true
	var result: Dictionary = space_state.intersect_ray(query)

	if result:
		# Use .get() + explicit type — result.position is Variant and defeats inference
		var pos: Vector3 = result.get("position", Vector3.ZERO)
		var snapped_pos: Vector3 = pos.snapped(Vector3(PLACEMENT_GRID, 0.5, PLACEMENT_GRID))
		# Lift slightly so it sits on top of ground/tiles
		snapped_pos.y += 0.5
		preview.global_position = snapped_pos
		preview.visible = true
	else:
		preview.visible = false

func try_place() -> bool:
	if not is_placing or not preview or not preview.visible or not current_item:
		return false

	# === SPAWN REAL FORTIFICATION ===
	var fort := StaticBody3D.new()
	fort.name = current_item.item_name.replace(" ", "") + "_Placed"

	# Simple chunky collision + mesh (PS1 low-poly box)
	var col := CollisionShape3D.new()
	col.shape = BoxShape3D.new()
	col.shape.size = Vector3(1.8, 1.0, 1.0)   # chunky fortification size

	var mesh_inst := MeshInstance3D.new()
	mesh_inst.mesh = BoxMesh.new()
	mesh_inst.mesh.size = Vector3(1.8, 1.0, 1.0)

	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.55, 0.48, 0.32)  # wood / sandbag color
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mesh_inst.material_override = mat

	fort.add_child(col)
	fort.add_child(mesh_inst)

	# Place at preview location (keep rotation flat for now)
	fort.global_position = preview.global_position
	fort.global_rotation = Vector3.ZERO

	# Parent to a Fortifications container in the current scene (create if missing)
	var scene := get_tree().current_scene
	var fort_parent := scene.get_node_or_null("Fortifications")
	if not fort_parent:
		fort_parent = Node3D.new()
		fort_parent.name = "Fortifications"
		scene.add_child(fort_parent)
	fort_parent.add_child(fort)

	print("Placed real fortification: ", current_item.item_name, " at ", fort.global_position)

	# Consume the item
	InventoryManager.remove_item(current_item, 1)

	# Cleanup placement state
	is_placing = false
	preview.visible = false
	current_item = null

	return true

func cancel_placing():
	if is_placing:
		is_placing = false
		if preview:
			preview.visible = false
		current_item = null
		print("Placement cancelled")
