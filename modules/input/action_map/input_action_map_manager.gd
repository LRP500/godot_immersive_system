extends Node

signal map_changed(map: InputActionMap)

@export var action_maps: Array[InputActionMap] = []

var map_stack: Array[InputActionMap] = []

func _get_current() -> InputActionMap:
	if map_stack.size() == 0:
		return null
	return map_stack[0]

func _process(_delta: float) -> void:
	var current_map: InputActionMap = _get_current()
	if current_map:
		map_stack[0].process()

func register(map: InputActionMap) -> void:
	action_maps.append(map)
	print_rich("[Input] Input action map [i]%s[/i] registered" % map.id)

func push(map_id: String) -> void:
	var current_map: InputActionMap = _get_current()
	var map_to_enable: InputActionMap = get_action_map(map_id)
	if current_map == null || map_to_enable.id != current_map.id:
		map_stack.insert(0, map_to_enable)
		map_changed.emit(map_to_enable)
		print_rich("[Input] Input action map [b]%s[/b] enabled" % map_id)

func pop(map_id: String) -> void:
	var current_map: InputActionMap = _get_current()
	var map_to_disable: InputActionMap = get_action_map(map_id)
	if current_map != null && map_to_disable.id == current_map.id:
		map_stack.remove_at(0)
		map_changed.emit(null)
		print_rich("[Input] Input action map [b]%s[/b] disabled" % map_id)

func get_action_map(map_id: String) -> InputActionMap:
	var result: InputActionMap
	for map in action_maps:
		if map.id == map_id:
			result = map
	assert(result, "[Input] InputActionMap %s not found" % map_id)
	return result

#region Input Queries

func is_action_just_pressed(event_name: String) -> bool:
	var map: InputActionMap = _get_current()
	var event: InputActionMapKeyEvent = map.get_key_event(event_name)
	if event == null:
		return false
	return event.is_just_pressed()

func is_action_just_released(event_name: String) -> bool:
	var map: InputActionMap = _get_current()
	var event: InputActionMapKeyEvent = map.get_key_event(event_name)
	if event == null:
		return false
	return event.is_just_released()

func is_action_pressed(event_name: String) -> bool:
	var map: InputActionMap = _get_current()
	var event: InputActionMapKeyEvent = map.get_key_event(event_name)
	if event == null:
		return false
	return event.is_pressed()

#endregion Input Queries
