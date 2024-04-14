extends Control
class_name InteractionListView

@export var interaction_prompt_view: PackedScene

var interaction_prompts: Array[InteractionListItemView] = []

func _ready() -> void:
	InteractionModule.interactor.target_entered.connect(_on_target_entered)
	InteractionModule.interactor.target_exited.connect(_on_target_exited)
	clear_prompts()

func _on_target_entered(_target: Node3D, interactions: Array[Interaction]) -> void:
	clear_prompts()
	for interaction in interactions:
		add_prompt(interaction)

func _on_target_exited() -> void:
	clear_prompts()

func add_prompt(interaction: Interaction) -> void:
	var instance := interaction_prompt_view.instantiate()
	var prompt := instance as InteractionListItemView
	assert(prompt, "[InteractionInterface] Prompt view must be an InteractionListItemView!")
	prompt.bind(interaction)
	interaction_prompts.append(prompt)
	add_child(prompt)

func clear_prompts() -> void:
	for prompt in interaction_prompts:
		prompt.queue_free()
	interaction_prompts.clear()
	# Remove potential unreferenced views
	for child in get_children():
		remove_child(child)