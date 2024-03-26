extends Interaction
class_name SimpleInteraction

func _ready() -> void:
	parent.state_changed.connect(_on_state_change)

func _on_state_change(_interaction_text: String) -> void:
	interaction_text = _interaction_text

func interact(interactor: Interactor) -> void:
	parent.interact(interactor)