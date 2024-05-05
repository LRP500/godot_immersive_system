extends Node

@export var weapons: Array[WeaponModel]

func get_from_item(item_id: String) -> WeaponModel:
    for weapon in weapons:
        if weapon.item.id == item_id:
            return weapon
    assert("[WeaponAtlas] Weapon not found for item %s" % item_id)
    return null

func get_packed_scene(item_model: InventoryItemModel) -> PackedScene:
    var weapon_model : = get_from_item(item_model.id)
    return weapon_model.scene if weapon_model else null