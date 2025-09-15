class_name DamageAttributesDriver extends AttributesDriver

func OnAttributesCalculated(new_attributes: Dictionary[String, float]) -> void:
	if new_attributes.has("MaxDamage") && attributes["MaxDamage"].base_value == attributes["Damage"].base_value:
		attributes["MaxDamage"].base_value = new_attributes["MaxDamage"]
		attributes["Damage"].base_value = attributes["MaxDamage"].base_value
		
	if new_attributes.has("MaxFireRate") && attributes["MaxFireRate"].base_value == attributes["FireRate"].base_value:
		attributes["MaxFireRate"].base_value = new_attributes["MaxFireRate"]
		attributes["FireRate"].base_value = attributes["MaxFireRate"].base_value
