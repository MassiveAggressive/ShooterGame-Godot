class_name ItemBase
extends Node2D

@export var owner_node: Node
var item: Item

var owner_attribute_container: AttributeSetBase

func _ready() -> void:
	owner_attribute_container = owner_node.find_children("", "AttributeSetBase")[0]
	
	for attribute_name in owner_attribute_container.attributes:
		OnAttributeChanged(attribute_name, owner_attribute_container.attributes[attribute_name].current_value)
	
	owner_attribute_container.AttributeChanged.connect(OnAttributeChanged)
	
func OnAttributeChanged(name: String, value: float) -> void:
	pass
