extends InputActionMapEvent
class_name InputActionMapJoytickEvent

signal strength(strength: float)
signal raw_strength(strength: float)

func process() -> void:
    strength.emit(Input.get_action_strength(action_name))
    raw_strength.emit(Input.get_action_raw_strength(action_name))