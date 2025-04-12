@tool

class_name InventoryPanelUI
extends VBoxContainer

@export var panel_type: Enums.EItemSecondaryType

var item_ui_scene: PackedScene = preload("uid://dva8aop20v0ie")
var space_scene: PackedScene = preload("uid://pdsmrkga7far")

var grid_theme: Theme = preload("uid://buufd48x0pmbc")

var grids: Array[GridContainer]
var spaces: Array[Control]

var item_uis: Array[ItemUI]

@export_tool_button("Create Panel")
var create_panel_button = CreatePanel

@export_tool_button("Destroy Panel")
var destroy_panel_button = DestroyPanel
	
func CreatePanel() -> Array:
	if grids.size() > 0:
		var TempSpace: Control = space_scene.instantiate()
		spaces.append(TempSpace)
		
		add_child(TempSpace)
		
	var grid_temp: GridContainer = GridContainer.new()
	grid_temp.columns = 5
	grid_temp.theme = grid_theme
	
	grids.append(grid_temp)
	
	add_child(grid_temp)
	
	for i in range(25):
		var item_ui_scene_temp: Control = item_ui_scene.instantiate()
		item_uis.append(item_ui_scene_temp)
		grid_temp.add_child(item_ui_scene_temp)
	
	return item_uis

func DestroyPanel() -> void:
	for i in range(25):
		item_uis[item_uis.size() - 25 + i].queue_free()
	item_uis = item_uis.slice(0, item_uis.size() - 25)
	
	grids[grids.size() - 1].queue_free()
	grids.remove_at(grids.size() - 1)
	
	if !spaces.is_empty():
		spaces[spaces.size() - 1].queue_free()
		spaces.remove_at(spaces.size() - 1)

func GetItemUIs() -> Array[ItemUI]:
	return item_uis
