extends Timer
class_name InteractionTimer

signal started
signal finished

@export var reset_on_release: bool = true

func get_progress_ratio() -> float:
    if is_stopped():
        return 0
    return 1 - time_left / wait_time