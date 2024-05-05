extends WeaponFiringBehaviour
class_name SingleShotFiringBehaviour

func get_shots(weapon: Weapon, camera: Camera3D) -> Array[ShotInfo]:
    var screen_position: Vector2 = camera.get_viewport().size / 2.0
    var from: Vector3 = camera.project_ray_origin(screen_position)
    var to: Vector3 = from + camera.project_ray_normal(screen_position)
    var direction := from.direction_to(to)
    return [ShotInfo.new(weapon.muzzle_origin.global_position, direction)]