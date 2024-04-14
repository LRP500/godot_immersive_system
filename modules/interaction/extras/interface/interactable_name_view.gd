extends RichTextLabel
class_name InteractableNameView

@export var format: String = "[b]%s[/b]"

var display_name: DisplayName

func _ready() -> void:
	InteractionModule.interactor.target_entered.connect(_on_target_entered)
	InteractionModule.interactor.target_exited.connect(_on_target_exited)
	_clear()

func _on_target_entered(target: Node3D, _interactions: Array[Interaction]) -> void:
	display_name = target.find_child("DisplayName", false, true)
	if !display_name:
		return
	display_name.value_changed.connect(_on_display_name_changed)
	text = format % display_name.value
	show()

func _on_target_exited() -> void:
	if display_name:
		display_name.value_changed.disconnect(_on_display_name_changed)
	_clear()

func _clear() -> void:
	text = ""
	hide()

func _on_display_name_changed(value: String) -> void:
	text = format % value