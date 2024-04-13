extends Node3D
class_name Interactor

signal target_entered(target: Node3D, interactions: Array[Interaction])
signal target_exited
signal interaction_pushed(interactions: Interaction)

# @export var enabled: bool = true

@onready var raycast: RayCast3D = $RayCast3D
@onready var item_holder: InteractorItemHolder = %ItemHolder

var target: Node3D
var target_interactions: Array[Interaction]
var interactions: Array[Interaction]
var active_interaction: Interaction

func _ready() -> void:
    InteractionModule.register(self)

func _process(_delta: float) -> void:
    _find_target()
    _process_input()

func _find_target() -> void:
    if target&&!raycast.is_colliding():
        _clear_target()
    elif raycast.is_colliding():
        var collider: Node3D = raycast.get_collider()
        if collider != target:
            _clear_target()
            target = collider
            target_interactions = _get_child_interactions(target)
            target_entered.emit(target, target_interactions)

func _get_child_interactions(node: Node3D) -> Array[Interaction]:
    var results: Array[Interaction] = []
    for child in node.get_children():
        if child is Interaction:
            results.append(child)
    return results

func _clear_target() -> void:
    if target:
        target_exited.emit()

    if active_interaction:
        active_interaction.interact_stop(self)
        active_interaction = null
    target = null
    target_interactions.clear()

func _process_input() -> void:
    if target != null:
        _process_interactions(target_interactions)
    _process_interactions(interactions)

func _process_interactions(_interactions: Array[Interaction]) -> void:
    for interaction in _interactions:
        if !interaction.is_enabled:
            continue
        if Input.is_action_just_pressed(interaction.input_map_action):
            interaction.interact_start(self)
            active_interaction = interaction
        if Input.is_action_just_released(interaction.input_map_action):
            interaction.interact_stop(self)
            active_interaction = null

func push(interaction: Interaction) -> void:
    interactions.append(interaction)
    interaction_pushed.emit(interactions)

func pop(interaction: Interaction) -> void:
    interactions.erase(interaction)
    interaction_pushed.emit(interactions)