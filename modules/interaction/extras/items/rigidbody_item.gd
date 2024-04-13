extends RigidBody3D
class_name RigidbodyItem

func on_grab(_interactor: Interactor) -> void:
    linear_velocity = Vector3.ZERO
    process_mode = Node.PROCESS_MODE_DISABLED

func on_drop(_interactor: Interactor) -> void:
    linear_velocity = Vector3.ZERO
    process_mode = Node.PROCESS_MODE_INHERIT