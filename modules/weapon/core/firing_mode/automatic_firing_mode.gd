extends WeaponFiringMode
class_name AutomaticFiringMode

var firing: bool

func _on_fire_just_pressed() -> void:
    if weapon.is_reloading:
        return
    firing = true

func _on_fire_just_released() -> void:
    firing = false

func _on_fire_pressed() -> void:
    if !firing:
        return
    if weapon.fire_rate_timer.time_left > 0:
        return
    if weapon.clip.is_empty():
        dry_fire.emit()
        firing = false
    else:
        fire.emit()