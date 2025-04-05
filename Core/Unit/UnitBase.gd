class_name UnitBase
extends Area2D

@export var unit_data: UnitData

@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var ha_driver: HealthAttributesDriver = $HealthAttributesDriver

func _ready() -> void:
	attribute_container.AddAttributesRaw("BaseAttributes", unit_data.BaseAttributes)
	ha_driver.Destroy.connect(OnDestroy)
	
func OnDestroy():
	queue_free()
