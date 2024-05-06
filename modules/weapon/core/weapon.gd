extends Node
class_name Weapon

@export var draw_debug: bool = false

@onready var muzzle_origin: Node3D = %MuzzleOrigin
@onready var fire_rate_timer: Timer = %FireRateTimer

var camera: Camera3D
var model: WeaponModel
var firing_mode: WeaponFiringMode
var container: Node

func init(_model: WeaponModel) -> void:
    await self.ready
    model = _model
    container = get_tree().current_scene.get_node("%Projectiles")
    camera = get_viewport().get_camera_3d()
    fire_rate_timer.wait_time = model.fire_rate
    firing_mode = _model.firing_mode.duplicate()
    firing_mode.init(self)
    firing_mode.fire.connect(fire)

func fire() -> void:
    var shots := model.firing_behaviour.get_shots(self, camera)
    for shot in shots:
        var projectile := _create_projectile()
        container.add_child(projectile)
        projectile.global_position = shot.origin
        projectile.direction = shot.direction
        projectile.look_at(shot.origin + shot.direction, Vector3.UP)
        if draw_debug:
            DebugDraw3D.draw_line(shot.origin, shot.origin + shot.direction * camera.far, Color.GREEN, 1)

func _create_projectile() -> Projectile:
    var instance := model.projectile.instantiate()
    assert(instance, "[Weapon] Missing projectile for weapon '%s'." % model.id)
    instance.init(model.projectile_behaviour)
    return instance