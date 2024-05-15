@tool

extends Camera3D
class_name WeaponCamera

@export var player_camera: PhantomCamera3D

func _process(_delta: float) -> void:
	if not player_camera:
		return
	await get_tree().process_frame
	global_transform = player_camera.global_transform