extends WeaponFiringBehaviour
class_name SingleShotFiringBehaviour

func get_shots(_weapon: Weapon, origin: Vector3, direction: Vector3) -> Array[WeaponShotInfo]:
    return [ WeaponShotInfo.new(origin, direction) ]