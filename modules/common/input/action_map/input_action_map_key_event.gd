extends InputActionMapEvent
class_name InputActionMapKeyEvent

signal pressed
signal just_pressed
signal just_released

func process() -> void:
    if is_just_pressed():
        just_pressed.emit()
    if is_just_released():
        just_released.emit()
    if is_pressed():
        pressed.emit()

func is_just_pressed() -> bool:
    return Input.is_action_just_pressed(action_name)

func is_just_released() -> bool:
    return Input.is_action_just_released(action_name)

func is_pressed() -> bool:
    return Input.is_action_pressed(action_name)