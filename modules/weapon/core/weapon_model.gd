extends Resource
class_name WeaponModel

@export_group("General")
@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var scene: PackedScene

@export_group("Inventory")
@export var item: InventoryItemModel

@export_group("Firing Modes")
@export var firing_mode: WeaponFiringMode

@export_group("Projectile")
@export var projectile: PackedScene
@export var projectile_bejaviour: ProjectileBehaviour