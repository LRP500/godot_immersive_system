extends Interaction
class_name ContainerLootInteraction

@export var item_stacks: Array[InventoryItemStack]
@export var destroy_on_loot: bool = false
@export var update_display_name: bool = true

var is_empty: bool = true

func interact(_interactor: Interactor) -> void:
    for stack in item_stacks:
        var item := InventoryItem.create(stack.item_model, stack.count)
        PlayerModule.player.inventory.add_item(item)
    if destroy_on_loot:
        parent.queue_free()
    _update_display_name()

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    if is_empty:
        display_name.value = display_name.value + " [Empty]"
    else:
        display_name.value = display_name.value.replace(" [Empty]", "")

# TODO: Add option to allow/disallow unlimited looting (i.e. infinite ammo refill container)