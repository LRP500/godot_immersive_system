extends Interactable

enum ToggleState {
	OFF = 0,
	ON = 1
}

@export var interaction_interval: float = 1
@export var initial_state: ToggleState

@export_group("Targets On")
@export var enable_targets_on: Array[Node3D]
@export var disable_targets_on: Array[Node3D]
@export var interact_targets_on: Array[Interactable]
@export_group("Targets Off")
@export var enable_targets_off: Array[Node3D]
@export var disable_targets_off: Array[Node3D]
@export var interact_targets_off: Array[Interactable]
@export_group("Targets Toggle")
@export var targets: Array[NodePath]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_on: bool = false
var is_interactable: bool = true
var timer: Timer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	is_on = initial_state
	_process_targets(null, null)
	_init_timer()
	_animate()

func _init_timer() -> void:
	timer = Timer.new()
	timer.wait_time = interaction_interval
	timer.one_shot = true
	add_child(timer)

func interact(_interactor: Interactor, _interaction: Interaction) -> void:
	if is_interactable == false:
		return
	timer.start()
	is_on = !is_on
	is_interactable = false
	_process_targets(_interactor, _interaction)
	_animate()

func _process_targets(_interactor: Interactor, _interaction: Interaction) -> void:
	if is_on:
		for target in enable_targets_on:
			Node3dHelpers.enable(target)
		for target in disable_targets_on:
			Node3dHelpers.disable(target)
		for target in interact_targets_on:
			target.interact(_interactor, _interaction)
	elif !is_on:
		for target in enable_targets_off:
			Node3dHelpers.enable(target)
		for target in disable_targets_off:
			Node3dHelpers.disable(target)
		for target in interact_targets_off:
			target.interact(_interactor, _interaction)
	for target in targets:
		var node := get_node(target)
		if node.has_method("toggle"):
			@warning_ignore("unsafe_method_access")
			node.toggle(is_on)

func _animate() -> void:
	if is_on:
		animation_player.play("switch_off")
	else:
		animation_player.play("switch_on")

func _on_animation_finished(_animation_name: String) -> void:
	await timer.timeout
	is_interactable = true
