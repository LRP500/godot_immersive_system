extends Interactable

@onready var animation_tree: AnimationTree = $"../CSGBox3D/AnimationTree"

var blend_space: AnimationNodeBlendSpace1D
var is_on: bool = false

func _ready() -> void:
    animation_tree.set("parameters/blend_position", 0)

func interact(_interactor: Interactor, _interaction: Interaction) -> void:
    var tween := create_tween()
    tween.set_trans(Tween.TRANS_SPRING)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "rotation:y", deg_to_rad(360), 1.5).as_relative()

    is_on = !is_on
    var progress: float = 0
    if is_on:
        progress = 1
    animation_tree.set("parameters/blend_position", progress)

func interact_start(_interactor: Interactor, _interaction: Interaction) -> void:
    var progress: float = 0
    if is_on:
        progress = 1
    animation_tree.set("parameters/blend_position", progress)

func interact_update(_interactor: Interactor, _interaction: Interaction) -> void:
    var progress: float = _interaction.timer.get_progress_ratio()
    if is_on:
        progress = 1 - progress
    animation_tree.set("parameters/blend_position", progress)