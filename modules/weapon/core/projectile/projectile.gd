extends Node3D
class_name Projectile

var speed: float
var direction: Vector3
var behaviour: ProjectileBehaviour

func _process(_delta: float) -> void:
	behaviour.process(self, _delta)

func fire() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT