extends Node

signal map_changed(map: InputActionMap)

@export var action_maps: Array[InputActionMap] = []

var current_map: InputActionMap

func _process(_delta: float) -> void:
	if current_map:
		current_map.process()

func enable(map_id: String) -> void:
	var map_to_enable: InputActionMap = get_action_map(map_id)
	if map_to_enable != current_map:
		current_map = map_to_enable
		map_changed.emit(current_map)
		print_rich("[Input] Input action map [b]%s[/b] enabled" % map_id)

func disable(map_id: String) -> void:
	if map_id == current_map.id:
		current_map = null
		map_changed.emit(null)
		print_rich("[Input] Input action map [b]%s[/b] disabled" % map_id)

func get_action_map(map_id: String) -> InputActionMap:
	var result: InputActionMap
	for map in action_maps:
		if map.id == map_id:
			result = map
	assert(result, "[Input] InputActionMap %s not found" % map_id)
	return result

func is_action_just_pressed(event_name: String) -> bool:
	var event: InputActionMapKeyEvent = current_map.get_key_event(event_name)
	if event == null:
		return false
	return event.is_just_pressed()