extends RichTextLabel
class_name InteractableNameView

@export var format: String = "[b]%s[/b]"

func _ready() -> void:
	InteractionModule.interactor.target_entered.connect(_on_target_entered)
	InteractionModule.interactor.target_exited.connect(_on_target_exited)
	_clear()

func _on_target_entered(target: Node3D, _interactions: Array[Interaction]) -> void:
	var display_name := target.find_child("DisplayName", false, true) as DisplayName
	if !display_name:
		return
	text = format % display_name.value
	show()

func _on_target_exited() -> void:
	_clear()

func _clear() -> void:
	text = ""
	hide()