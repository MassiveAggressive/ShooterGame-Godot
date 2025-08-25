class_name EffectBase
extends Node

var effect_owner: Node
var effect_target: Node

@export var modifiers: Array[EffectModifier]

func InitializeEffect(new_effect_owner: Node, new_effect_target: Node) -> void:
	effect_owner = new_effect_owner
	effect_target = new_effect_target

func ApplyEffect() -> void:
	for modifier in modifiers:
		var target_attribute_container: AttributeContainer = effect_target.find_child("AttributeContainer")
		if target_attribute_container.HasAttribute(modifier.attribute_name):
			var target_attribute_value: float = target_attribute_container.GetAttribute(modifier.attribute_name)
			var final_attribute_result: float = 0.0
			
			match modifier.modifier_operator:
				Enums.EOperator.ADD:
					final_attribute_result = target_attribute_value + modifier.attribute_magnitude * modifier.magnitude_coefficient
				Enums.EOperator.MULTIPLY:
					final_attribute_result = target_attribute_value * modifier.attribute_magnitude * modifier.magnitude_coefficient
				Enums.EOperator.DIVIDE:
					final_attribute_result = target_attribute_value / modifier.attribute_magnitude * modifier.magnitude_coefficient
				Enums.EOperator.OVERRIDE:
					final_attribute_result = modifier.attribute_magnitude * modifier.magnitude_coefficient
			
			target_attribute_container.SetAttributeByEffect(modifier.attribute_name, final_attribute_result, self)
