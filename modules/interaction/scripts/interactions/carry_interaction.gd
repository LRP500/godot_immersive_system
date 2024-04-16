extends Interaction
class_name Carryable

func interact(_interactor: Interactor) -> void:
    super(_interactor)
    var item_holder: CarryableItemHolder= _interactor.get_node("%CarryableItemHolder")
    assert(item_holder, "[Interaction] CarryableItemHolder not found")
    item_holder.carry(_interactor, parent)