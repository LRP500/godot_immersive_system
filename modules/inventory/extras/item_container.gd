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
    if is_empty() && destroy_on_empty:
        get_parent().queue_free()
    elif update_display_name:
        _update_display_name()
    
# Tries to loot as much as possible, leaves the rest in the container.
# Fully looted stacks are moved to the end of the list and then destroyed by the resize operation.
func _loot_content() -> void:
    var content_size: int = _items.size()
    var looted_item_count: int = 0
    for i in range(_items.size() -1, -1, -1):
        var item := _items[i]
        var remaining := PlayerModule.player.inventory.try_add_item(item)
        if remaining == null:
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