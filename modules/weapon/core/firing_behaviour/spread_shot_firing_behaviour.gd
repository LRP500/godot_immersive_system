extends WeaponFiringBehaviour
class_name SpreadShotFiringBehaviour

@export var spread_angle: float = 30.0
@export var projectile_count: int = 3
@export var forward_compensation: float = 0.5

func get_shots(_weapon: Weapon, origin: Vector3, direction: Vector3) -> Array[WeaponShotInfo]:
    var shots: Array[WeaponShotInfo] = []
    var spread_angle_rad := deg_to_rad(spread_angle)
    var angle := -spread_angle_rad / 2
    var increment := spread_angle_rad / (projectile_count - 1)
    for i in range(projectile_count):
        var projectile_dir := Quaternion.from_euler(Vector3(0, angle, 0)) * direction
        var projectile_origin := origin + (forward_compensation * projectile_dir)
        shots.append(WeaponShotInfo.new(projectile_origin, projectile_dir))
        angle += increment
    return shots