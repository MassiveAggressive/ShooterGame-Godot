class_name AttributeManagerBase extends Node

signal AttributesCalculated(new_attributes: Dictionary[String, float])
signal AttributeChanged(name: String, value: float)
signal AttributeChangedByEffect(name: String, value: float, effect: EffectBase)

@export var attributes: Dictionary[String, Attribute]
var aggregators: Dictionary[String, Aggregator]

func InitializeAttribute(attribute_name: String, value: float = 0.0) -> Attribute:
	if attributes.has(attribute_name):
		return attributes[attribute_name]
	else:
		var new_attribute: Attribute = Attribute.new(attribute_name, value)
		
		attributes[attribute_name] = new_attribute
		
		return new_attribute

func HasAttribute(attribute_name: String) -> bool:
	return attributes.has(attribute_name)

func GetAttribute(attribute_name: String) -> Attribute:
	return attributes[attribute_name]

func SetAttributeBaseValue(attribute_name: String, new_value: float) -> void:
	attributes[attribute_name].base_value

func GetAttributeBaseValue(attribute_name: String) -> float:
	return attributes[attribute_name].base_value

func SetAttributeCurrentValue(attribute_name: String, new_value: float) -> void:
	attributes[attribute_name].current_value = new_value

func GetAttributeCurrentValue(attribute_name: String) -> float:
	return attributes[attribute_name].current_value

func CreateAggregator(attribute_name: String) -> Aggregator:
	var new_aggregator: Aggregator = Aggregator.new(attributes[attribute_name])
	
	aggregators[attribute_name] = new_aggregator
	
	return new_aggregator

func AddAggregator(attribute_name: String, aggregator: Aggregator) -> void:
	aggregators[attribute_name] = aggregator

func HasAggregator(attribute_name: String) -> bool:
	return aggregators.has(attribute_name)

func GetAggregator(attribute_name: String) -> Aggregator:
	return aggregators[attribute_name]

func PreAttributeBaseChange(attribute_name: String, new_value: float) -> void:
	pass

func PreAttributeChange(attribute_name: String, new_value: float) -> void:
	pass

func PostAttributeChange(attribute_name: String, new_value: float, old_value) -> void:
	pass
