@tool
extends Node3D

@export var target: Node3D

func _ready() -> void:
	_update_position()

func _physics_process(_delta: float) -> void:
	_update_position()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_update_position()

func _update_position() -> void:
	global_transform = target.global_transform
