extends RichTextLabel
class_name InteractableNameView

@export var format: String = "[b]%s[/b]"

func _ready() -> void:
	InteractionSystem.interactor.target_enter.connect(_on_target_enter)
	InteractionSystem.interactor.target_exit.connect(_on_target_exit)
	_clear()

func _on_target_enter(target: Node3D, _interactions: Array[Interaction]) -> void:
	var display_name := target.find_child("DisplayName", false, true) as DisplayName
	if !display_name:
		return
	text = format % display_name.value
	show()

func _on_target_exit() -> void:
	_clear()

func _clear() -> void:
	text = ""
	hide()