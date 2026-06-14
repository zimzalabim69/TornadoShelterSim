# WaterLevelHUD.gd
# CanvasLayer HUD — Real-time water level indicator with color-coded danger states.

extends CanvasLayer

@onready var progress_bar: ProgressBar = $Panel/MarginContainer/VBoxContainer/ProgressBar
@onready var percent_label: Label = $Panel/MarginContainer/VBoxContainer/PercentLabel
@onready var status_label: Label = $Panel/MarginContainer/VBoxContainer/StatusLabel
@onready var panel: Panel = $Panel

var safe_color := Color(0.2, 0.7, 0.3)      # green
var warning_color := Color(0.9, 0.8, 0.1)   # yellow
var danger_color := Color(0.9, 0.2, 0.2)    # red

func _ready() -> void:
	panel.visible = false
	
	var sm := get_node_or_null("/root/StormManager")
	if sm:
		sm.water_level_changed.connect(_on_water_level_changed)
		sm.flooding_started.connect(_on_flooding_started)
		sm.flooding_ended.connect(_on_flooding_ended)
	else:
		push_warning("WaterLevelHUD: StormManager autoload not found")

func _on_flooding_started() -> void:
	panel.visible = true
	status_label.text = "SHELTER IS FLOODING"
	status_label.modulate = warning_color

func _on_flooding_ended() -> void:
	panel.visible = false
	status_label.text = ""

func _on_water_level_changed(level: float) -> void:
	var pct := clampf(level, 0.0, 100.0)
	progress_bar.value = pct
	percent_label.text = "Water Level: %.0f%%" % pct
	
	# Color coding
	if pct >= 70.0:
		progress_bar.modulate = danger_color
		status_label.text = "DANGER — HEALTH DRAINING"
		status_label.modulate = danger_color
	elif pct >= 40.0:
		progress_bar.modulate = warning_color
		status_label.text = "WARNING — START BAILING"
		status_label.modulate = warning_color
	else:
		progress_bar.modulate = safe_color
		status_label.text = "SHELTER IS FLOODING"
		status_label.modulate = safe_color
