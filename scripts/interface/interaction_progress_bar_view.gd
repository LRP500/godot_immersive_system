extends ProgressBar

var data_holder: DataHolder

func _init() -> void:
    CanvasHelpers.disable(self)

func _ready() -> void:
    data_holder = NodeHelpers.find_in_parents(self, "DataHolder", true)
    assert(data_holder, "DataHolder not found")
    data_holder.data_changed.connect(_bind)
    _bind(data_holder.data)

func _process(_delta: float) -> void:
    var interaction := data_holder.data as Interaction
    value = interaction.timer.get_progress_ratio()

func _bind(data: Object) -> void:
    if data == null:
        CanvasHelpers.disable(self)
        return
    var interaction := data_holder.data as Interaction
    if interaction.timer == null:
        return
    interaction.started.connect(_on_interaction_started)
    interaction.ended.connect(_on_interaction_ended)

func _on_interaction_started() -> void:
    CanvasHelpers.enable(self)

func _on_interaction_ended() -> void:
    CanvasHelpers.disable(self)