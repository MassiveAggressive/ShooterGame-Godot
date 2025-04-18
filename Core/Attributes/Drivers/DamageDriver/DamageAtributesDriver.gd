class_name DamageAttributesDriver
extends AttributesDriver

func OnAttributesChanged(new_attributes: Dictionary[String, float]) -> void:
	if new_attributes["MaxDamage"] != attributes["MaxDamage"]:
		attribute_container.SetAttributeByDriver("Damage", attribute_container.GetAttribute("MaxDamage"))
		
	if new_attributes["MaxFireRate"] != attributes["MaxFireRate"]:
		attribute_container.SetAttributeByDriver("FireRate", attribute_container.GetAttribute("MaxFireRate"))
	
	for attribute_name in initialized_attributes:
		attributes[attribute_name] = new_attributes[attribute_name]
