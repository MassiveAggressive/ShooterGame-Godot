class_name Attribute extends Resource

@export var name: String
@export var base_value: float:
	set(value):
		base_value = value
		current_value = base_value
var current_value: float

func _init(_name: String = "", _value: float = 0.0) -> void:
	name = _name
	base_value = _value
	current_value = base_value
