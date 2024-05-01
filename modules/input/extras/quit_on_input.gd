extends Node

@export var action_name: String = "quit_game"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(action_name):
		get_tree().quit()