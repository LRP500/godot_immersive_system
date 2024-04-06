extends ProgressBar

var data_holder: DataHolder
var interaction: Interaction

func _init() -> void:
    CanvasHelpers.disable(self)

func _ready() -> void:
    data_holder = NodeHelpers.find_in_parents(self, "DataHolder", true)
    assert(data_holder, "DataHolder not found")
    data_holder.data_changed.connect(_bind)
    _bind(data_holder.data)

func _process(_delta: float) -> void:
    _update()

func _update() -> void:
    value = interaction.timer.get_progress_ratio()

func _bind(data: Object) -> void:
    if data == null:
        CanvasHelpers.disable(self)
        return
    interaction = data as Interaction
    if interaction.timer == null:
        return
    elif interaction.timer.paused:
        CanvasHelpers.enable(self)
        _update()
    interaction.started.connect(_on_interaction_started)
    interaction.ended.connect(_on_interaction_ended)
    interaction.interrupted.connect(_on_interaction_interrupted)

func _on_interaction_started() -> void:
    CanvasHelpers.enable(self)

func _on_interaction_ended() -> void:
    CanvasHelpers.disable(self)

func _on_interaction_interrupted() -> void:
    if interaction.timer.reset_on_release:
        CanvasHelpers.disable(self)