class_name HealthAttributesDriver extends AttributesDriver

signal Destroy(DestroyerUnit: UnitBase)

var health_bar_ui: ProgressBar

func _ready() -> void:
	super._ready()
	health_bar_ui = get_parent().get_node("%HealthBar")
	
func OnAttributeChangedByEffect(attribute_name: String, Value: float, effect: EffectBase) -> void:
	if attribute_name == "Health" or attribute_name == "MaxHealth":
		health_bar_ui.value = attribute_container.GetAttribute("Health") / attribute_container.GetAttribute("MaxHealth")

		if attribute_name == "MaxHealth":
			attribute_container.SetAttributeByDriver("Health", attribute_container.GetAttribute("MaxHealth"))
		
		if attribute_name == "Health" and Value <= 0.0:
			Destroy.emit(effect.effect_owner)
