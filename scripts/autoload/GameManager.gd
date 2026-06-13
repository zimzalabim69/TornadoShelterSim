# GameManager.gd
# Autoload - Global game state, storm timer, phases, and scoring

extends Node

# Storm phases
enum StormPhase {
	CALM,
	WARNING,
	SEVERE,
	SIRENS,
	HUNKER,
	ENDED
}

# Current state
var current_phase: StormPhase = StormPhase.CALM
var storm_timer: float = 0.0          # Seconds remaining until sirens
var total_prep_time: float = 18.0 * 60.0  # 18 minutes default (adjust in later steps)
var storm_intensity: int = 2          # 1=Low, 2=Medium, 3=High (set at start or random)

# Scoring (populated during hunker phase)
var prep_score: int = 0
var fortification_score: int = 0
var survival_score: int = 0

# Signals for UI and other systems
signal phase_changed(new_phase: StormPhase)
signal storm_timer_updated(remaining: float)
signal storm_intensity_set(intensity: int)

func _ready() -> void:
	storm_timer = total_prep_time
	print("[GameManager] Initialized. Prep time: ", total_prep_time / 60.0, " minutes")

func _process(delta: float) -> void:
	if current_phase == StormPhase.ENDED:
		return
	
	if current_phase < StormPhase.HUNKER:
		storm_timer -= delta
		storm_timer_updated.emit(storm_timer)
		
		# Automatic phase progression (can be overridden later)
		_update_phase_from_timer()
	
	# TODO in later steps: increase wind intensity, etc.

func _update_phase_from_timer() -> void:
	var progress := 1.0 - (storm_timer / total_prep_time)
	
	var new_phase := current_phase
	
	if progress > 0.85 and current_phase < StormPhase.SIRENS:
		new_phase = StormPhase.SIRENS
	elif progress > 0.65 and current_phase < StormPhase.SEVERE:
		new_phase = StormPhase.SEVERE
	elif progress > 0.35 and current_phase < StormPhase.WARNING:
		new_phase = StormPhase.WARNING
	
	if new_phase != current_phase:
		set_phase(new_phase)

func set_phase(new_phase: StormPhase) -> void:
	if new_phase == current_phase:
		return
	
	current_phase = new_phase
	print("[GameManager] Phase changed to: ", StormPhase.keys()[current_phase])
	phase_changed.emit(current_phase)
	
	# Future: trigger audio, visuals, etc. based on phase

func start_storm(intensity: int = -1) -> void:
	if intensity < 1:
		intensity = randi_range(1, 3)
	storm_intensity = intensity
	storm_intensity_set.emit(storm_intensity)
	
	set_phase(StormPhase.HUNKER)
	print("[GameManager] Storm started! Intensity: ", storm_intensity)

func end_game() -> void:
	set_phase(StormPhase.ENDED)
	# Calculate final score in later steps

func reset_run() -> void:
	current_phase = StormPhase.CALM
	storm_timer = total_prep_time
	prep_score = 0
	fortification_score = 0
	survival_score = 0
	# TODO: tell InventoryManager to reset
