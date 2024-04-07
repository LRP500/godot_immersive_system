extends Timer
class_name InteractionHoldTimer

@export var reset_on_release: bool = true

func _init() -> void:
    one_shot = false

func _ready() -> void:
    var interaction := get_parent() as Interaction
    interaction.interrupted.connect(_on_interrupted)
    interaction.started.connect(_on_started)

func _on_interrupted() -> void:
    if reset_on_release:
        stop()
    else:
        paused = true

func _on_started() -> void:
    if !reset_on_release && paused:
        paused = false
    else:
        start()

func _on_timeout() -> void:
    paused = false

func get_progress_ratio() -> float:
    if is_stopped():
        return 0
    return 1 - time_left / wait_time