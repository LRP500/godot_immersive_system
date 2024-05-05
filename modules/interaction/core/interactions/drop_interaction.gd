extends Interaction

func interact(_interactor: Interactor) -> void:
    super(_interactor)
    Global.player.drop()

func interact_start(_interactor: Interactor) -> void:
    interact(_interactor)

func interact_stop(_interactor: Interactor) -> void:
    pass