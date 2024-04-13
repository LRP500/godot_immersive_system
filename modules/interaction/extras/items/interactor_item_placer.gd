extends Node3D
class_name InteractorItemPlacer

@export var is_enabled: bool = true: set = _set_is_enabled
@export var item_holder: InteractorItemHolder
@export var ghost_material: Material

@onready var raycaster: RayCast3D = $RayCast3D

var item_ghost: Node3D

func _init() -> void:
    process_mode = Node.PROCESS_MODE_DISABLED

func _ready() -> void:
    item_holder.item_attached.connect(_on_item_attached)
    item_holder.item_dropped.connect(_on_item_dropped)

func _process(_delta: float) -> void:
    if !raycaster.is_colliding():
        item_ghost.visible = false
        return
    var is_surface := raycaster.get_collision_normal() == Vector3.UP
    if is_surface:
        item_ghost.visible = true
        item_ghost.rotation = Vector3.ZERO
        item_ghost.position = raycaster.get_collision_point()
    else:
        item_ghost.visible = is_surface

func _set_is_enabled(_is_enabled: bool) -> void:
    is_enabled = _is_enabled
    if item_holder && item_holder.item:
        _on_item_attached(item_holder.item)

func _on_item_attached(item: Node3D) -> void:
    if !is_enabled:
        return
    _create_ghost(item)
    process_mode = Node.PROCESS_MODE_INHERIT

func _on_item_dropped() -> void:
    process_mode = Node.PROCESS_MODE_DISABLED
    if item_ghost:
        item_ghost.queue_free()
        item_ghost = null

func _create_ghost(item: Node3D) -> void:
    item_ghost = item.duplicate()
    item_ghost.visible = false
    item_ghost.process_mode = Node.PROCESS_MODE_DISABLED
    var meshes := Node3dHelpers.get_children_of_type(item_ghost, "GeometryInstance3D")
    for mesh in meshes:
        var geometry_instance := mesh as GeometryInstance3D
        geometry_instance.material_override = ghost_material
    add_child(item_ghost)