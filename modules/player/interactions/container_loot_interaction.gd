extends Interaction
class_name ContainerLootable

@export var item_stacks: Array[InventoryItemStack]
@export var unlimited_use_count: bool = false
@export var max_use_count: int = 1
@export var destroy_on_empty: bool = false
@export var update_display_name: bool = true

var use_count: int = 0

func interact(_interactor: Interactor) -> void:
    if !unlimited_use_count && use_count >= max_use_count:
        return
    _loot_content()
    use_count += 1
    if use_count >= max_use_count && destroy_on_empty:
        parent.queue_free()
    else:
        _update_display_name()
 
func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass

func _loot_content() -> void:
   for stack in item_stacks:
        var item := InventoryItem.create(stack.item_model, stack.count)
        PlayerModule.player.inventory.add_item(item)

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    if !unlimited_use_count && use_count >= max_use_count:
        display_name.value = display_name.value + " [Empty]"
    else:
        display_name.value = display_name.value.replace(" [Empty]", "")