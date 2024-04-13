extends Node3D
class_name InteractorItemHolder

@export var drop_interaction: Interaction
@export var can_drop: bool = true
@export var drop_delay: float = 0.1

var item: Node3D

func _process(_delta: float) -> void:
    if !item:
       return
    item.position = global_position
    item.rotation = global_rotation

func drop(interactor: Interactor) -> void:
    interactor.pop(drop_interaction)
    var drop_method := Callable(item, "on_drop")
    if drop_method.is_valid():
        drop_method.call()
    item.top_level = false
    item = null

func attach(interactor: Interactor, _item: Node3D) -> void:
    item = _item
    item.top_level = true
    var grab_method := Callable(item, "on_grab")
    if grab_method.is_valid():
        grab_method.call()
    if can_drop:
        await get_tree().create_timer(drop_delay).timeout
        interactor.push(drop_interaction)