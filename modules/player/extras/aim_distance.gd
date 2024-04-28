extends RayCast3D

var current: float = 0.0

func _process(_delta: float) -> void:
	if is_colliding():
		var collision_point := get_collision_point()
		current = global_position.distance_to(collision_point)
	else:
		current = 0.0
