extends Resource
class_name InventoryItemModel

@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var prefab: PackedScene

@export_multiline var properties: String = "{ }"