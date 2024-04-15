extends Resource
class_name InventoryItemModel

@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var prefab: PackedScene

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