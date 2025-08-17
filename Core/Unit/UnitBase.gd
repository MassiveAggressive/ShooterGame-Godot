class_name UnitBase
extends Area2D

@export var unit_data: UnitData

@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var ha_driver: HealthAttributesDriver = $HealthAttributesDriver

func _ready() -> void:
	attribute_container.AddAttributesRaw("BaseAttributes", unit_data.BaseAttributes.values()[0].attributes)
	ha_driver.Destroy.connect(OnDestroy)

func OnDestroy(destroyer_unit: UnitBase):
	var experience_effect = preload("uid://5o0rsnpxfx0s").instantiate()
	
	experience_effect.modifiers[0].attribute_magnitude = attribute_container.GetAttribute("Experience")
	experience_effect.InitializeEffect(self, destroyer_unit)
	experience_effect.ApplyEffect()
	
	queue_free()
