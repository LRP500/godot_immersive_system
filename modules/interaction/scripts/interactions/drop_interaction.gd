extends Interaction

func interact(_interactor: Interactor) -> void:
    super(_interactor)
    var item_holder: CarryableItemHolder = _interactor.get_node("%CarryableItemHolder")
    assert(item_holder, "[Interaction] CarryableItemHolder not found")
    item_holder.drop(_interactor)

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass