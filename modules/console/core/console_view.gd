extends Control
class_name ConsoleView

@onready var console_text: RichTextLabel = %RichTextLabel
@onready var input_field: LineEdit = %LineEdit
@onready var prompt: String = " > "

func _ready() -> void:
    Console.opened.connect(_on_console_opened)
    Console.closed.connect(_on_console_closed)
    input_field.select_all_on_focus = false
    z_index = 1000
    hide()

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_text_submit"):
        _submit()
    if input_field.caret_column < prompt.length():
        input_field.caret_column = prompt.length()

func _submit() -> void:
    var input := input_field.text.replace(prompt, "")
    Console.submit(input)
    _new_line()

func _on_console_opened() -> void:
    input_field.call_deferred("grab_focus")
    _new_line()
    show()

func _on_console_closed() -> void:
    input_field.release_focus()
    hide()

func _new_line() -> void:
    input_field.text = prompt
    input_field.caret_column = prompt.length()