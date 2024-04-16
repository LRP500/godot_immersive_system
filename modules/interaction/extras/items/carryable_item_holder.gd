extends Node3D
class_name CarryableItemHolder

signal item_carried(item: Node3D)
signal item_dropped

@export var can_drop: bool = true
@export var drop_interaction: Interaction
@export var drop_delay: float = 0.1
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

func carry(interactor: Interactor, _item: Node3D) -> void:
    item = _item
    item.top_level = true
    interactor.is_raycasting = false
    item_carried.emit(item)
    var grab_method := Callable(item, "on_grab")
    if grab_method.is_valid():
        grab_method.call(interactor)
    if can_drop:
        await get_tree().create_timer(drop_delay).timeout
        interactor.push(drop_interaction)

func drop(interactor: Interactor) -> void:
    interactor.pop(drop_interaction)
    var drop_method := Callable(item, "on_drop")
    if drop_method.is_valid():
        drop_method.call(interactor)
    item_dropped.emit()
    interactor.is_raycasting = true
    item.top_level = false
    item = null