extends RichTextLabel
class_name InteractableDescriptionView

@export var format: String = "[i]%s[/i]"

func _ready() -> void:
	InteractionSystem.interactor.target_enter.connect(_on_target_enter)
	InteractionSystem.interactor.target_exit.connect(_on_target_exit)
	_clear()

func _on_target_enter(target: Node3D, _interactions: Array[Interaction]) -> void:
	var display_desc := target.find_child("DisplayDescription", false, true) as DisplayDescription
	if !display_desc:
		return
	text = format % display_desc.value
	show()

func _on_target_exit() -> void:
	_clear()

func _clear() -> void:
	text = ""
	hide()