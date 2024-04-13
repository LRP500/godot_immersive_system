extends Node3D
class_name InteractorItemHolder

@export var drop_interaction: Node
@export var can_drop: bool = true

var item: Node3D: set = _set_item

func _ready() -> void:
    # drop_interaction.process_mode = Node.PROCESS_MODE_DISABLED
    pass

func _set_item(new_item: Node3D) -> void:
    item = new_item
    item.top_level = true
    if !item:
       return
    # if can_drop:
    #    drop_interaction.process_mode = Node.PROCESS_MODE_ALWAYS
    # item.on_pick_up()

func drop() -> void:
    # drop_interaction.process_mode = Node.PROCESS_MODE_DISABLED
    # item.on_drop()
    item.top_level = false
    item = null

func _process(_delta: float) -> void:
    if !item:
       return
    item.position = global_position
    item.rotation = global_rotation