extends Node3D

@export var target: Node3D

@onready var player_camera: PhantomCamera3D = %PlayerCamera
@onready var weapon_camera: Camera3D = %WeaponCamera

func _ready() -> void:
	top_level = true	

func _process(_delta: float) -> void:
	global_transform = target.global_transform