extends Node
class_name DisplayName

signal value_changed(value: String)

@export var value: String = "": set = _set_value

func _set_value(_value: String) -> void:
    value = _value
    value_changed.emit(_value)