class_name AttributeContainer
extends Node

@export var attributes: Dictionary[String, float]

@export var raw_attributes: Dictionary[String, Dictionary]

@export var exhibited_attributes: Dictionary[String, Attribute]

signal AttributesChanged(NewAttributes: Dictionary[String, float])
signal AttributeChanged(Name: String, Value: float)

func _ready() -> void:
	CalculateAttributes()

func AddAttribute(attribute_name: String) -> void:
	if attributes.has(attribute_name):
		pass
	else:
		attributes[attribute_name] = 0.0
	
func SetAttribute(attribute_name: String, Value: float) -> void:
	attributes[attribute_name] = Value
	AttributeChanged.emit(attribute_name, Value)

func SetAttributeByDriver(attribute_name: String, value: float) -> void:
	attributes[attribute_name] = value

func GetAttribute(attribute_name: String) -> float:
	if attributes.has(attribute_name):
		return attributes[attribute_name]
	else:
		return 0
	
func HasAttribute(attribute_name: String) -> bool:
	return attributes.has(attribute_name)

func InitializeAttributes(attributes_raw_name: String, initialized_attributes: Array[String]):
	var attributes_temp: Dictionary
	for attribute_name in initialized_attributes:
		attributes_temp[attribute_name] = 0.0
		
	raw_attributes[attributes_raw_name] = attributes_temp
	
	exhibited_attributes.merge(exhibited_attributes)

func AddAttributesRaw(attribute_raw_name: String, new_raw_attributes: Dictionary):
	raw_attributes[attribute_raw_name] = new_raw_attributes
	CalculateAttributes()
	
func CalculateAttributes() -> void:
	var temp_attributes: Dictionary[String, float]
	
	for raw_name in raw_attributes:
		for attribute_name in raw_attributes[raw_name]:
			temp_attributes[attribute_name] = temp_attributes.get(attribute_name, 0) + raw_attributes[raw_name][attribute_name]
			
	attributes = temp_attributes
	
	AttributesChanged.emit(attributes)
	for attribute_name in attributes:
		AttributeChanged.emit(attribute_name, attributes[attribute_name])
