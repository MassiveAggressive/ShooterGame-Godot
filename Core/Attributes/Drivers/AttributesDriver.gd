class_name AttributesDriver
extends Node

var attribute_container: AttributeContainer

@export var raw_name: String = "Attributes"
@export var initialized_attributes: Dictionary[String, float]

func _enter_tree() -> void:
	attribute_container = get_parent().get_node("AttributeContainer")
	attribute_container.AddAttributesRaw(raw_name, initialized_attributes)
	attribute_container.AttributeChanged.connect(OnAttributeChanged)
	
func OnAttributeChanged(attribute_name: String, value: float) -> void:
	pass
