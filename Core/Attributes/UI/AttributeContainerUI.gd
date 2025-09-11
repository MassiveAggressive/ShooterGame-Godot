class_name AttributeContainerUI
extends VBoxContainer

@export var exhibited_attributes: Array[String]
@export var exhibited_attributes_data: Dictionary[String, String]

var owner_attribute_container: AttributeContainerBase

@export var attribute_ui_scene: PackedScene = preload("uid://bax61lplxphv3")
var attribute_uis: Dictionary[String, AttributeUI]

func _enter_tree() -> void:
	CreateAttributesUI()

func _ready() -> void:
	owner_attribute_container.AttributesChanged.connect(OnAttributeChanged)
	SetAttributesUI(owner_attribute_container.attributes)

func OnAttributeChanged(new_attributes: Dictionary[String, float]) -> void:
	SetAttributesUI(new_attributes)

func SetAttributesUI(new_attributes: Dictionary[String, float]) -> void:
	for attribute_name in exhibited_attributes:
		if new_attributes.has(attribute_name):
			attribute_uis[attribute_name].SetValue(new_attributes[attribute_name])
			
func CreateAttributesUI() -> void:
	for attribute_name in exhibited_attributes:
		var attribute_ui: AttributeUI = attribute_ui_scene.instantiate()
		attribute_ui.SetLabels(exhibited_attributes_data[attribute_name], 0.0)
		attribute_uis[attribute_name] = attribute_ui
		add_child(attribute_ui)
