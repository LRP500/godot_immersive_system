extends Object
class_name ConsoleCommand

var method: Callable
var param_count: int
var description: String

func _init(_method: Callable, _param_count: int, _description: String) -> void:
    method = _method
    param_count = _param_count
    description = _description