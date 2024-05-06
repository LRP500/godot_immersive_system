extends Node
class_name ShapecastProjectile

@onready var shapecast: ShapeCast3D = %ShapeCast3D

func _physics_process(_delta: float) -> void:
    if shapecast.is_colliding():
        queue_free()