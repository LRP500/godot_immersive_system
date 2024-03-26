extends Interactable

@export var unlimited_use_count: bool = true
@export var max_use_count: int = 0
@export var interaction_interval: float = 1

@export_group("Targets")
@export var enable_targets: Array[Node3D]
@export var disable_targets: Array[Node3D]
@export var interact_targets: Array[Interactable]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var use_count: int = 0
var is_interactable: bool = true
var timer: Timer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	_init_timer()

func _init_timer() -> void:
	timer = Timer.new()
	timer.wait_time = interaction_interval
	timer.one_shot = true
	add_child(timer)

func interact(_interactor: Interactor) -> void:
	if is_interactable == false:
		return
	if _has_reached_max_use_count():
		is_interactable = false
		return
	timer.start()
	use_count += 1
	is_interactable = false
	_process_targets(_interactor)
	_animate()

func _has_reached_max_use_count() -> bool:
	if unlimited_use_count:
		return false
	return use_count >= max_use_count

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
	animation_player.play("switch_on")

func _on_animation_finished(_animation_name: String) -> void:
	if _animation_name == "switch_on" && !_has_reached_max_use_count():
		await timer.timeout
		animation_player.play("switch_off")
	elif _animation_name == "switch_off":
		is_interactable = true
			