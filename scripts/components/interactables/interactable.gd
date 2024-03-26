extends Node3D
class_name Interactable

signal state_changed(interaction_text: String)

# func _ready() -> void:
#     if get_collision_layer() & 2 == 0:
#         printerr("[Interactable] Interactable body is not in the desired collision layer! (%s)" % get_path())

func interact(_interactor: Interactor) -> void:
    pass