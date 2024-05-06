extends Projectile
class_name RaycastProjectile

@export var draw_debug: bool = false

@onready var raycast: RayCast3D = %RayCast3D

func _process(delta: float) -> void:
    super(delta)
    if raycast.is_colliding():
        queue_free()
    elif draw_debug:
        _draw_debug_ray()

func _draw_debug_ray() -> void:
    var start := raycast.global_position
    var distance := raycast.target_position.length() + 0.5
    var end := start + -global_transform.basis.z * distance 
    DebugDraw3D.draw_arrow(start, end, Color.GREEN, 0.075, true)