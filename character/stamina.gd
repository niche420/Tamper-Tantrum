class_name Stamina
extends Node

signal changed(value: float, max_value: float)
signal depleted

@export var max_value: float = 100.0
@export var drain_rate: float = 25.0    # per second while draining
@export var regen_rate: float = 10.0    # per second while resting

var value: float
var draining: bool = false

func _ready() -> void:
	value = max_value

func _process(delta: float) -> void:
	var old := value
	if draining:
		value = max(0.0, value - drain_rate * delta)
	else:
		value = min(max_value, value + regen_rate * delta)
	if value != old:
		changed.emit(value, max_value)
	if value == 0.0 and old > 0.0:
		depleted.emit()
