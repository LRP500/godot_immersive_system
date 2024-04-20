extends Node
class_name ItemContainer

@export var content: Array[InventoryItemStack]
@export var destroy_on_empty: bool = false

@export_group("Interface")
@export var update_display_name: bool = true
@export var display_name_empty_format: String = "%s [Empty]"

var _items: Array[InventoryItem] = []

func is_empty() -> bool:
    return _items.is_empty()

func _ready() -> void:
    for stack in content:
        var item := InventoryItem.new(stack.item_model, stack.count)
        _items.append(item)

func loot() -> void:
    _loot_content()
    if item_container.is_empty() && destroy_on_empty:
        get_parent().queue_free()
    elif update_display_name:
        _update_display_name()
    
# WIP: Loot only what fits in inventory, leave the rest in the container to be looted later
func _loot_content() -> void:
    var content_size: int = _items.size()
    var looted_item_count: int = 0
    for i in range(_items.size() -1, -1, -1):
        var item := _items[i]
        if PlayerModule.player.inventory.can_add(item):
            PlayerModule.player.inventory.add_item(item)
            ArrayHelpers.swap(_items, i, _items.size() - 1)
            looted_item_count += 1
    _items.resize(content_size - looted_item_count)

func _update_display_name() -> void:
    var display_name := $"../DisplayName" as DisplayName
    if !display_name:
        return
    if is_empty():
        display_name.value = display_name_empty_format % display_name.initial_value
    else:
        display_name.reset()