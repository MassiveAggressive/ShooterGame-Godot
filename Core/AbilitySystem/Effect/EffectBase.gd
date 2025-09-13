class_name EffectBase extends Node

var effect_owner: Node
var effect_target: Node

@export var duration_policy: Util.EDurationPolicy
var duration: float

@export var modifiers: Dictionary[String, AttributeModifierInfoArray]

var aggregators: Dictionary[String, Aggregator]

func InitializeEffect(new_effect_owner: Node, new_effect_target: Node) -> void:
	effect_owner = new_effect_owner
	effect_target = new_effect_target

func AddModifier(attribute_name: String, modifier: AttributeModifierInfo) -> void:
	if !modifiers.has(attribute_name):
		modifiers[attribute_name] = AttributeModifierInfoArray.new()
		
	modifiers[attribute_name].array.append(modifier)

func ClearModifiers() -> void:
	for attribute_name in modifiers:
		for modifier in modifiers[attribute_name].array:
			aggregators[attribute_name].RemoveModifier(modifier)
			
	modifiers.clear()

func ApplyEffect() -> void:
	var target_attribute_manager: AttributeManagerBase = effect_target.find_children("", "AttributeManagerBase")[0]
	
	for attribute_name in modifiers:
		if target_attribute_manager.HasAttribute(attribute_name):
			for modifier in modifiers[attribute_name].array:
				var aggregator: Aggregator
				
				match duration_policy:
					Util.EDurationPolicy.INSTANT:
						aggregator = Aggregator.new(target_attribute_manager.GetAttribute(attribute_name))
						aggregator.AddModifier(modifier)
						
						target_attribute_manager.SetAttributeBaseValue(attribute_name, aggregator.Calculate())
					Util.EDurationPolicy.DURATION:
						if target_attribute_manager.HasAggregator(attribute_name):
							aggregator = target_attribute_manager.GetAggregator(attribute_name)
							aggregator.AddModifier(modifier)
						else:
							aggregator = target_attribute_manager.CreateAggregator(attribute_name) 
							aggregator.AddModifier(modifier)
							
							target_attribute_manager.SetAttributeCurrentValue(attribute_name, aggregator.Calculate())
					Util.EDurationPolicy.INFINITE:
						if target_attribute_manager.HasAggregator(attribute_name):
							aggregator = target_attribute_manager.GetAggregator(attribute_name)
							aggregator.AddModifier(modifier)
						else:
							aggregator = target_attribute_manager.CreateAggregator(attribute_name) 
							aggregator.AddModifier(modifier)
							
						target_attribute_manager.SetAttributeCurrentValue(attribute_name, aggregator.Calculate())
				
				aggregators[attribute_name] = aggregator

func EndEffect() -> void:
	pass
