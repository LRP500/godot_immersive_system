extends Node3D
class_name Interactor

signal target_enter(target: Node3D)
signal target_exit
signal cancellable

@onready var raycast: RayCast3D = $RayCast3D

var target: Node3D
var target_interactions: Array[Interaction]

func _process(_delta: float) -> void:
    find_target()
    process_input()

func find_target() -> void:
    if target && !raycast.is_colliding():
        clear_target()
    elif raycast.is_colliding():
        var collider: Node3D = raycast.get_collider()
        if collider != target:
            clear_target()
            target = collider
            target_interactions = get_child_interactions(target)
            target_enter.emit(target)

func get_child_interactions(node: Node3D) -> Array[Interaction]:
    var interactions: Array[Interaction] = []
    for child in node.get_children():
        if child is Interaction:
            interactions.append(child)
    return interactions

func clear_target() -> void:
    if target:
        target_exit.emit()
    target = null
    target_interactions.clear()

func process_input() -> void:
    if target == null:
        return
    for interaction in target_interactions:
        if !interaction.is_enabled:
            continue
        if Input.is_action_just_pressed(interaction.input_map_action):
            interaction.interact(self)