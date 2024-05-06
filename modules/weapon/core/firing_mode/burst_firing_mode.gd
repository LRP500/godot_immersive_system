extends WeaponFiringMode
class_name BurstFiringMode

@export var burst_size: int = 3
@export var burst_speed: float = 0.25

var burst_timer: Timer
var current_burst_size: int = 0

func _on_init() -> void:
    burst_timer = Timer.new()
    burst_timer.wait_time = burst_speed / burst_size
    burst_timer.one_shot = false
    weapon.add_child(burst_timer)
    burst_timer.timeout.connect(_on_burst_timer_timeout)

func _on_fire_just_pressed() -> void:
    if weapon.is_reloading:
        return
    if weapon.fire_rate_timer.time_left > 0:
        return
    if weapon.clip.is_empty():
        dry_fire.emit()
    else:
        fire.emit()
        current_burst_size = 1
        burst_timer.start()

func _on_burst_timer_timeout() -> void:
    if weapon.clip.is_empty():
        burst_timer.stop()
        dry_fire.emit()
    else:
        fire.emit()
        current_burst_size += 1
        if current_burst_size >= burst_size:
            burst_timer.stop()
