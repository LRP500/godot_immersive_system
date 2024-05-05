extends Node
class_name Weapon

@onready var muzzle_origin: Node3D = %MuzzleOrigin
@onready var fire_rate_timer: Timer = %FireRateTimer

var model: WeaponModel
var firing_mode: WeaponFiringMode
var camera: Camera3D

func init(_model: WeaponModel) -> void:
    await self.ready
    model = _model
    camera = get_viewport().get_camera_3d()
    fire_rate_timer.wait_time = model.fire_rate
    firing_mode = _model.firing_mode.duplicate()
    firing_mode.init(self)
    firing_mode.fire.connect(fire)

func fire() -> void:
    print("fire")
    var shots := model.firing_behaviour.get_shots(self, camera)
    for shot in shots:
        print("origin: %s, direction: %s" % [shot.origin, shot.direction])