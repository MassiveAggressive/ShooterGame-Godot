class_name AttributesDriver extends Node

var attributes: Dictionary[String, Attribute]
@export var raw_name: String = "Attributes"
@export var initialized_attributes: Array[String]

var attribute_container: AttributeSetBase

func _ready() -> void:
	attribute_container.AttributeChanged.connect(OnAttributeChanged)
	attribute_container.AttributeChangedByEffect.connect(OnAttributeChangedByEffect)
	attribute_container.AttributesCalculated.connect(OnAttributesCalculated)
	
	InitializeAttributes()
	
func InitializeAttributes() -> void:
	for attribute_name in initialized_attributes:
		attributes[attribute_name] = attribute_container.InitializeAttribute(attribute_name)

func OnAttributeChanged(attribute_name: String, value: float) -> void:
	pass

func OnAttributeChangedByEffect(attribute_name: String, value: float, effect: EffectBase) -> void:
	pass

func OnAttributesCalculated(new_attributes: Dictionary[String, float]) -> void:
	pass
