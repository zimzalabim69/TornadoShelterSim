# World.gd
# Main world controller (3D version)
extends Node3D

func _ready() -> void:
	print("[World] 3D Main scene ready")
	
	# Connect to GameManager for storm phases
	GameManager.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(_new_phase: int) -> void:
	# TODO: react to storm phases (e.g. darken sky, increase wind particles)
	pass

func _unhandled_input(event: InputEvent) -> void:
	# Release the mouse on Escape only when captured
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return

	# Capture the mouse on left-click only when visible
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return

	# Quick test: press Page Down to start storm
	if OS.is_debug_build() and event.is_action_pressed("ui_page_down"):
		GameManager.start_storm()
		print("Storm started (test)")
