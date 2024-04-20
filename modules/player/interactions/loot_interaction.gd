extends Interaction
class_name Lootable

var item: Item

func _ready() -> void:
    item = parent.get_node("Item")
    assert(item, "[Interaction] Object is Lootable but no Item was found")

func interact_start(_interactor: Interactor) -> void:
    item.loot()