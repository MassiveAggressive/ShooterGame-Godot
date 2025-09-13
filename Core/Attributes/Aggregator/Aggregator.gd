class_name Aggregator extends Resource

@export var attribute_name: String
@export var base_value: float
@export var modifiers: Array[AttributeModifierInfo]

var additive_modifiers: Array[float]
var multiplicative_modifiers: Array[float]
var overrider_modifiers: Array[float]

func AddModifier(modifier: AttributeModifierInfo) -> void:
	modifiers.append(modifier)

func RemoveModifier(modifier: AttributeModifierInfo) -> void:
	modifiers.erase(modifier)

func Calculate() -> float:
	additive_modifiers.clear()
	multiplicative_modifiers.clear()
	overrider_modifiers.clear()
	
	var value_result: float = 0.0
	
	for modifier in modifiers:
		match modifier.operator:
			Util.EOperator.ADD:
				additive_modifiers.append(modifier.magnitude * modifier.coefficient)
			Util.EOperator.MULTIPLY:
				multiplicative_modifiers.append(modifier.magnitude * modifier.coefficient)
			Util.EOperator.DIVIDE:
				multiplicative_modifiers.append(1 / (modifier.magnitude * modifier.coefficient))
			Util.EOperator.OVERRIDE:
				overrider_modifiers.append(modifier.magnitude * modifier.coefficient)
				
	var additive_total: float = 0.0
	
	for modifier in additive_modifiers:
		additive_total += modifier
	
	var multiplicative_total = 1.0
	
	for modifier in multiplicative_modifiers:
		multiplicative_total *= modifier
	
	value_result = (base_value + additive_total) * multiplicative_total
	
	if overrider_modifiers.size() > 0:
		value_result = overrider_modifiers[overrider_modifiers.size() - 1]
	
	return value_result
