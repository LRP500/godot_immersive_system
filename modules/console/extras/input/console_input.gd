extends Node

@export var action_map: InputActionMap

func _init() -> void:
	var class_exists := ClassDB.class_exists("InputManager")
	if !class_exists || InputManager == null:
		process_mode = Node.PROCESS_MODE_DISABLED

func _ready() -> void:
	var console := get_parent()
	console.opened.connect(_on_console_opened)
	console.closed.connect(_on_console_closed)
	InputManager.register(action_map)

func _on_console_opened() -> void:
	InputManager.push(action_map.id)

func _on_console_closed() -> void:
	InputManager.pop(action_map.id)
