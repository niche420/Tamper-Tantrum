extends Node

signal list_changed
signal item_destroyed(item_name: String)
signal all_destroyed

# item name -> has it been destroyed?
var items: Dictionary = {}

func _ready() -> void:
	all_destroyed.connect(func(): print("All items destroyed - you win!"))

func register_item(item_name: String) -> void:
	items[item_name] = false
	list_changed.emit()

func destroy_item(item_name: String) -> void:
	if not items.has(item_name) or items[item_name]:
		return
	items[item_name] = true
	item_destroyed.emit(item_name)
	list_changed.emit()
	if not items.values().has(false):
		all_destroyed.emit()
