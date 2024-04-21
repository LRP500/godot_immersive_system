extends Control

@export var player_menu: PlayerMenu

@onready var inventory_view: InventoryView = %InventoryView

func _ready() -> void:
	player_menu.open_state_changed.connect(_on_open_state_changed)
	_on_open_state_changed(player_menu.is_open)

func _on_open_state_changed(is_open: bool) -> void:
	visible = is_open