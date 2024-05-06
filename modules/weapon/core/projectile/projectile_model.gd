extends Resource
class_name ProjectileModel

@export var scene: PackedScene
@export var behaviour: ProjectileBehaviour
@export var speed: float = 1.0

func create() -> Projectile:
    var projectile := scene.instantiate() as Projectile
    projectile.process_mode = Node.PROCESS_MODE_DISABLED
    projectile.behaviour = behaviour
    projectile.speed = speed
    return projectile