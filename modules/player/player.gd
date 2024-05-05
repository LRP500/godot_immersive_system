extends Node
class_name Player

signal item_carry(carryable: Node3D)
signal item_drop()
signal item_wield(wieldable: InventoryItem)
signal item_unwield()
signal weapon_equip(weapon: InventoryItem)
signal weapon_unequip()

@onready var pawn: PlayerPawn = %Pawn
@onready var inventory: Inventory = %Inventory

func get_interactor() -> Interactor:
	return pawn.interactor

func _ready() -> void:
	var hotbar: InventoryHotbar = inventory.get_node_or_null("%InventoryHotbar")
	hotbar.slot_selected.connect(_on_hotbar_slot_selected)
	hotbar.slot_unselected.connect(_on_hotbar_slot_unselected)

func equip(item: InventoryItem) -> void:
	if !item.model.get_meta("wieldable", false):
		return
	if item.model.has_tag("weapon"):
		var weapon: WeaponModel = WeaponAtlas.get_from_item(item.model.id)
		if weapon:
			weapon_equip.emit(weapon)
	else:
		item_wield.emit(item)

func unequip() -> void:
	item_unwield.emit()
	weapon_unequip.emit()

func carry(item: Node3D) -> void:
	item_carry.emit(item)

func drop() -> void:
	item_drop.emit()

func _on_hotbar_slot_selected(slot: InventoryHotbarSlot) -> void:
	if slot.item:
		equip(slot.item)

func _on_hotbar_slot_unselected(_slot: InventoryHotbarSlot) -> void:
	unequip()

# TODO: Fix issue where the player can carry items while wielding