extends Projectile
class_name RaycastProjectile

@onready var raycast: RayCast3D = %RayCast3D

func _physics_process(_delta: float) -> void:
    if raycast.is_colliding():
        print(raycast.get_collider())
        queue_free()

func _draw_debug_ray() -> void:
    pass