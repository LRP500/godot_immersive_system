extends Control
class_name ConsoleView

@onready var console_text: RichTextLabel = %RichTextLabel
@onready var input_field: LineEdit = %LineEdit

func _ready() -> void:
    Console.opened.connect(_on_console_opened)
    Console.closed.connect(_on_console_closed)
    z_index = 1000
    hide()

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_text_submit"):
        _submit()

func _submit() -> void:
    Console.submit(input_field.text)
    input_field.clear()

func _on_console_opened() -> void:
    input_field.clear()
    input_field.call_deferred("grab_focus")
    show()

func _on_console_closed() -> void:
    input_field.release_focus()
    hide()