extends Node
class_name InventoryHotbarSlot

signal item_changed(item: InventoryItem)
signal selected_changed(selected: bool)

var item: InventoryItem: set = _set_item
var selected: bool = false : set = _set_selected

func _set_item(value: InventoryItem) -> void:
    item = value
    item_changed.emit(value)

func _set_selected(value: bool) -> void:
    selected = value
    selected_changed.emit(value)

func is_empty() -> bool:
    return item == null