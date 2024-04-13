extends Interaction
class_name Carryable

func interact(_interactor: Interactor) -> void:
    super(_interactor)
    _interactor.item_holder.attach(_interactor, parent)