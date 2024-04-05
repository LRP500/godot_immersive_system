extends Node

@export var parameter_name: String = "conditions/is_on"

var state_machine: AnimationNodeStateMachinePlayback

func _init() -> void:
	state_machine = get("parameters/playback")

func toggle(is_on: bool) -> void:
	if is_on:
		state_machine.travel("toggle_on")
		# set("parameters/%s" % parameter_name, true)
	else:
		state_machine.travel("toggle_off")
		# set("parameters/%s" % parameter_name, false)
