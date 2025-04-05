@tool
extends VBoxContainer

class_name InventoryPanelUI

@export var PanelType:= Enums.EItemSecondaryType.PRIMARYWEAPON

var ItemUIScene: PackedScene = preload("uid://dva8aop20v0ie")
var SpaceScene: PackedScene = preload("uid://pdsmrkga7far")

var GridTheme: Theme = preload("uid://buufd48x0pmbc")

var Grids: Array[GridContainer]
var Spaces: Array[Control]

var ItemUIs: Array

@export_tool_button("Create Panel")
var CreatePanelBtn = CreatePanel

@export_tool_button("Destroy Panel")
var DestroyPanelBtn = DestroyPanel

func CreatePanel() -> Array:
	if Grids.size() > 0:
		var TempSpace: Control = SpaceScene.instantiate()
		Spaces.append(TempSpace)
		
		add_child(TempSpace)
		
	var TempGrid: GridContainer = GridContainer.new()
	TempGrid.columns = 5
	TempGrid.theme = GridTheme
	
	Grids.append(TempGrid)
	
	add_child(TempGrid)
	
	for i in range(25):
		var ItemUIRef: Control = ItemUIScene.instantiate()
		ItemUIs.append(ItemUIRef)
		TempGrid.add_child(ItemUIRef)
	
	return ItemUIs

func DestroyPanel() -> void:
	for i in range(25):
		ItemUIs[ItemUIs.size() - 25 + i].queue_free()
	ItemUIs = ItemUIs.slice(0, ItemUIs.size() - 25)
	
	Grids[Grids.size() - 1].queue_free()
	Grids.remove_at(Grids.size() - 1)
	
	if !Spaces.is_empty():
		Spaces[Spaces.size() - 1].queue_free()
		Spaces.remove_at(Spaces.size() - 1)
