@tool

class_name EquipmentPanelUI
extends VBoxContainer

var item_ui_scene: PackedScene = preload("uid://dva8aop20v0ie")
var space_scene: PackedScene = preload("uid://pdsmrkga7far")

var grid_theme: Theme = preload("uid://buufd48x0pmbc")

var slot_sizes: Dictionary[Enums.EItemPrimaryType, int]

var panels: Dictionary[Enums.EItemPrimaryType, GridContainer]
var spaces: Array[Control]

var item_uis: Dictionary[Enums.EItemPrimaryType, Array]

@export_tool_button("Create Panel")
var create_panel_button = CreatePanel

@export_tool_button("Destroy Panel")
var destroy_panel_button = DestroyPanel

func CreatePanel(new_slot_sizes: Dictionary[Enums.EItemPrimaryType, int] = {0: 10, 1: 5, 2: 3, 3: 3}) -> Dictionary[Enums.EItemPrimaryType, Array]:
	slot_sizes = new_slot_sizes
	for item_type in range(Enums.EItemPrimaryType.keys().size()):
		if item_type != 0:
			var space_temp: Control = space_scene.instantiate()
			spaces.append(space_temp)
		
			add_child(space_temp)
			
		var grid_temp: GridContainer = GridContainer.new()
		grid_temp.columns = 5
		grid_temp.theme = grid_theme
		
		var item_uis_temp: Array
		for i in range(slot_sizes[item_type]):
			var new_item_ui: Control = item_ui_scene.instantiate()
			item_uis_temp.append(new_item_ui)
			
			grid_temp.add_child(new_item_ui)
		
		item_uis[item_type] = item_uis_temp
		
		panels[item_type] = grid_temp
		add_child(grid_temp)
		
	return item_uis

func DestroyPanel() -> void:
	for key in item_uis.keys():
		for i in range(item_uis[key].size()):
			item_uis[key][i].queue_free()
		item_uis[key].clear()
	item_uis.clear()
	
	for key in panels.keys():
		panels[key].queue_free()
	panels.clear()
	
	for space in spaces:
		space.queue_free()
	spaces.clear()

func GetItemUIs() -> Dictionary[Enums.EItemPrimaryType, Array]:
	return item_uis
