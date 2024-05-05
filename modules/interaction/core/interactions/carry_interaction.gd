extends Interaction
class_name Carryable

func interact(_interactor: Interactor) -> void:
    super(_interactor)
    Global.player.carry(parent)