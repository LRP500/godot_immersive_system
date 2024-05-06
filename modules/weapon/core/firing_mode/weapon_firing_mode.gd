# Describes the firing mode of a weapon, can be automatic, manual, burst, pulse, etc.

extends Resource
class_name WeaponFiringMode

signal fire
signal dry_fire

var weapon: Weapon

func init(_weapon: Weapon) -> void:
    weapon = _weapon
    var fire_input := InputManager.get_event("fire")
    fire_input.pressed.connect(_on_fire_pressed)
    fire_input.just_pressed.connect(_on_fire_just_pressed)
    fire_input.just_released.connect(_on_fire_just_released)
    _on_init()

func _on_init() -> void:
    pass

func _on_fire_pressed() -> void:
    pass

func _on_fire_just_pressed() -> void:
    pass

func _on_fire_just_released() -> void:
    pass