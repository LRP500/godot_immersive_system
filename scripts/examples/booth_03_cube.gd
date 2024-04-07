extends Interactable

@onready var animation_tree: AnimationTree = $"../CSGBox3D/AnimationTree"

var blend_space: AnimationNodeBlendSpace1D

func _ready() -> void:
    animation_tree.set("parameters/blend_position", 0)

func interact(_interactor: Interactor) -> void:
    var tween := create_tween()
    tween.set_trans(Tween.TRANS_BACK)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "rotation:y", deg_to_rad(360), 2.5).as_relative()
    animation_tree.set("parameters/blend_position", 1)

func interact_start(_interactor: Interactor) -> void:
    animation_tree.set("parameters/blend_position", 0)

func interact_stop(_interactor: Interactor) -> void:
    pass

func _process(_delta: float) -> void:
    # animation_tree.set("parameters/blend_position", 1)
    pass