class_name HealthAttributesDriver
extends AttributesDriver

signal Destroy

var HealthBar: ProgressBar

func _enter_tree() -> void:
	super._enter_tree()
	HealthBar = get_parent().get_node("%HealthBar")
	
func OnAttributeChanged(Name: String, Value: float):
	if Name == "Health" or Name == "MaxHealth":
		if ContainerRef.HasAttribute("MaxHealth"):
			HealthBar.value = ContainerRef.GetAttribute("Health") / ContainerRef.GetAttribute("MaxHealth")
		else:
			HealthBar.value = ContainerRef.GetAttribute("Health") / 1
		
		if Name == "Health" and Value <= 0.0:
			Destroy.emit()
