extends Interaction
class_name Lootable

@export var destroy_on_loot: bool = true
@export var update_display_name: bool = true
@export var update_description: bool = true

var item: Item

func _ready() -> void:
    item = parent.get_node("Item")
    if update_display_name:
        _update_display_name()
    if update_description:
        _update_description()

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    var inventory_item := InventoryItem.create(item.model, item.count)
    display_name.value = inventory_item.to_display_name()

func _update_description() -> void:
    var description := $"../Description" as Description
    if !description:
        return
    description.value = item.model.description

func interact(_interactor: Interactor) -> void:
    var inventory_item := InventoryItem.create(item.model, item.count)
    if !PlayerModule.player.inventory.can_add(inventory_item):
        return
    PlayerModule.player.inventory.add_item(inventory_item)
    if destroy_on_loot:
        parent.queue_free()

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass