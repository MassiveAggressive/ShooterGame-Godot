class_name EffectBase extends Node

var effect_owner: Node
var effect_target: Node

@export var duration_policy: Util.EDurationPolicy
@export var modifiers: Array[AttributeModifier]

func InitializeEffect(new_effect_owner: Node, new_effect_target: Node) -> void:
	effect_owner = new_effect_owner
	effect_target = new_effect_target

func AddModifier(attribute_name: String, modifier: AttributeModifierInfo) -> void:
	var new_attribute_modifier: AttributeModifier = AttributeModifier.new()
	
	new_attribute_modifier.attribute_name = attribute_name
	new_attribute_modifier.modifier_info = modifier
	
	modifiers.append(new_attribute_modifier)

func ApplyEffect() -> void:
	var target_attribute_manager: AttributeManagerBase = effect_target.find_children("", "AttributeManagerBase")[0]
	
	for modifier in modifiers:
		if target_attribute_manager.HasAttribute(modifier.attribute_name):
			var aggregator: Aggregator
			
			match duration_policy:
				Util.EDurationPolicy.INSTANT:
					aggregator = Aggregator.new()
					aggregator.AddModifier(modifier.modifier_info)
					
					target_attribute_manager.SetAttributeBaseValue(modifier.attribute_name, aggregator.Calculate())
				Util.EDurationPolicy.DURATION:
					if target_attribute_manager.HasAggregator(modifier.attribute_name):
						aggregator = target_attribute_manager.GetAggregator(modifier.attribute_name)
						
						aggregator.AddModifier(modifier.modifier_info)
					else:
						aggregator = Aggregator.new()
						aggregator.AddModifier(modifier.modifier_info)
				
						target_attribute_manager.AddAggregator(modifier.attribute_name, aggregator)
						
						target_attribute_manager.SetAttributeCurrentValue(modifier.attribute_name, aggregator.Calculate())
