class_name InGameAttributeContainer extends AttributeContainerBase

func _ready() -> void:
	raw_attributes["MenuAttributes"] = DataCarrier.data["attributes"]
	
	AttributesChanged.emit(attributes)
	for attribute_name in attributes:
		AttributeChanged.emit(attribute_name, attributes[attribute_name])
