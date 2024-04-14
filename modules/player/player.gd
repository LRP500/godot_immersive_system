extends Node
class_name Player

@onready var pawn: GoldGdt_Pawn = $Pawn
@onready var inventory: Inventory = $Inventory

#region freeze

# func set_frozen(frozen: bool) -> void:
# 	if frozen:
# 		freeze()
# 	else:
# 		unfreeze()
	
# func freeze() -> void:
# 	controller.process_mode = Node.PROCESS_MODE_DISABLED
# 	interactor.process_mode = Node.PROCESS_MODE_DISABLED
# 	hud.visible = false

# func unfreeze() -> void:
# 	controller.process_mode = Node.PROCESS_MODE_ALWAYS
# 	interactor.process_mode = Node.PROCESS_MODE_ALWAYS

#endregion