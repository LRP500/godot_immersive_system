extends Object
class_name ConsoleCommand

var method: Callable
var param_count: int

func _init(_method: Callable, _param_count: int) -> void:
    method = _method
    param_count = _param_count