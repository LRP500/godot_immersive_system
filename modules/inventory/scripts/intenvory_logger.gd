extends Node
class_name InventoryLogger

@onready var inventory: Inventory = get_parent()

func _ready() -> void:
    inventory.item_added.connect(_on_item_added)
    inventory.item_removed.connect(_on_item_removed)

func _on_item_added(item: InventoryItem) -> void:
    print("[Inventory] Item added: %s (%s) (%s)" % [item.model.display_name, item.model.id, item.count])

func _on_item_removed(item: InventoryItem) -> void:
    print("[Inventory] Item removed: %s (%s) (%s)" % [item.model.display_name, item.model.id, item.count])