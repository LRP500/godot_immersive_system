extends Control
class_name HudView

@onready var player_menu: PlayerMenu = $"../PlayerMenu"

func _ready() -> void:
	if player_menu:
		player_menu.open_state_changed.connect(_on_player_menu_open_state_changed)

func _on_player_menu_open_state_changed(player_menu_open: bool) -> void:
	visible = !player_menu_open