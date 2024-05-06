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

@export_group("Stats")
@export var fire_rate: float = 1.0
@export var reload_speed: float = 1.0
@export var clip_size: int = 1

@export_group("Firing")
@export var firing_mode: WeaponFiringMode
@export var firing_behaviour: WeaponFiringBehaviour

@export_group("Projectile")
@export var hitscan: bool = false
@export var projectile: ProjectileModel