extends Node

var _items: Dictionary

func _ready() -> void:
    var children := get_children()
    for child: InventoryAtlasItem in children:
        _items[child.model] = child.scene
    print("[InventoryAtlas] Loaded %d items" % _items.size())

func get_packed_scene(model: InventoryItemModel) -> PackedScene:
    return _items.get(model)

func contains(model: InventoryItemModel) -> bool:
    return _items.has(model)

# TODO: Stack items of same type on loot
# TODO: Add configurable max stack size for each item model