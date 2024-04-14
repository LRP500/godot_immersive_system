extends Control
class_name HudLogMessageView

@export var label: RichTextLabel

var message: LogMessage

func bind(_message: LogMessage) -> void:
    message = _message
    label.text = _message.text

func fade_out(fade_duration: float) -> Tween:
    var tween := get_tree().create_tween()
    tween.tween_property(label, "modulate:a", 0.0, fade_duration)
    tween.play()
    return tween