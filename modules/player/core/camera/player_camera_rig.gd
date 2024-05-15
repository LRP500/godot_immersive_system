extends Node3D

@export var target: Node3D

@onready var camera: PhantomCamera3D = %PlayerCamera

func _ready() -> void:
	top_level = true	

func _process(_delta: float) -> void:
	global_transform = target.global_transform