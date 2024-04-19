extends Interaction
class_name ContainerLootable

var item_container: ItemContainer

func _ready() -> void:
    item_container = parent.get_node("ItemContainer")
    assert(item_container, "[Interaction] Object is ContainerLootable but no ItemContainer was found")

func interact_start(_interactor: Interactor) -> void:
    item_container.loot()