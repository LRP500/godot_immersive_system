extends Node
class_name InventoryHotbar

signal item_binded(slot: InventoryHotbarSlot)
signal item_unbinded(slot: InventoryHotbarSlot)

@export var slot_count: int = 4

var inventory: Inventory
var slots: Array[InventoryHotbarSlot] = []

func _ready() -> void:
    inventory = get_parent()
    if inventory == null:
        queue_free()
    else:
        _create_slots()
        inventory.item_added.connect(_on_item_added)
        inventory.item_removed.connect(_on_item_removed)

func _create_slots() -> void:
    for i in slot_count:
        slots.append(InventoryHotbarSlot.new())

func _on_item_added(item: InventoryItem) -> void:
    if !_is_wieldable(item):
        return
    for slot in slots:
        if slot.is_empty():
            slot.item = item
            item_binded.emit(slot)
            return

func _on_item_removed(item: InventoryItem) -> void:
    for slot in slots:
        if slot.item == item:
            slot.item = null
            item_unbinded.emit(slot)

func _is_wieldable(item: InventoryItem) -> bool:
    return item.model.get_meta("wieldable", false)

func is_empty() -> bool:
    for slot in slots:
        if !slot.is_empty():
            return false
    return true