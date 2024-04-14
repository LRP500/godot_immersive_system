extends Interaction

@export var interact_method_name: String = "interact"

func _ready() -> void:
    super()
    interact_method = Callable(parent, interact_method_name)
    if !interact_method.is_valid():
        printerr("[Interaction] No suitable interact method found in parent!")

func interact_start(_interactor: Interactor) -> void:
    interact_method.call(_interactor)