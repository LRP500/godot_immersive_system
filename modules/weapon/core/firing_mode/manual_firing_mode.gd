extends WeaponFiringMode
class_name ManualFiringMode

func _on_fire_just_pressed() -> void:
    if weapon.fire_rate_timer.time_left <= 0:
        fire.emit()