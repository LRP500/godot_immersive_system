extends Node
class_name InventoryHotbarSlot

signal item_changed(item: InventoryItem)

var item: InventoryItem: set = _set_item

func _set_item(value: InventoryItem) -> void:
    item = value
    item_changed.emit(value)

func is_empty() -> bool:
    return item == null