extends InputActionMapEvent
class_name InputActionMapKeyEvent

signal pressed
signal just_pressed
signal just_released

func process() -> void:
    if Input.is_action_just_pressed(action_name):
        just_pressed.emit()
    if Input.is_action_just_released(action_name):
        just_released.emit()
    if Input.is_action_pressed(action_name):
        pressed.emit()
    # strength.emit(Input.get_action_strength(action_name))
    # raw_strength.emit(Input.get_action_raw_strength(action_name))