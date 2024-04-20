# A node holding a reference to an inventory item model and its count.
# To be lootable, an item must have an instance of Item as child as well as a Lootable component.

extends Node
class_name Item

@export var model: InventoryItemModel
@export var count: int = 1
@export var destroy_on_loot: bool = true

@export_group("Interface")
@export var update_display_name: bool = true
@export var update_description: bool = true

func _ready() -> void:
    if not InventoryAtlas.contains(model):
        printerr("[Item] Item %s does not exist in item atlas" % model.id)
    if update_display_name:
        _update_display_name()
    if update_description:
        _update_description()

func loot() -> void:
    var item := InventoryItem.create(model, count)
    if PlayerModule.player.inventory.can_add(item):
        PlayerModule.player.inventory.add_item(item)
    if destroy_on_loot:
        get_parent().queue_free()

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    await display_name.ready
    var inventory_item := InventoryItem.create(model, count)
    display_name.value = inventory_item.to_display_name()

func _update_description() -> void:
    var description := $"../Description" as Description
    if !description:
        return
    await description.ready
    description.value = model.description