extends Node
class_name InventoryHotbar

signal item_added(slot: InventoryHotbarSlot)
signal item_removed(slot: InventoryHotbarSlot)

@export var slot_count: int = 4

var slots: Array[InventoryHotbarSlot] = []

func _init() -> void:
    for i in slot_count:
        slots.append(InventoryHotbarSlot.new())

func is_empty() -> bool:
    for slot in slots:
        if !slot.is_empty():
            return false
    return true