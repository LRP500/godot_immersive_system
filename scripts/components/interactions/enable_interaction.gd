extends Interaction

@export var targets: Array[Node3D]

func interact(_interactor: Interactor) -> void:
	for target in targets:
		target.process_mode = Node.PROCESS_MODE_ALWAYS
		target.show()