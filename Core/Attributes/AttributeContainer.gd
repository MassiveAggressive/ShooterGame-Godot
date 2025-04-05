extends Node

class_name AttributeContainer

@export var Attributes: Dictionary[String, float]

@export var RawAttributes: Dictionary[String, Dictionary]

signal AttributeChanged(Name: String, Value: float)

func _ready() -> void:
	print("Attributes")
	CalculateAttributes()

func AddAttribute(Name: String) -> void:
	if Attributes.has(Name):
		pass
	else:
		Attributes[Name] = 0.0
	
func SetAttribute(Name: String, Value: float) -> void:
	Attributes[Name] = Value
	AttributeChanged.emit(Name, Value)

func GetAttribute(Name: String) -> float:
	if Attributes.has(Name):
		return Attributes[Name]
	else:
		return 0
	
func HasAttribute(Name: String) -> bool:
	return Attributes.has(Name)
	
func AddAttributesRaw(AttributesFrom: String, NewAttributes: Dictionary):
	RawAttributes[AttributesFrom] = NewAttributes
	CalculateAttributes()
	
func CalculateAttributes() -> void:
	var TempAttributes: Dictionary[String, float]
	
	for RawName in RawAttributes:
		for AttributeName in RawAttributes[RawName]:
			TempAttributes[AttributeName] = TempAttributes.get(AttributeName, 0) + RawAttributes[RawName][AttributeName]
			
	Attributes = TempAttributes
	
	for name in Attributes:
		AttributeChanged.emit(name, Attributes[name])
