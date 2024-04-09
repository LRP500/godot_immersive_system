extends Node3D
class_name Interaction

signal started
signal completed
signal interrupted
signal updated(progress: float)

@export var is_enabled: bool = true
@export var interaction_text: String = "Interact"
@export var input_map_action: String = "interact"

var parent: Interactable
var timer: InteractionHoldTimer
var interactor: Interactor

func _enter_tree() -> void:
    parent = get_parent() as Interactable
    assert(parent, "Parent must be an Interactable")

func _ready() -> void:
    _init_timer()

func _process(_delta: float) -> void:
    if !is_enabled || !interactor:
        return
    if timer:
        updated.emit(timer.get_progress_ratio())
    parent.interact_update(interactor, self)

func interact_start(_interactor: Interactor) -> void:
    self.interactor = _interactor
    parent.interact_start(_interactor, self)
    if timer:
        started.emit()
    else:
        interact(interactor)

func interact_stop(_interactor: Interactor) -> void:
    parent.interact_stop(_interactor, self)
    if !timer:
        return
    elif !timer.is_stopped():
        interrupted.emit()
    else:
        completed.emit()
    interactor = null

func interact(_interactor: Interactor) -> void:
    var callable := Callable(parent, "interact")
    if callable.is_valid():
        callable.call(interactor, self)

func _init_timer() -> void:
    timer = find_child("InteractionHoldTimer", false, false)
    if timer:
        timer.timeout.connect(_on_timer_finished)

func _on_timer_finished() -> void:
    interact(interactor)
    completed.emit()
    interactor = null