extends Resource
class_name InventoryItemModel

@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var stackable: bool = false
@export var max_stack_size: int = -1
@export var max_capacity: int = -1

@export_group("Additional Settings")
@export_multiline var properties: String = "{ }"

func get_property_dict() -> Dictionary:
    var json: JSON = JSON.new()
    var result: int = json.parse(properties)
    if result == OK:
        var data: Variant = json.data
        if typeof(data) != TYPE_DICTIONARY:
            printerr("[InventoryItemModel] Unexpected data type: %s" % [typeof(data)])
            return {}
        return data
    else:
        printerr("[InventoryItemModel] JSON Parse Error: %s in %s at line %s" 
            % [json.get_error_message(), properties, json.get_error_line()])
    return {}

func has_tag(tag: String) -> bool:
    var tags: PackedStringArray = get_meta("tags", PackedStringArray())
    if tags == null:
        return false
    return tags.has(tag)