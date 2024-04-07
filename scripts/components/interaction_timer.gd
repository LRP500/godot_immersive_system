extends Timer
class_name InteractionHoldTimer

@export var reset_on_release: bool = true

func _init() -> void:
    one_shot = false

func resume() -> void:
    if !reset_on_release && paused:
        paused = false
    else:
        start()

func get_progress_ratio() -> float:
    if is_stopped():
        return 0
    return 1 - time_left / wait_time

func _on_timeout() -> void:
    paused = false