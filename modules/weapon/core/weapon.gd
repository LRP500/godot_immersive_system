extends Node
class_name Weapon

@onready var muzzle_origin: Node3D = %MuzzleOrigin
@onready var fire_rate_timer: Timer = %FireRateTimer

var camera: Camera3D
var model: WeaponModel
var firing_mode: WeaponFiringMode

func init(_model: WeaponModel) -> void:
    await self.ready
    model = _model
    camera = get_viewport().get_camera_3d()
    fire_rate_timer.wait_time = model.fire_rate
    firing_mode = _model.firing_mode.duplicate()
    firing_mode.init(self)
    firing_mode.fire.connect(fire)

func fire() -> void:
    var shots := model.firing_behaviour.get_shots(self, camera)
    for shot in shots:
        var projectile := _create_projectile(shot.origin, shot.direction)
        add_child(projectile)
        projectile.top_level = true
        projectile.global_position = shot.origin
        projectile.direction = shot.direction

func _create_projectile(position: Vector3, direction: Vector3) -> Projectile:
    var instance := model.projectile.instantiate()
    assert(instance, "[Weapon] Missing projectile for weapon '%s'." % model.id)
    instance.init(model.projectile_behaviour)
    return instance