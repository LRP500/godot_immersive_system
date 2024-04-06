extends Control
class_name InteractionListItemView

@export var input_key: RichTextLabel
@export var interaction_name: RichTextLabel
@export var progress_bar: ProgressBar
@export var progress_percentage: ProgressBar
@export var input_key_format: String = "[%s]"

var interaction: Interaction

func bind(_interaction: Interaction) -> void:
	self.interaction = _interaction
	input_key.text = input_key_format % _get_keycode_string(interaction.input_map_action)
	interaction_name.text = interaction.interaction_text
	interaction.started.connect(_on_interaction_started)
	interaction.ended.connect(_on_interaction_ended)

func _process(_delta: float) -> void:
	if interaction && interaction.timer:
		progress_percentage.value = interaction.timer.get_progress_ratio()
		progress_bar.value = interaction.timer.get_progress_ratio()

func _on_interaction_started() -> void:
	progress_percentage.visible = true
	progress_bar.visible = true

func _on_interaction_ended() -> void:
	progress_percentage.visible = false
	progress_bar.visible = false

func _action_exists(action_name: String) -> bool:
	return InputMap.has_action(action_name)

func _get_keycode_string(action_name: String) -> String:
	if !_action_exists(action_name):
		return "(UNSET)"
	var events := InputMap.action_get_events(action_name)
	if events.is_empty():
		return "(UNSET)"
	var input_event_key := events[0] as InputEventKey
	if input_event_key:
		return input_event_key.as_text_physical_keycode()
	return input_event_key.as_text()
