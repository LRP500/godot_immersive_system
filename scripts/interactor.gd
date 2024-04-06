extends Node3D
class_name Interactor

signal target_entered(target: Node3D, interactions: Array[Interaction])
signal target_exited

signal interact_started
signal interact_stopped

@onready var raycast: RayCast3D = $RayCast3D

var target: Node3D
var target_interactions: Array[Interaction]

func _ready() -> void:
    InteractionSystem.register(self)

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
            target_entered.emit(target, target_interactions)

func get_child_interactions(node: Node3D) -> Array[Interaction]:
    var interactions: Array[Interaction] = []
    for child in node.get_children():
        if child is Interaction:
            interactions.append(child)
    return interactions

func clear_target() -> void:
    if target:
        target_exited.emit()
    target = null
    target_interactions.clear()

func process_input() -> void:
    if target == null:
        return
    for interaction in target_interactions:
        if !interaction.is_enabled:
            continue
        if Input.is_action_just_pressed(interaction.input_map_action):
            interact_started.emit()
            interaction.start_interact(self)
        elif Input.is_action_just_released(interaction.input_map_action):
            interact_stopped.emit()
            interaction.stop_interact(self)
