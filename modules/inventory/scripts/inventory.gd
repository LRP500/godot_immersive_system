extends Node
class_name Inventory

@export var initial_items: Array[InventoryItemModel] = []

var _items: Array[InventoryItem] = []

func _ready() -> void:
    for item in initial_items:
        add_item(InventoryItem.new(item))
    print("[Inventory] Item count: %s" % get_item_count())

func get_item_count() -> int:
    return _items.size()

func get_items() -> Array[InventoryItem]:
    return _items

func add_item(item: InventoryItem) -> void:
    _items.append(item)

func remove_item(item: InventoryItem) -> void:
    _items.remove_at(_items.find(item))