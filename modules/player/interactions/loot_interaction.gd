extends Interaction
class_name LootInteraction

@export var item_model: InventoryItemModel

func interact(_interactor: Interactor) -> void:
    var item: InventoryItem = InventoryItem.new(item_model)
    PlayerModule.player.inventory.add_item(item)
    parent.queue_free()

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass