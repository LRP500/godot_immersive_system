extends Node
class_name InventoryItemListView

@export var item_view: PackedScene

var item_views: Array[InventoryItemView] = []

@onready var empty_label: RichTextLabel = $EmptyLabel

func bind(items: Array[InventoryItem]) -> void:
	clear()
	empty_label.visible = items.is_empty()
	for item in items:
		var view := item_view.instantiate() as InventoryItemView
		view.bind(item)
		add_child(view)

func clear() -> void:
	for view in item_views:
		view.queue_free()
	item_views.clear()

# BUG: VBoxContainer expands from the middle instead of the bottom
# TODO: Make VBoxContainer scrollable