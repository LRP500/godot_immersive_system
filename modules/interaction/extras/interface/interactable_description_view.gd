extends RichTextLabel
class_name InteractableDescriptionView

@export var format: String = "[i]%s[/i]"

var description: Description

func _ready() -> void:
	InteractionModule.interactor.target_entered.connect(_on_target_entered)
	InteractionModule.interactor.target_exited.connect(_on_target_exited)
	_clear()

func _on_target_entered(target: Node3D, _interactions: Array[Interaction]) -> void:
	description = target.find_child("Description", false, true) as Description
	if !description:
		return
	description.value_changed.connect(_on_description_changed)
	text = format % description.value
	show()

func _on_target_exited() -> void:
	if description:
		description.value_changed.disconnect(_on_description_changed)
	_clear()

func _clear() -> void:
	text = ""
	hide()

func _on_description_changed(value: String) -> void:
	text = format % value