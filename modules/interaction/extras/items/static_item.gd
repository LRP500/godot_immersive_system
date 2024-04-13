extends StaticBody3D
class_name StaticItem

func on_grab(interactor: Interactor) -> void:
    var item_placer: InteractorItemPlacer = interactor.get_node_or_null("%ItemPlacer")
    item_placer.is_enabled = true

func on_drop(interactor: Interactor) -> void:
    var item_placer: InteractorItemPlacer = interactor.get_node_or_null("%ItemPlacer")
    position = item_placer.item_ghost.global_position
    rotation = item_placer.item_ghost.global_rotation
    item_placer.is_enabled = false