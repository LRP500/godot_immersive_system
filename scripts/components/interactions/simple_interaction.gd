extends Interaction
class_name SimpleInteraction

var interactable: Interactable

func _ready() -> void:
	interactable = parent as Interactable
	if interactable:
		interactable.state_changed.connect(_on_state_change)

func _on_state_change(_interaction_text: String) -> void:
	interaction_text = _interaction_text

func interact(interactor: Interactor) -> void:
	if interactable:
		interactable.interact(interactor)