class_name NewAttributeManagerBase extends Node

signal AttributesChanged(new_attributes: Dictionary[String, float])
signal AttributeChanged(name: String, value: float)
signal AttributeChangedByEffect(name: String, value: float, effect: EffectBase)

@export var attributes: Dictionary[String, Attribute]
@export var base_attributes: Dictionary[String, Dictionary]

func AddAttribute(attribute_name: String) -> void:
	if attributes.has(attribute_name):
		pass
	else:
		attributes[attribute_name].value = 0.0

func SetAttribute(attribute_name: String, value: float) -> void:
	attributes[attribute_name].value
	AttributeChanged.emit(attribute_name, value)

func SetAttributeByEffect(attribute_name: String, value: float, effect: EffectBase) -> void:
	attributes[attribute_name].value
	AttributeChanged.emit(attribute_name, value)
	AttributeChangedByEffect.emit(attribute_name, value, effect)

func SetAttributeByDriver(attribute_name: String, value: float) -> void:
	attributes[attribute_name].value

func GetAttribute(attribute_name: String) -> float:
	if attributes.has(attribute_name):
		return attributes[attribute_name].value
	else:
		return 0

func HasAttribute(attribute_name: String) -> bool:
	return attributes.has(attribute_name)

func InitializeAttributes(attributes_raw_name: String, initialized_attributes: Array[String]):
	var attributes_temp: Dictionary
	
	for attribute_name in initialized_attributes:
		attributes_temp[attribute_name] = 0.0
		
	base_attributes[attributes_raw_name] = attributes_temp
	
	CalculateAttributes()

func AddAttributesRaw(attribute_raw_name: String, new_raw_attributes: Dictionary):
	base_attributes[attribute_raw_name] = new_raw_attributes
	
	CalculateAttributes()

func CalculateAttributes() -> void:
	var temp_attributes: Dictionary[String, float]

	for raw_name in base_attributes:
		for attribute_name in base_attributes[raw_name]:
			temp_attributes[attribute_name] = temp_attributes.get(attribute_name, 0) + base_attributes[raw_name][attribute_name]
	
	for attribute_name in temp_attributes:
		attributes[attribute_name].value = temp_attributes[attribute_name]
