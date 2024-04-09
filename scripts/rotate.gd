extends Node3D

@export var direction: Vector3

func _process(delta: float) -> void:
	rotation += direction * delta