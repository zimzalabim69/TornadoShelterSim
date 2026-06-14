# Player3D.gd - First-person low-poly PS1/PS2 style controller
extends CharacterBody3D

@onready var camera: Camera3D = $Camera3D
@onready var interaction_ray: RayCast3D = $Camera3D/RayCast3D

const SPEED = 5.0
const SPRINT_MULTIPLIER = 1.7
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
const MOUSE_SENSITIVITY = 0.002

var is_sprinting := false
var mouse_captured := true

# Player health
var player_max_health: int = 100
var player_health: int = 100

func _ready():
	add_to_group("Player")  # so Pickup3D proximity labels detect the player
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_captured = true
	if camera:
		camera.current = true
	
	# Connect to StormManager flooding damage
	var sm := get_node_or_null("/root/StormManager")
	if sm:
		sm.player_damaged.connect(_on_player_damaged)
		print("[Player3D] Connected to StormManager damage signal")

func _input(event):
	# Mouse look (only when captured)
	# LMB recaptures the mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		mouse_captured = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -1.57, 1.57)

	# Release the mouse on Escape only when captured
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			mouse_captured = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


	# E - Interact / pickup (contextual: bail water if shelter is flooding)
	if event.is_action_pressed("interact"):
		var sm := get_node_or_null("/root/StormManager")
		if sm and sm.is_flooding:
			sm.bail_water()
		else:
			_try_interact()

	# Tab - Inventory (handled by UI script too, but safe here)
	if event.is_action_pressed("inventory"):
		# UI listens globally - nothing extra needed here for now
		pass

	# LMB - Place current fortification (when PlacementManager is active)
	var pm := get_node_or_null("/root/PlacementManager")
	if event.is_action_pressed("place") and pm and pm.is_placing:
		pm.try_place()

	# Right-click while placing = cancel placement (quality of life)
	if pm and pm.is_placing:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			pm.cancel_placing()

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Sprint
	is_sprinting = Input.is_action_pressed("sprint")

	var current_speed = SPEED * (SPRINT_MULTIPLIER if is_sprinting else 1.0)

	# Movement input (WASD via the custom actions)
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()

func _try_interact():
	if interaction_ray.is_colliding():
		var col = interaction_ray.get_collider()
		if col and col.has_method("interact"):
			col.interact(self)
		elif col is Pickup3D and col.item:
			var inv := get_node_or_null("/root/InventoryManager")
			if inv and inv.add_item(col.item, col.quantity):
				col.queue_free()
			else:
				print("Inventory full - can't carry more")

func _on_player_damaged(amount: int) -> void:
	if player_health <= 0:
		return
	player_health -= amount
	print("[Player3D] Health: ", player_health, "/", player_max_health)
	
	if player_health <= 0:
		_die()

func _die() -> void:
	print("[Player3D] Player died from flooding!")
	# For now: respawn after brief delay
	# Future: game over screen, score tally, etc.
	var tween := create_tween()
	if tween:
		tween.tween_interval(2.0)
		tween.tween_callback(_respawn)

func _respawn() -> void:
	player_health = player_max_health
	print("[Player3D] Player respawned. Health reset to ", player_health)
