extends Node
class_name PlayerMenu

signal open_state_changed(is_open: bool)

var is_open: bool = false : set = _set_is_open 

func _process(_delta: float) -> void:
    if InputActionMapManager.is_action_just_pressed("player_menu"):
        is_open = !is_open

func _set_is_open(_is_open: bool) -> void:
    is_open = _is_open
    open_state_changed.emit(is_open)
    _update_action_map()

func _update_action_map() -> void:
    var action_map_name := "menu" if is_open else "gameplay"
    InputActionMapManager.enable(action_map_name)