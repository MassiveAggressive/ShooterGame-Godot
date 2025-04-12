class_name HealthAttributesDriver
extends AttributesDriver

signal Destroy

var health_bar_ui: ProgressBar

func _enter_tree() -> void:
	super._enter_tree()
	health_bar_ui = get_parent().get_node("%HealthBar")
	
func OnAttributeChanged(attribute_name: String, Value: float):
	if attribute_name == "Health" or attribute_name == "MaxHealth":
		if attribute_container.HasAttribute("MaxHealth"):
			health_bar_ui.value = attribute_container.GetAttribute("Health") / attribute_container.GetAttribute("MaxHealth")
		else:
			health_bar_ui.value = attribute_container.GetAttribute("Health") / 1
		
		if attribute_name == "MaxHealth":
			attribute_container.SetAttributeByDriver("Health", attribute_container.GetAttribute("MaxHealth"))
		
		if attribute_name == "Health" and Value <= 0.0:
			Destroy.emit()
