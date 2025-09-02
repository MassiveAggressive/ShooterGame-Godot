@tool
class_name EquipmentPanelUI extends VBoxContainer

@export var panel_type: Util.EItemPrimaryType:
	set(value):
		panel_type = value
		%TitleButton.text = Util.ItemPrimaryTypeData[panel_type]
		
var item_ui_scene: PackedScene = preload("uid://ba8x8eovoqcka")
var item_uis: Array[ItemUI]

func OnButtonpressed() -> void:
	if %ExpandableArea.is_expanded:
		%ExpandableArea.Shrink()
	else:
		%ExpandableArea.Expand()

func CreatePanel(item_count: int) -> Array:
	for i in range(item_count):
		var item_ui_temp: ItemUI = item_ui_scene.instantiate()
		item_uis.append(item_ui_temp)
		
		%GridContainer.add_child(item_ui_temp)
		
	return item_uis

func GetItemUIS() -> Array[ItemUI]:
	return item_uis
