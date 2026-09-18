# inventory_bar.gd
extends HBoxContainer

const ICON_PATH := "res://icons/%s.png"   # e.g., res://icons/glass_shard.png

func _ready() -> void:
	Inventory.changed.connect(_refresh)
	_refresh()

func _refresh() -> void:
	for child in get_children():
		child.queue_free()

	for item in Inventory.items:
		var slot := PanelContainer.new()
		slot.custom_minimum_size = Vector2(64, 64)

		var path := ICON_PATH % item
		if ResourceLoader.exists(path):
			var icon := TextureRect.new()
			icon.texture = load(path)
			icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slot.add_child(icon)
		else:
			var label := Label.new()
			label.text = item
			slot.add_child(label)

		add_child(slot)
