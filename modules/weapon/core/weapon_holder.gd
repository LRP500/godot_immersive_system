extends Node3D
class_name WeaponHolder

var weapon: Node3D

func _ready() -> void:
    Global.player.weapon_equip.connect(equip)
    Global.player.weapon_unequip.connect(unequip)

func _process(_delta: float) -> void:
    await get_tree().process_frame
    _update_transform()
    _handle_input()

func _update_transform() -> void:
    if weapon:
        weapon.global_transform = global_transform

func _handle_input() -> void:
    if weapon && InputManager.is_action_pressed("fire"):
        weapon.fire()

func _create_item(model: WeaponModel) -> Node3D:
    assert(model.scene, "[WeaponHolder] Missing scene for weapon '%s'" % model.id)
    return model.scene.instantiate()

func equip(model: WeaponModel) -> void:
    if weapon:
        unequip()
    weapon = _create_item(model)
    weapon.top_level = true
    add_child(weapon)
    var equip_method := Callable(weapon, "on_equip")
    if equip_method.is_valid():
        equip_method.call(Global.player.get_interactor())

func unequip() -> void:
    if !weapon:
        return
    var unequip_method := Callable(weapon, "on_unequip")
    if unequip_method.is_valid():
        unequip_method.call(Global.player.get_interactor())
    weapon.queue_free()
    weapon = null