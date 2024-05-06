extends Projectile
class_name RaycastProjectile

@export var draw_debug: bool = false

@onready var raycast: RayCast3D = %RayCast3D

func _process(delta: float) -> void:
    super(delta)
    if draw_debug:
        _draw_debug_ray()

func _physics_process(_delta: float) -> void:
    if raycast.is_colliding():
        print(raycast.get_collider())
        queue_free()

func _draw_debug_ray() -> void:
    var start := raycast.global_position
    var distance := raycast.target_position.length() + 0.5
    var end := start + -global_transform.basis.z * distance 
    DebugDraw3D.draw_arrow(start, end, Color.GREEN, 0.075, true)