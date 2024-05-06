extends WeaponFiringMode
class_name ManualFiringMode

func _on_fire_just_pressed() -> void:
    if weapon.is_reloading:
        return
    if weapon.fire_rate_timer.time_left > 0:
        return
    if weapon.clip.is_empty():
        dry_fire.emit()
    else:
        fire.emit()