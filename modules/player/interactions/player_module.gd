extends Node

var player: Player

func _ready() -> void:
    var root := get_tree().current_scene
    player = root.get_node("Player")