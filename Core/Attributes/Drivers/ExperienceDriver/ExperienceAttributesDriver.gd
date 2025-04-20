class_name ExperienceAttributesDriver
extends AttributesDriver

func OnAttributeChangedByEffect(attribute_name: String, value: float, effect: EffectBase) -> void:
	print("Killed ", effect.effect_target.unit_data.Name, " - Earned: ", value, " experience")
