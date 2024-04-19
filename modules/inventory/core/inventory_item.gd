extends RefCounted
class_name InventoryItem

var model: InventoryItemModel
var count: int = 1

func _init(_model: InventoryItemModel, _count: int = 1) -> void:
    self.model = _model
    self.count = _count

static func create(_model: InventoryItemModel, _count: int) -> InventoryItem:
    var item := InventoryItem.new(_model)
    item.count = _count
    return item

func to_display_name() -> String:
    return model.display_name if count == 1 else "%s (%d)" % [model.display_name, count]

func is_stack_full() -> bool:
    if model.max_stack_size == -1:
        return false
    return count >= model.max_stack_size