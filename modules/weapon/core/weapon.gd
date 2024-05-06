extends Node
class_name Weapon

@export var draw_debug: bool = false

@onready var muzzle_origin: Node3D = %MuzzleOrigin
@onready var fire_rate_timer: Timer = %FireRateTimer

var camera: Camera3D
var model: WeaponModel
var firing_mode: WeaponFiringMode
var projectile_container: Node

func init(_model: WeaponModel) -> void:
    model = _model
    await self.ready
    assert(model.firing_mode, "[Weapon] Missing firing mode for weapon '%s'." % model.id)
    assert(model.firing_behaviour, "[Weapon] Missing firing behaviour for weapon '%s'." % model.id)
    assert(model.projectile, "[Weapon] Missing projectile for weapon '%s'." % model.id)
    assert(model.projectile.scene, "[Weapon] Missing projectile scene for weapon '%s'." % model.id)
    projectile_container = get_tree().current_scene.get_node("%Projectiles")
    camera = get_viewport().get_camera_3d()
    fire_rate_timer.wait_time = model.fire_rate
    firing_mode = _model.firing_mode.duplicate()
    firing_mode.init(self)
    firing_mode.fire.connect(fire)

func fire() -> void:
    var direction := _get_direction()
    var origin := muzzle_origin.global_position
    var shots := model.firing_behaviour.get_shots(self, origin, direction)
    for shot in shots:
        var projectile := _create_projectile(shot.origin, shot.direction)
        projectile.fire()
        if draw_debug:
            _draw_shot_debug(shot.origin, shot.direction)
    fire_rate_timer.start()

func _get_direction() -> Vector3:
    var screen_position: Vector2 = camera.get_viewport().size / 2.0
    var from: Vector3 = camera.project_ray_origin(screen_position)
    var to: Vector3 = from + camera.project_ray_normal(screen_position)
    return from.direction_to(to)

func _create_projectile(origin: Vector3, direction: Vector3) -> Projectile:
    var projectile := model.projectile.create()
    projectile_container.add_child(projectile)
    projectile.global_position = origin
    projectile.direction = direction
    projectile.look_at(origin + direction, Vector3.UP)
    return projectile

func _draw_shot_debug(origin: Vector3, direction: Vector3) -> void:
    DebugDraw3D.draw_line(origin, origin + direction * camera.far, Color.GREEN, 0.1)