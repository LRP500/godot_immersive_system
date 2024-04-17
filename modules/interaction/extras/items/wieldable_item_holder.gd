extends Node3D
class_name WieldableItemHolder

signal item_wielded(item: Node3D)
signal item_unwielded(item: Node3D)

@export var rotate_speed: float = 2.0
@export var move_speed: float = 2.0

var item: Node3D

func _process(delta: float) -> void:
    if !item:
       return
    item.rotation.y = lerp_angle(item.rotation.y, global_rotation.y, delta * 10 * rotate_speed)
    item.rotation.x = lerp_angle(item.rotation.x, global_rotation.x, delta * 10 * rotate_speed)
    item.rotation.z = lerp_angle(item.rotation.z, global_rotation.z, delta * 10 * rotate_speed)
    item.position = item.position.slerp(global_position, delta * 10 * move_speed)

func wield(interactor: Interactor, inventory_item: InventoryItem) -> void:
    item = _create_item(inventory_item)
    assert(item, "[Inventory] Item %s not found in item atlas" % inventory_item.model.id)
    item.top_level = true
    self.add_child(item)
    item_wielded.emit(item)
    var equip_method := Callable(item, "on_equip")
    if equip_method.is_valid():
        equip_method.call(interactor)

func unwield(interactor: Interactor) -> void:
    var drop_method := Callable(item, "on_drop")
    if drop_method.is_valid():
        drop_method.call(interactor)
    item_unwielded.emit()
    item = null

func _create_item(inventory_item: InventoryItem) -> Node3D:
    var scene: PackedScene = InventoryAtlas.get_packed_scene(inventory_item.model)
    return scene.instantiate() if scene else null