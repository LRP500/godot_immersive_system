extends Control
class_name InventoryHotbarView

@export var slot_view: PackedScene
@export var slot_container: Container
@export var hide_if_empty: bool = true

var hotbar: InventoryHotbar
var slot_views: Array[InventoryHotbarSlotView]

func _ready() -> void:
    _clear()
    var inventory := PlayerModule.player.inventory
    hotbar = inventory.get_node_or_null("%InventoryHotbar")
    if !hotbar:
        queue_free()
    else:
        _create_slots()
        _update()
        hotbar.item_binded.connect(_on_item_binded)
        hotbar.item_unbinded.connect(_on_item_unbinded)

func _on_item_binded(_slot: InventoryHotbarSlot) -> void:
    _update()

func _on_item_unbinded(_slot: InventoryHotbarSlot) -> void:
    _update()

func _update() -> void:
    if hide_if_empty && hotbar.is_empty():
        hide()
    else:
        show()

func _create_slots() -> void:
    for slot in hotbar._slots:
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