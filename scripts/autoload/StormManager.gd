# StormManager.gd
# Autoload — Handles shelter flooding, rainfall intensity → water level, player damage, bailing.
# Interfaces with GameManager for storm_intensity and storm phases.

extends Node

signal water_level_changed(level: float)    # 0.0 — 100.0
signal flooding_started
signal flooding_ended
signal player_damaged(amount: int)

# Water level state
var water_level: float = 0.0          # 0.0 — 100.0
var max_water_level: float = 100.0
var is_flooding: bool = false

# Configuration (tuned per storm intensity)
var rise_rate_low: float = 2.5          # units per second at intensity 1
var rise_rate_medium: float = 5.0       # units per second at intensity 2
var rise_rate_high: float = 9.0         # units per second at intensity 3

# Health drain threshold
var danger_threshold: float = 70.0
var damage_per_second: int = 5

# Bailing
var bail_amount: float = 15.0         # water reduced per bail action
var bail_cooldown: float = 0.4          # seconds between bail actions
var _bail_timer: float = 0.0

# Internal
var _damage_tick: float = 0.0
var _active: bool = false
var _cached_intensity: int = 2   # default medium (1=low, 2=med, 3=high)

func _ready() -> void:
	print("[StormManager] Flooding system ready")
	# Listen to GameManager for storm intensity changes
	if is_inside_tree():
		var gm := get_node_or_null("/root/GameManager")
		if gm:
			gm.storm_intensity_set.connect(_on_intensity_changed)
			gm.phase_changed.connect(_on_phase_changed)

func _process(delta: float) -> void:
	if not _active:
		return
	
	# Tick bail cooldown
	if _bail_timer > 0.0:
		_bail_timer -= delta
	
	# Rising water during active storm
	var rise_rate := _get_rise_rate()
	if rise_rate > 0.0:
		_set_water_level(water_level + rise_rate * delta)
	
	# Health drain when above danger threshold
	if water_level >= danger_threshold:
		_damage_tick += delta
		if _damage_tick >= 1.0:
			_damage_tick -= 1.0
			_deal_damage(damage_per_second)

func _get_rise_rate() -> float:
	var intensity := _cached_intensity
	if is_inside_tree():
		var gm := get_node_or_null("/root/GameManager")
		if gm:
			intensity = gm.storm_intensity
	match intensity:
		1: return rise_rate_low
		2: return rise_rate_medium
		3: return rise_rate_high
		_: return rise_rate_medium

func _on_intensity_changed(intensity: int) -> void:
	_cached_intensity = intensity
	print("[StormManager] Storm intensity set to: ", intensity)

func _on_phase_changed(new_phase: int) -> void:
	if is_inside_tree():
		var gm := get_node_or_null("/root/GameManager")
		var storm_phase = gm.StormPhase if gm else null
		if storm_phase:
			match new_phase:
				storm_phase.WARNING, storm_phase.SEVERE, storm_phase.SIRENS, storm_phase.HUNKER:
					if not _active:
						_active = true
						print("[StormManager] Flooding activated (phase: ", new_phase, ")")
				storm_phase.CALM, storm_phase.ENDED:
					if _active:
						_active = false
						print("[StormManager] Flooding paused (phase: ", new_phase, ")")
			return
	# Fallback: activate on any phase > 0
	if new_phase > 0:
		if not _active:
			_active = true
			print("[StormManager] Flooding activated (fallback, phase: ", new_phase, ")")
	else:
		if _active:
			_active = false
			print("[StormManager] Flooding paused (fallback, phase: ", new_phase, ")")

func _set_water_level(new_level: float) -> void:
	var clamped := clampf(new_level, 0.0, max_water_level)
	if not is_equal_approx(clamped, water_level):
		var was_flooding := is_flooding
		water_level = clamped
		is_flooding = water_level > 0.0
		water_level_changed.emit(water_level)
		
		if is_flooding and not was_flooding:
			flooding_started.emit()
		elif not is_flooding and was_flooding:
			flooding_ended.emit()

func bail_water() -> bool:
	if _bail_timer > 0.0:
		return false
	if water_level <= 0.0:
		return false
	
	_bail_timer = bail_cooldown
	var old_level := water_level
	_set_water_level(water_level - bail_amount)
	
	print("[StormManager] Bailed water: %.1f -> %.1f" % [old_level, water_level])
	return true

func _deal_damage(amount: int) -> void:
	player_damaged.emit(amount)
	print("[StormManager] Player damaged by flooding: -", amount, " HP")

func reset() -> void:
	_active = false
	water_level = 0.0
	is_flooding = false
	_damage_tick = 0.0
	_bail_timer = 0.0
	water_level_changed.emit(0.0)
