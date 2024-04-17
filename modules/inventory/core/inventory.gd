extends Node
class_name Inventory

signal item_added(item: InventoryItem)
signal item_removed(item: InventoryItem)

@export var initial_items: Array[InventoryItemModel] = []

var _items: Array[InventoryItem] = []

func _ready() -> void:
    for item in initial_items:
        add_item(InventoryItem.new(item))

func get_item_count() -> int:
    return _items.size()

func get_items() -> Array[InventoryItem]:
    return _items

func add_item(item: InventoryItem) -> void:
    _items.append(item)
    item_added.emit(item)

func add_items(items: Array[InventoryItem]) -> void:
    for item in items:
        add_item(item)

func remove_item(item: InventoryItem) -> void:
    var result := _items.find(item)
    item_removed.emit(result)
    _items.remove_at(result)