extends Object
class_name InventoryHelpers

static func is_wieldable(item: InventoryItem) -> bool:
	return item.model.get_meta("wieldable", false)