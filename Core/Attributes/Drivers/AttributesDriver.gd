class_name AttributesDriver
extends Node

var ContainerRef: AttributeContainer

@export var RawName: String = "Attributes"
@export var InitAttributes: Dictionary[String, float]

func _enter_tree() -> void:
	ContainerRef = get_parent().get_node("AttributeContainer")
	ContainerRef.AddAttributesRaw(RawName, InitAttributes)
	ContainerRef.AttributeChanged.connect(OnAttributeChanged)
	
func OnAttributeChanged(Name: String, Value: float):
	pass
