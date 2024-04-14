extends Control
class_name InventoryItemView

@export var label: RichTextLabel

func bind(item: InventoryItem) -> void:
	label.text = item.to_display_name()