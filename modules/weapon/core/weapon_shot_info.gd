extends RefCounted
class_name WeaponShotInfo

var origin: Vector3
var direction: Vector3

func _init(_origin: Vector3, _direction: Vector3) -> void:
    origin = _origin
    direction = _direction