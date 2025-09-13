class_name AttributeModifierInfo extends Resource

@export var operator: Util.EOperator
@export var magnitude: float
@export var coefficient: float = 1

func _init(_operator: Util.EOperator = Util.EOperator.ADD, _magnitude: float = 0.0, _coefficient: float = 1.0) -> void:
	operator = _operator
	magnitude = _magnitude
	coefficient = _coefficient

func Calculate(value: float) -> float:
	var result: float = value
	match operator:
		Util.EOperator.ADD:
			result += magnitude * coefficient
		Util.EOperator.MULTIPLY:
			result *= magnitude * coefficient
		Util.EOperator.DIVIDE:
			result /= magnitude * coefficient
		Util.EOperator.OVERRIDE:
			result = magnitude * coefficient
	return result
