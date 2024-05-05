@tool

extends Resource
class_name WeaponModel

@export_group("General")
@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var scene: PackedScene

@export_group("Inventory")
@export var item: InventoryItemModel

@export_group("Firing Mode")
@export var firing_mode: WeaponFiringMode

@export_group("Projectile")
@export var hitscan: bool = false: set = _set_hitscan
@export var projectile: PackedScene
@export var projectile_behaviour: ProjectileBehaviour

@export_group("Stats")
@export var fire_rate: float = 1.0

func _set_hitscan(value: bool) -> void:
    hitscan = value
    notify_property_list_changed()

func _get_property_list() -> Array[Dictionary]:
    var projectile_properties_usage := PROPERTY_USAGE_DEFAULT if not projectile else PROPERTY_USAGE_STORAGE
    return [
        { "name": "projectile", "type": TYPE_OBJECT, "usage": projectile_properties_usage },
        { "name": "projectile_behaviour", "type": TYPE_OBJECT, "usage": projectile_properties_usage },
    ]