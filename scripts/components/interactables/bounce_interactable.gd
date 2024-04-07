extends Interactable
class_name BounceInteractable

signal interaction_finished

@export var duration: float = 1.0
@export var target_value: Vector3 = Vector3(2, 2, 2)

func interact(_interactor: Interactor, _interaction: Interaction) -> void:
	var initial_value := scale
	var tween := get_tree().create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", target_value, duration)
	tween.tween_property(self, "scale", initial_value, duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	interaction_finished.emit()