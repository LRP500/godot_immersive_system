extends Node3D
class_name CarryableItemHolder

signal item_carried(item: Node3D)
signal item_dropped

@export var can_drop: bool = true
@export var drop_interaction: Interaction
@export var drop_delay: float = 0.1

@export_group("Animation")
@export var animate_position: bool = true
@export var animate_rotation: bool = true
@export var rotation_lerp_speed: float = 2.0
@export var position_lerp_speed: float = 2.0

var item: Node3D

func _ready() -> void:
    Global.player.item_carry.connect(carry)
    Global.player.item_drop.connect(drop)

func _process(delta: float) -> void:
    await get_tree().process_frame
    _update_transform(delta)

func _update_transform(delta: float) -> void:
    if !item:
        return
    if animate_position:
        item.position = item.position.slerp(global_position, delta * 10 * position_lerp_speed)
    else:
        item.global_position = global_position
    if animate_rotation:
        item.rotation.y = lerp_angle(item.rotation.y, global_rotation.y, delta * 10 * rotation_lerp_speed)
        item.rotation.x = lerp_angle(item.rotation.x, global_rotation.x, delta * 10 * rotation_lerp_speed)
        item.rotation.z = lerp_angle(item.rotation.z, global_rotation.z, delta * 10 * rotation_lerp_speed)
    else:
        item.global_rotation = global_rotation

func carry(carryable: Node3D) -> void:
    var interactor := Global.player.get_interactor()
    item = carryable
    item.top_level = true
    interactor.is_raycasting = false
    item_carried.emit(item)
    var grab_method := Callable(item, "on_grab")
    if grab_method.is_valid():
        grab_method.call(interactor)
    if can_drop:
        await get_tree().create_timer(drop_delay).timeout
        interactor.push(drop_interaction)

func drop() -> void:
    var interactor := Global.player.get_interactor()
    interactor.pop(drop_interaction)
    var drop_method := Callable(item, "on_drop")
    if drop_method.is_valid():
        drop_method.call(interactor)
    item_dropped.emit()
    interactor.is_raycasting = true
    item.top_level = false
    item = null