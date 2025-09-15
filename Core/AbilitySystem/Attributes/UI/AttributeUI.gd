class_name AttributeUI
extends HBoxContainer

func SetLabels(attribute_name: String, value: float) -> void:
	%AttributeName.text = attribute_name
	%Value.text = str(value)

func SetValue(value: float) -> void:
	%Value.text = str(value)
