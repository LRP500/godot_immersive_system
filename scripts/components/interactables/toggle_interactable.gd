extends Interactable

@export var interaction_interval: float = 1
@export var initial_state: bool = false

@export_group("Targets")
@export var enable_targets: Array[Node3D]
@export var disable_targets: Array[Node3D]
@export var interact_targets: Array[Interactable]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_on: bool = false
var is_interactable: bool = true
var timer: Timer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	is_on = initial_state
	_init_timer()
	_animate()

func _init_timer() -> void:
	timer = Timer.new()
	timer.wait_time = interaction_interval
	timer.one_shot = true
	add_child(timer)

func interact(_interactor: Interactor) -> void:
	if is_interactable == false:
		return
	timer.start()
	is_on = !is_on
	is_interactable = false
	_process_targets(_interactor)
	_animate()

func _process_targets(_interactor: Interactor) -> void:
	for target in enable_targets:
		target.process_mode = Node.PROCESS_MODE_ALWAYS
		target.show()
	for target in disable_targets:
		target.process_mode = Node.PROCESS_MODE_DISABLED
		target.hide()
	for target in interact_targets:
		target.interact(_interactor)

func _animate() -> void:
	if is_on:
		animation_player.play("switch_off")
	else:
		animation_player.play("switch_on")

func _on_animation_finished(_animation_name: String) -> void:
	await timer.timeout
	is_interactable = true