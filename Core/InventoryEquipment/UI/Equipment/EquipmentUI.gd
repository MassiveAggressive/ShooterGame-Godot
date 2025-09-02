@tool
class_name EquipmentUI extends HBoxContainer

var equipment_panel_ui_scene: PackedScene = preload("uid://bpr72rfdiax2u")
var equipment_panels: Dictionary[Util.EItemPrimaryType, EquipmentPanelUI]
var item_uis: Dictionary[Util.EItemPrimaryType, Array]

var equipment_slot_sizes: Dictionary[Util.EItemPrimaryType, int]

func CreatePanel(slot_sizes: Dictionary[Util.EItemPrimaryType, int]) -> Dictionary[Util.EItemPrimaryType, Array]:
	for key in Util.EItemPrimaryType.keys().size():
		var equipment_panel_ui_temp: EquipmentPanelUI = equipment_panel_ui_scene.instantiate()
		equipment_panel_ui_temp.panel_type = key
		
		item_uis[key] = equipment_panel_ui_temp.CreatePanel(slot_sizes[key])
		
		%EquipmentPanelContainer.add_child(equipment_panel_ui_temp)
		
	return item_uis

func GetItemUIS() -> Dictionary[Util.EItemPrimaryType, Array]:
	return item_uis
