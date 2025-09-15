class_name Attribute extends Resource

@export var base_value: float:
	set(value):
		base_value = value
var current_value: float

func _init(value: float = 0.0) -> void:
	base_value = value
	current_value = base_value
