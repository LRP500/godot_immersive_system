extends Interaction
class_name LootInteraction

@export var item_model: InventoryItemModel
@export var count: int = 1
@export var update_display_name: bool = true

var item: InventoryItem

func _ready() -> void:
    item = InventoryItem.create(item_model, count)
    if update_display_name:
        _update_display_name()

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    display_name.value = item.to_display_name()

func interact(_interactor: Interactor) -> void:
    PlayerModule.player.inventory.add_item(item)
    parent.queue_free()

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass