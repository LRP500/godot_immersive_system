extends ProjectileBehaviour
class_name SimpleProjectileBehaviour

func process(projectile: Projectile, delta: float) -> void:
    projectile.position += projectile.direction * projectile.speed * delta