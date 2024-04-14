extends Node
class_name HudLogView

@export var log_message_view: PackedScene
@export var container: VBoxContainer

@export var fade_delay: float = 2.0
@export var fade_speed: float = 1.0

var log_message_views: Array[HudLogMessageView] = []

func _ready() -> void:
	PlayerModule.player.inventory.item_added.connect(_on_item_added)
	PlayerModule.player.inventory.item_removed.connect(_on_item_removed)
	_clear_messages()

func _clear_messages() -> void:
	for child in container.get_children():
		child.queue_free()
	log_message_views.clear()

func _on_item_removed(item: InventoryItem) -> void:
	var log_message: LogMessage = LogMessage.new()
	if item.count == 0:
		return
	elif item.count == 1:
		log_message.text = "%s removed from inventory" % item.model.display_name
	else:
		log_message.text = "%s (%s) removed from inventory" % [item.model.display_name, item.count]
	_create_message_view(log_message)

func _on_item_added(item: InventoryItem) -> void:
	var log_message: LogMessage = LogMessage.new()
	if item.count == 0:
		return
	elif item.count == 1:
		log_message.text = "%s added to inventory" % item.model.display_name
	else:
		log_message.text = "%s (%s) added to inventory" % [item.model.display_name, item.count]
	_create_message_view(log_message)

func _create_message_view(message: LogMessage) -> HudLogMessageView:
	var view := log_message_view.instantiate() as HudLogMessageView
	view.bind(message)
	container.add_child(view)
	log_message_views.append(view)
	_fade_view(view)
	return view

func _fade_view(view: HudLogMessageView) -> void:
	await get_tree().create_timer(fade_delay).timeout
	view.fade_out(fade_speed).finished.connect(
		func() -> void: _on_fade_tween_finished(view))

func _on_fade_tween_finished(view: HudLogMessageView) -> void:
	log_message_views.erase(view)
	view.queue_free()