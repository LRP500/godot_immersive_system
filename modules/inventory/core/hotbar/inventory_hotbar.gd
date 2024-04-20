extends Node
class_name InventoryHotbar

signal item_binded(slot: InventoryHotbarSlot)
signal item_unbinded(slot: InventoryHotbarSlot)

@export var slot_count: int = 4
@export var allow_unselect_slot: bool = true

var _inventory: Inventory
var _item_holder: WieldableItemHolder
var _slots: Array[InventoryHotbarSlot] = []
var _selected_slot_index: int = -1

func _ready() -> void:
    _inventory = get_parent()
    assert(_inventory, "[InventoryHotbar] Inventory not found")
    var interactor := InteractionModule.interactor
    assert(interactor, "[InventoryHotbar] Interactor not found")
    _item_holder = interactor.get_node("%WieldableItemHolder")
    assert(_item_holder, "[InventoryHotbar] WieldableItemHolder not found")
    _inventory.item_added.connect(_on_item_added)
    _inventory.item_removed.connect(_on_item_removed)
    _create_slots()

func _create_slots() -> void:
    for i in slot_count:
        _slots.append(InventoryHotbarSlot.new())

func _on_item_added(item: InventoryItem) -> void:
    if !_is_wieldable(item):
        return
    for slot in _slots:
        if slot.is_empty():
            slot.item = item
            item_binded.emit(slot)
            return

func _on_item_removed(item: InventoryItem) -> void:
    for slot in _slots:
        if slot.item == item:
            slot.item = null
            item_unbinded.emit(slot)

func _is_wieldable(item: InventoryItem) -> bool:
    return item.model.get_meta("wieldable", false)

func is_empty() -> bool:
    for slot in _slots:
        if !slot.is_empty():
            return false
    return true

func get_slot(index: int) -> InventoryHotbarSlot:
    if index < 0 || index >= slot_count:
        return null
    return _slots[index]

func select_slot(new_slot_index: int) -> void:
    if new_slot_index < 0 || new_slot_index >= slot_count:
        return
    if new_slot_index == _selected_slot_index && allow_unselect_slot:
        unselect_slot()
        return
    unselect_slot()
    _selected_slot_index = new_slot_index
    var new_slot := get_slot(new_slot_index)
    new_slot.selected = true
    if new_slot.item && _is_wieldable(new_slot.item):
        _item_holder.wield(InteractionModule.interactor, new_slot.item)

func unselect_slot() -> void:
    if _selected_slot_index == -1:
        return
    var slot := get_slot(_selected_slot_index)
    slot.selected = false
    _selected_slot_index = -1
    _item_holder.unwield(InteractionModule.interactor)