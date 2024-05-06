extends WeaponFiringMode
class_name PulseFiringMode

@export var charge_time: float = 1.0

var pulse_timer: Timer

func _on_init() -> void:
    pulse_timer = Timer.new()
    pulse_timer.one_shot = true
    pulse_timer.wait_time = charge_time
    weapon.add_child(pulse_timer)
    pulse_timer.timeout.connect(_on_pulse_timer_timeout)

func _on_fire_just_pressed() -> void:
    if weapon.is_reloading:
        return
    if weapon.fire_rate_timer.time_left > 0:
        return
    if weapon.clip.is_empty():
        dry_fire.emit()
    else:
        pulse_timer.start()

func _on_fire_just_released() -> void:
    pulse_timer.stop()

func _on_pulse_timer_timeout() -> void:
    fire.emit()