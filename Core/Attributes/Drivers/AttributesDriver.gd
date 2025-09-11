class_name AttributesDriver
extends Node

var attributes: Dictionary[String, float]

@export var raw_name: String = "Attributes"
@export var initialized_attributes: Array[String]

var attribute_container: AttributeContainerBase

func _ready() -> void:
	attribute_container = get_parent().find_children("", "AttributeContainerBase")[0]
	attribute_container.AttributeChanged.connect(OnAttributeChanged)
	attribute_container.AttributeChangedByEffect.connect(OnAttributeChangedByEffect)
	attribute_container.AttributesChanged.connect(OnAttributesChanged)
	InitializeAttributes()
	
func InitializeAttributes() -> void:
	for attribute_name in initialized_attributes:
		attributes[attribute_name] = 0.0
		
	attribute_container.InitializeAttributes(raw_name, initialized_attributes)

func OnAttributeChanged(attribute_name: String, value: float) -> void:
	pass

func OnAttributeChangedByEffect(attribute_name: String, value: float, effect: EffectBase) -> void:
	pass

func OnAttributesChanged(new_attributes: Dictionary[String, float]) -> void:
	pass
