extends Node
class_name Description

signal value_changed(value: String)

@export_multiline var initial_value: String

@onready var value: String = initial_value : set = _set_value

func _set_value(_value: String) -> void:
    value = _value
    value_changed.emit(value)

func reset() -> void:
    _set_value(initial_value)