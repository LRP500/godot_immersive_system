extends Interaction

func interact(_interactor: Interactor) -> void:
    _interactor.item_holder.drop(_interactor)

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass