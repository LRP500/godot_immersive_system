extends Node
class_name Weapon

var model: WeaponModel
var firing_mode: WeaponFiringMode
var fire_rate_timer: Timer

func init(_model: WeaponModel) -> void:
    await self.ready
    model = _model
    fire_rate_timer = %FireRateTimer
    fire_rate_timer.wait_time = model.fire_rate
    firing_mode = _model.firing_mode.duplicate()
    firing_mode.init(self)
    firing_mode.fire.connect(fire)

func fire() -> void:
    print("fire")