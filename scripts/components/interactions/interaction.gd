extends Node3D
class_name Interaction

signal started
signal ended

@export var is_enabled: bool = true
@export var interaction_text: String = "Interact"
@export var input_map_action: String = "interact"

var parent: Node3D
var timer: InteractionTimer
var interactor: Interactor

func _enter_tree() -> void:
    parent = get_parent()
    assert(parent, "Parent must be a Node3D")

func _ready() -> void:
    _init_timer()

func start_interact(_interactor: Interactor) -> void:
    self.interactor = _interactor
    if timer:
       timer.start()
       started.emit()
    else:
       interact(interactor)

func stop_interact(_interactor: Interactor) -> void:
    if !timer:
       return
    timer.stop()
    ended.emit()
    interactor = null

func interact(_interactor: Interactor) -> void:
    var callable := Callable(parent, "interact")
    if callable.is_valid():
       callable.call(interactor)

func _init_timer() -> void:
    timer = find_child("InteractionTimer", false, false)
    if timer:
       timer.timeout.connect(_on_timer_finished)

func _on_timer_finished() -> void:
    interact(interactor)
    stop_interact(interactor)