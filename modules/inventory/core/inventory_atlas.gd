extends Resource
class_name InventoryAtlas

@export var _items: Dictionary

func contains(model: InventoryItemModel) -> bool:
	return _items.has(model)

func get_packed_scene(model: InventoryItemModel) -> PackedScene:
	return _items.get(model)