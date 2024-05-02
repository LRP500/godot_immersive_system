extends Node3D

@export var target: Node3D
@export var camera: PhantomCamera3D

func _ready() -> void:
	top_level = true	

func _process(_delta: float) -> void:
	global_transform = target.global_transform