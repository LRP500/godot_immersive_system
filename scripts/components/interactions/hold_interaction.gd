extends Interaction
class_name HoldInteraction

signal interact_started
signal interact_finished
signal interact_cancelled

@export var hold_duration: float = 1.0

var timer: Timer
var is_held: bool = false

func _ready() -> void:
	_init_timer()

func _init_timer() -> void:
	timer = Timer.new()
	timer.wait_time = hold_duration
	timer.one_shot = true
	add_child(timer)

func _start_interact() -> void:
	is_held = true
	timer.start()

func _on_interact_finished() -> void:
	is_held = false
	timer.stop()

func _cancel_interact() -> void:
	is_held = false
	timer.stop()

func interact(_interactor: Interactor) -> void:
	if !is_held:
		_start_interact()

func get_timer_ratio() -> float:
	if timer.is_stopped():
		return 0
	return timer.time_left / hold_duration