extends Control
class_name InventoryView

@onready var item_list_view: InventoryItemListView = %ItemListView

func _on_visibility_changed() -> void:
	if !visible:
		_clear()
	elif PlayerModule.player != null:
		_refresh()

func _refresh() -> void:
	var inventory := PlayerModule.player.inventory
	item_list_view.bind(inventory.get_items())

func _clear() -> void:
	item_list_view.clear()