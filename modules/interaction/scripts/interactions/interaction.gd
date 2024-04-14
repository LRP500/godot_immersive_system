extends Node3D
class_name Interaction

signal started
signal completed
signal interrupted
signal updated(progress: float)
signal enabled_state_changed(enabled: bool)

@export var is_enabled: bool = true: set = _set_is_enabled
@export var interaction_text: String = "Interact"
@export var input_map_action: String = "interact"

@onready var parent: Node3D = get_parent()

var timer: InteractionHoldTimer
var interactor: Interactor

var interact_method: Callable
var interact_start_method: Callable
var interact_stop_method: Callable
var interact_update_method: Callable

func _set_is_enabled(_is_enabled: bool) -> void:
    is_enabled = _is_enabled
    enabled_state_changed.emit(is_enabled)

func _ready() -> void:
    _init_timer()
    interact_method = Callable(parent, "interact")
    interact_start_method = Callable(parent, "interact_start")
    interact_stop_method = Callable(parent, "interact_stop")
    interact_update_method = Callable(parent, "interact_update")

func _process(_delta: float) -> void:
    if !is_enabled || !interactor:
        return
    if timer:
        updated.emit(timer.get_progress_ratio())
    if interact_update_method.is_valid():
        interact_update_method.call(interactor, self)

func interact_start(_interactor: Interactor) -> void:
    interactor = _interactor
    if interact_start_method.is_valid():
        interact_start_method.call(_interactor, self)
    if timer:
        started.emit()
    else:
        interact(interactor)

func interact_stop(_interactor: Interactor) -> void:
    if interact_stop_method.is_valid():
        interact_stop_method.call(_interactor, self)
    interactor = null
    if !timer:
        return
    elif !timer.is_stopped():
        interrupted.emit()
    else:
        completed.emit()

func interact(_interactor: Interactor) -> void:
    if interact_method.is_valid():
        interact_method.call(interactor, self)

func _init_timer() -> void:
    timer = find_child("InteractionHoldTimer", false, false)
    if timer:
        timer.timeout.connect(_on_timer_finished)

func _on_timer_finished() -> void:
    interact(interactor)
    completed.emit()
    interactor = null