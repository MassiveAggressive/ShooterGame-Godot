class_name LevelAttributesDriver
extends AttributesDriver

func OnAttributeChanged(attribute_name: String, value: float) -> void:
	if(attribute_name == "Level"):
		print("LEVELED UP")
