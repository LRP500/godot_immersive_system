extends Node3D
class_name Projectile

var direction: Vector3
var behaviour: ProjectileBehaviour

func init(_behaviour: ProjectileBehaviour) -> void:
	behaviour = _behaviour.duplicate()

func _process(_delta: float) -> void:
	behaviour.process(self, _delta)