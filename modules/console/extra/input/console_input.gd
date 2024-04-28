extends Node

@export var action_map: InputActionMap

func _init() -> void:
	var class_exists := ClassDB.class_exists("InputActionMapManager")
	if !class_exists || InputActionMapManager == null:
		process_mode = Node.PROCESS_MODE_DISABLED

func _ready() -> void:
	var console := get_parent()
	console.opened.connect(_on_console_opened)
	console.closed.connect(_on_console_closed)
	InputActionMapManager.register(action_map)

func _on_console_opened() -> void:
	InputActionMapManager.push(action_map.id)

func _on_console_closed() -> void:
	InputActionMapManager.pop(action_map.id)
