extends Node

var player: Player

func _ready() -> void:
    player = get_tree().current_scene.get_node("Player")
    assert(player, "[Global] Player not found in scene tree.")