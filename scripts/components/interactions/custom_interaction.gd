extends Interaction

@export var interact_method_name: String = "interact"

var interact_method: Callable

func _ready() -> void:
    interact_method = Callable(parent, interact_method_name)
    if !interact_method.is_valid():
        printerr("[Interaction] No suitable interact method found in parent!")

func start_interact(_interactor: Interactor) -> void:
    interact_method.call(_interactor)