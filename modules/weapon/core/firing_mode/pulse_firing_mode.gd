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
    pulse_timer.start()

func _on_fire_just_released() -> void:
    pulse_timer.stop()

func _on_pulse_timer_timeout() -> void:
    fire.emit()