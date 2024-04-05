extends Node3D
class_name Interaction

# signal was_interacted_with(interaction_text: String, input_map_action: String)

@export var is_enabled: bool = true
@export var interaction_text: String = "Interact"
@export var input_map_action: String = "interact"

var parent: Interactable

func _enter_tree() -> void:
    parent = get_parent() as Interactable
    assert(parent, "Parent must be an Interactable! (%s)" % get_path())

func interact(_interactor: Interactor) -> void:
    pass