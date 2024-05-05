extends ProjectileBehaviour
class_name SimpleProjectileBehaviour

@export var speed: float = 1.0

func process(projectile: Projectile, delta: float) -> void:
    projectile.position += projectile.direction * speed * delta