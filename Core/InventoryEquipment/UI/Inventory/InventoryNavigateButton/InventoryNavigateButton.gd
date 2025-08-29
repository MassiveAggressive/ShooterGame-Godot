@tool
class_name InventoryNavigateButton extends Button

signal Navigate(panel_type: Util.EItemSecondaryType)

@export var button_type: Util.EItemSecondaryType:
	set(value):
		button_type = value
		$".".text = Util.ItemSecondaryTypeData[button_type][0]

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		Navigate.emit(button_type)
