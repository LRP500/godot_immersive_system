extends WeaponFiringMode
class_name ManualFiringMode

func _on_fire_just_pressed() -> void:
    fire.emit()