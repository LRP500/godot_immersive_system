extends Interactable

@export_group("Targets")
@export var enable_targets: Array[Node3D]
@export var disable_targets: Array[Node3D]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_on: bool = false

func interact(_interactor: Interactor) -> void:
	_process_targets()
	animation_player.play("switch_on")
	is_on = true

func _process_targets() -> void:
	for target in enable_targets:
		target.process_mode = Node.PROCESS_MODE_ALWAYS
		target.show()
	for target in disable_targets:
		target.process_mode = Node.PROCESS_MODE_DISABLED
		target.hide()