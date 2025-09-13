class_name ExperienceAttributesDriver
extends AttributesDriver

@onready var experience_effect: PackedScene = preload("uid://cc4qcg5vi62w0")
@onready var experiences: Experience = preload("uid://dcarfc7t4w3y0")
var current_level: int = 1

func OnAttributeChangedByEffect(attribute_name: String, value: float, effect: EffectBase) -> void:
	if attribute_name == "Experience":
		if current_level >= experiences.Experiences.size():
			pass
		else:
			if value >= experiences.Experiences[current_level]:
				var temp_effect: EffectBase = experience_effect.instantiate() as EffectBase
				temp_effect.InitializeEffect(owner, owner)
				temp_effect.ApplyEffect()
				attribute_container.SetAttributeByDriver("Experience", attribute_container.GetAttributeValue("Experience") - experiences.Experiences[current_level - 1])

func OnAttributeChanged(attribute_name: String, value: float) -> void:
	if attribute_name == "Level":
		current_level = value
