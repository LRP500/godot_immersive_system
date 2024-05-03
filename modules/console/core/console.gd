extends Node

signal opened
signal closed

@export var toggle_action_name: String = "toggle_console"

@onready var view: ConsoleView = $ConsoleView

var commands: Dictionary = {}
var is_open: bool = false

func _init() -> void:
	add_command("help", "Provides help information for console commands.", help)
	add_command("quit", "Quits the application.", quit)
	add_command("clear", "Clears the console's view.", clear)
	add_command("close", "Closes the console.", close)
	# add_command("restart", "Restarts the current scene.", restart)

func _ready() -> void:
	close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(toggle_action_name):
		toggle()

func add_command(_name: String, desc: String, method: Callable, param_count: int = 0) -> void:
	commands[_name] = ConsoleCommand.new(method, param_count, desc)

func execute(command: ConsoleCommand, args: PackedStringArray) -> bool:
	if command.param_count > 0:
		command.method.call(args)
	else:
		command.method.call()
	return true

func submit(input: String) -> void:
	input = sanitize(input)
	if input.is_empty():
		return
	var command_name := input.split(' ')[0]
	var args := input.split(' ').slice(1)
	var command: ConsoleCommand = commands.get(command_name)
	if command == null:
		print_error("'%s' is not recognized as an internal or external command." % command_name);
		print_line("Type 'help' for a list of available commands.")
		return
	execute(command, args)

func sanitize(input: String) -> String:
	input = input.strip_escapes()
	input = input.strip_edges()
	return input

func open() -> void:
	is_open = true
	opened.emit()
	
func close() -> void:
	is_open = false
	closed.emit()

func toggle() -> void:
	if is_open:
		close()
	else:
		open()

func print_line(text: String) -> void:
	view.console_text.push_color(Color.WHITE)
	view.console_text.add_text(text + "\n")

func print_error(text: String) -> void:
	view.console_text.push_color(Color.RED)
	view.console_text.add_text(text + "\n")

#region Commands

func help() -> void:
	print_line("For more information on a specific command, type 'help [command-name]'.")
	for key: String in commands:
		var command: ConsoleCommand = commands[key]
		var text: String = "%s\t\t\t%s" % [key.to_upper(), command.description]
		print_line(text)

func clear() -> void:
	view.console_text.clear()

func quit() -> void:
	get_tree().quit()

func restart() -> void:
	get_tree().reload_current_scene()

#endregion Commands

# TODO: Add line prompt
# TODO: Add restart command