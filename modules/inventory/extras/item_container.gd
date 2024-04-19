extends Node
class_name ItemContainer

@export var content: Array[InventoryItemStack]
@export var unlimited_use_count: bool = false
@export var max_use_count: int = 1
@export var destroy_on_empty: bool = false

@export_group("Interface")
@export var update_display_name: bool = true

var items: Array[InventoryItem] = []
var use_count: int = 0

func _ready() -> void:
    for stack in content:
        var item := InventoryItem.new(stack.item_model, stack.count)
        items.append(item)

func loot() -> void:
    if !unlimited_use_count && use_count >= max_use_count:
        return
    _loot_content()
    use_count += 1
    if use_count >= max_use_count && destroy_on_empty:
        get_parent().queue_free()
    elif update_display_name:
        _update_display_name()

# WIP: Loot only what fits in inventory, leave the rest in the container to be looted later
func _loot_content() -> void:
    for item in items:
        if PlayerModule.player.inventory.can_add(item):
            PlayerModule.player.inventory.add_item(item)
            items.erase(item)

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    if !unlimited_use_count && use_count >= max_use_count:
        display_name.value = display_name.value + " [Empty]"
    else:
        display_name.value = display_name.value.replace(" [Empty]", "")