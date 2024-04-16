extends StaticBody3D
class_name StaticInteractable

func on_grab(interactor: Interactor) -> void:
    var item_placer: CarryableItemPlacer = interactor.get_node_or_null("%CarryableItemPlacer")
    assert(item_placer, "[Interaction] CarryableItemPlacer not found")
    item_placer.is_enabled = true

func on_drop(interactor: Interactor) -> void:
    var item_placer: CarryableItemPlacer = interactor.get_node_or_null("%CarryableItemPlacer")
    assert(item_placer, "[Interaction] CarryableItemPlacer not found")
    position = item_placer.item_ghost.global_position
    rotation = item_placer.item_ghost.global_rotation
    item_placer.is_enabled = false