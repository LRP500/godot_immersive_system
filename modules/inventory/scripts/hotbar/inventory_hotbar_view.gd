extends Control
class_name InventoryHotbarView

@export var slot_view: PackedScene
@export var slot_container: Container
@export var hide_if_empty: bool = true

var inventory_hotbar: InventoryHotbar
var slot_views: Array[InventoryHotbarSlotView]

func _ready() -> void:
    _clear()
    var inventory := PlayerModule.player.inventory
    inventory_hotbar = inventory.get_node_or_null("%InventoryHotbar")
    if !inventory_hotbar:
        queue_free()
    else:
        _create_slots()
        _update()

func _update() -> void:
    if hide_if_empty && inventory_hotbar.is_empty():
        hide()
    else:
        show()

func _create_slots() -> void:
    for slot in inventory_hotbar.slots:
        var view := slot_view.instantiate() as InventoryHotbarSlotView
        view.bind(slot)
        slot_views.append(view)
        slot_container.add_child(view)

func _clear() -> void:
    for view in slot_views:
        view.free()
    for child in slot_container.get_children():
        child.queue_free()
    slot_views.clear()