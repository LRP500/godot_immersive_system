extends RigidBody3D
class_name Item

func on_grab() -> void:
    linear_velocity = Vector3.ZERO
    process_mode = Node.PROCESS_MODE_DISABLED

func on_drop() -> void:
    linear_velocity = Vector3.ZERO
    process_mode = Node.PROCESS_MODE_INHERIT