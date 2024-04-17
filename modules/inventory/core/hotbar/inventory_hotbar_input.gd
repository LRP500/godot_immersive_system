extends Node
class_name InventoryHotbarInput

@onready var hotbar: InventoryHotbar = get_parent()

var interactor: Interactor
var item_holder: WieldableItemHolder
var current_slot_index: int = -1

func _ready() -> void:
	interactor = InteractionModule.interactor
	item_holder = interactor.get_node("%WieldableItemHolder")
	assert(item_holder, "[InventoryHotbarInput] Unable to find WieldableItemHolder")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_hotbar_slot_01"):
		_focus_slot(0)
	elif event.is_action_pressed("inventory_hotbar_slot_02"):
		_focus_slot(1)
	elif event.is_action_pressed("inventory_hotbar_slot_03"):
		_focus_slot(2)
	elif event.is_action_pressed("inventory_hotbar_slot_04"):
		_focus_slot(3)
	elif event.is_action_pressed("inventory_hotbar_slot_05"):
		_focus_slot(4)
	elif event.is_action_pressed("inventory_hotbar_slot_06"):
		_focus_slot(5)
	elif event.is_action_pressed("inventory_hotbar_slot_07"):
		_focus_slot(6)
	elif event.is_action_pressed("inventory_hotbar_slot_08"):
		_focus_slot(7)
	elif event.is_action_pressed("inventory_hotbar_slot_09"):
		_focus_slot(8)

func _focus_slot(slot_index: int) -> void:
	if slot_index == current_slot_index:
		return
	var item := hotbar.get_item_at(slot_index)
	if !item:
		return
	current_slot_index = slot_index
	item_holder.wield(interactor, item)