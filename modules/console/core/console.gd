extends Node

signal opened
signal closed

# TODO: Move ConsoleCommand to its own file.
class ConsoleCommand:
	var method: Callable
	var param_count: int
	func _init(_method: Callable, _param_count: int) -> void:
		method = _method
		param_count = _param_count

@export var toggle_action_name: String = "toggle_console"

@onready var view: ConsoleView = $ConsoleView

var commands: Dictionary = {}
var is_open: bool = false

func _init() -> void:
	add_command("list", list)
	add_command("help", help)
	add_command("quit", quit)
	add_command("clear", clear)
	add_command("close", close)

func _ready() -> void:
	close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(toggle_action_name):
		toggle()

func add_command(in_name: String, method: Callable, param_count: int = 0) -> void:
	commands[in_name] = ConsoleCommand.new(method, param_count)

# TODO: Display error message if command doesn't exist.
func execute(command: ConsoleCommand, args: PackedStringArray) -> bool:
	if command == null:
		return false
	if command.param_count > 0:
		command.method.call(args)
	else:
		command.method.call()
	return true

func submit(input: String) -> void:
	input = sanitize(input)
	var command_name := input.split(' ')[0]
	var args := input.split(' ').slice(1)
	var command: ConsoleCommand = commands.get(command_name)
	execute(command, args)

func sanitize(input: String) -> String:
	return input.replace("\n", "")

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

#region Commands

# TODO: Display one command per line with short description.
func list() -> void:
	var items := []
	for command: String in commands:
		items.append(str(command))
	items.sort()
	view.console_text.add_text(str(items) + "\n")

func clear() -> void:
	view.console_text.clear()

func help() -> void:
	pass

func quit() -> void:
	get_tree().quit()

#endregion Commands
