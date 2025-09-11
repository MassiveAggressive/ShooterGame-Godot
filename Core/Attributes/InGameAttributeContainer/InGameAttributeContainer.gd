class_name InGameAttributeContainer extends AttributeManagerBase

func _ready() -> void:
	default_attributes["MenuAttributes"] = DataCarrier.data["attributes"]
	CalculateAttributes()
