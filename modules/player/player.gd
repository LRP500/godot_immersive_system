extends Node
class_name Player

@onready var pawn: PlayerPawn = %Pawn
@onready var inventory: Inventory = %Inventory
@onready var interactor: Interactor = %Interactor

#region freeze

func set_frozen(frozen: bool) -> void:
	if frozen:
		freeze()
	else:
		unfreeze()
	
func freeze() -> void:
	pawn.process_mode = Node.PROCESS_MODE_DISABLED
	interactor.is_enabled = false

func unfreeze() -> void:
	pawn.process_mode = Node.PROCESS_MODE_INHERIT
	interactor.is_enabled = true

#endregion

# TODO: FIX calling freeze() on player freezes its position (e.g. mid-jump) but the game keeps playing