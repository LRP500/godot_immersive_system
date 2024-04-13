@tool
extends Node3D

@export var target: Node3D

func _process(_delta: float) -> void:
	_update_position()

func _update_position() -> void:
	global_transform = target.global_transform
