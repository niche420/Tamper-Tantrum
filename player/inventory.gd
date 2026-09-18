extends Node

signal changed

var items: Array[String] = []

func add(item: String) -> void:
	items.append(item)
	changed.emit()

func has(item: String) -> bool:
	return item in items

func remove(item: String) -> void:
	items.erase(item)
	changed.emit()
