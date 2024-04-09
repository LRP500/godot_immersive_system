extends RefCounted
class_name InventoryItem

var model: InventoryItemModel
var count: int = 1

func _init(_model: InventoryItemModel) -> void:
    self.model = _model