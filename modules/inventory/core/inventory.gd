extends Node
class_name Inventory

signal item_added(item: InventoryItem)
signal item_removed(item: InventoryItem)

@export var initial_items: Array[InventoryItemModel] = []

var _items: Array[InventoryItem] = []

func _ready() -> void:
    for item in initial_items:
        add_item(InventoryItem.new(item))

func get_items() -> Array[InventoryItem]:
    return _items

func can_add(item: InventoryItem) -> bool:
    if item.model.max_capacity == -1:
        return true
    elif _get_item_count(item) < item.model.max_capacity:
        return true
    return false

# OPTIMIZE: Minimize array filtering by caching result
func add_item(item: InventoryItem) -> void:
    if item.model.stackable:
        var free_stack := _get_free_stack(item)
        if free_stack == null:
            _items.append(item)
        else:
           _add_to_stack(free_stack, item.count)
    else:
        _items.append(item)
    item_added.emit(item)

func _add_to_stack(stack: InventoryItem, count: int) -> void:
    var max_size := stack.model.max_stack_size
    if max_size == -1 || stack.count + count <= max_size:
        stack.count += count
    else:
        var free_space := max_size - stack.count
        if count <= free_space:
            stack.count += count
        else:
            stack.count += free_space
            var surplus := InventoryItem.new(stack.model, count - free_space)
            add_item(surplus)

func add_items(items: Array[InventoryItem]) -> void:
    for item in items:
        add_item(item)

func remove_item(item: InventoryItem) -> void:
    var result := _items.find(item)
    item_removed.emit(result)
    _items.remove_at(result)

func _get_free_stack(item: InventoryItem) -> InventoryItem:
    var stacks := _get_stacks(item)
    if stacks.is_empty():
        return null
    var stack_index: InventoryItem = ArrayHelpers.first(stacks,
        func(x: InventoryItem) -> bool: return !x.is_stack_full(), null)
    if stack_index:
        return stack_index
    return null

func _get_stacks(item: InventoryItem) -> Array[InventoryItem]:
    return _items.filter(func(x: InventoryItem) -> bool: return x.model == item.model)

func _get_item_count(item: InventoryItem) -> int:
    var stacks := _get_stacks(item)
    var count: int = 0
    for stack in stacks:
        count += stack.count
    return count