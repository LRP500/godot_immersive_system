extends Control
class_name InventoryHotbarSlotView

@export var count_label: RichTextLabel

var slot: InventoryHotbarSlot

func bind(_slot: InventoryHotbarSlot) -> void:
    if slot:
        slot.item_changed.disconnect(_on_item_changed)
    slot = _slot
    slot.item_changed.connect(_on_item_changed)
    _on_item_changed(slot.item)

func _on_item_changed(item: InventoryItem) -> void:
    if !item || item.count <= 0:
        _clear_content()
        return
    count_label.text = str(slot.item.count)
    count_label.show()

func _clear_content() -> void:
    count_label.text = ""
    count_label.hide()