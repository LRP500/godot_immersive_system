extends Node3D
class_name InteractorItemHolder

@export var drop_interaction: Interaction
@export var can_drop: bool = true
@export var drop_delay: float = 0.1

var item: Node3D: set = _set_item

func _ready() -> void:
    # drop_interaction.process_mode = Node.PROCESS_MODE_DISABLED
    pass

func _set_item(new_item: Node3D) -> void:
    item = new_item
    if !item:
       return
    # if can_drop:
    #    drop_interaction.process_mode = Node.PROCESS_MODE_ALWAYS
    # item.on_pick_up()

func _process(_delta: float) -> void:
    if !item:
       return
    item.position = global_position
    item.rotation = global_rotation

func drop(interactor: Interactor) -> void:
    # drop_interaction.process_mode = Node.PROCESS_MODE_DISABLED
    # item.on_drop()
    interactor.pop(drop_interaction)
    item.top_level = false
    if item is RigidBody3D:
        item.custom_integrator = false
    item = null

func attach(interactor: Interactor, _item: Node3D) -> void:
    item = _item
    item.top_level = true
    if item is RigidBody3D:
        item.custom_integrator = true
    if can_drop:
        await get_tree().create_timer(drop_delay).timeout
        interactor.push(drop_interaction)