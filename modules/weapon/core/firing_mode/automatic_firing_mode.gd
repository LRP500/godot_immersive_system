extends WeaponFiringMode
class_name AutomaticFiringMode

func _on_fire_pressed() -> void:
    if weapon.fire_rate_timer.time_left <= 0:
        fire.emit()