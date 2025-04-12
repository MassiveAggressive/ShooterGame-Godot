class_name DamageAttributesDriver
extends AttributesDriver

func OnAttributeChanged(attribute_name: String, value: float) -> void:
	super.OnAttributeChanged(attribute_name, value)
	if attribute_name == "MaxDamage":
		attribute_container.SetAttributeByDriver("Damage", attribute_container.GetAttribute("MaxDamage"))
