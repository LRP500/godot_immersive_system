extends Resource
class_name WeaponFiringBehaviour

class ShotInfo:
    var origin: Vector3
    var direction: Vector3

    func _init(_origin: Vector3, _direction: Vector3) -> void:
        origin = _origin
        direction = _direction

func get_shots(_weapon: Weapon, _camera: Camera3D) -> Array[ShotInfo]:
    return []