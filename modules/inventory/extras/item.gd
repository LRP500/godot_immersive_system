# A node holding a reference to an inventory item model and its count.
# To be lootable, an item must have an instance of Item as child as well as a Lootable component.

extends Node
class_name Item

@export var model: InventoryItemModel
@export var count: int = 1

func _ready() -> void:
    if not InventoryModule.atlas.contains(model):
        printerr("[Item] Item %s does not exist in item atlas" % model.id)