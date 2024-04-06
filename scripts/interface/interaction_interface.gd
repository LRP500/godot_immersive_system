extends Control

@export var interaction_prompt_view: PackedScene
@export var interaction_prompt_container: Container

var interaction_prompts: Array[InteractionPromptView] = []

func _ready() -> void:
	InteractionSystem.interactor.target_enter.connect(_on_target_enter)
	InteractionSystem.interactor.target_exit.connect(_on_target_exit)

func _on_target_enter(_target: Node3D, interactions: Array[Interaction]) -> void:
	clear_prompts()
	for interaction in interactions:
		add_prompt(interaction)

func _on_target_exit() -> void:
	clear_prompts()

func add_prompt(interaction: Interaction) -> void:
	var instance := interaction_prompt_view.instantiate()
	var prompt := instance as InteractionPromptView
	assert(prompt, "[InteractionInterface] Prompt view must be an InteractionPromptView!")
	prompt.bind(interaction)
	interaction_prompts.append(prompt)
	interaction_prompt_container.add_child(prompt)

func clear_prompts() -> void:
	for prompt in interaction_prompts:
		prompt.queue_free()
	interaction_prompts.clear()