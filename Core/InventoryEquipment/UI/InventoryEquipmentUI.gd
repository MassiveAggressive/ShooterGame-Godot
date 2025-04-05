@tool
extends Control

class_name InventoryEquipmentUI

var OwnerIE: InventoryEquipment

var InventoryPanelUIScene: PackedScene = preload("uid://2xwyli2wd2uv")
var InventoryPanels: Dictionary[int, InventoryPanelUI]
var Items: Dictionary[int, Array]

func _enter_tree() -> void:
	var popup: PopupMenu = %MenuButton.get_popup()
	
	for i in range(Enums.EItemSecondaryType.OTHER + 1):
		var TempInventoryPanelUI: InventoryPanelUI = InventoryPanelUIScene.instantiate()
		TempInventoryPanelUI.PanelType = i
		
		TempInventoryPanelUI.CreatePanel()
		Items[i] = TempInventoryPanelUI.CreatePanel()
		
		InventoryPanels[i] = TempInventoryPanelUI
		
		%TabContainer.add_child(TempInventoryPanelUI)
		
		popup.add_item(Enums.EItemSecondaryTypeData[i], i)
		
	OwnerIE.ItemAdded.connect(OnItemAdded)
	popup.id_pressed.connect(OnMenuItemSelected)
	
func OnItemAdded(item: Item) -> void:
	var Added: bool = false
	for ItemRef in Items[item.item_info.ItemSecondaryType]:
		if ItemRef.Available:
			ItemRef.SetItem(Item)
			Added = true
			break
			
	if !Added:
		pass

func OnMenuItemSelected(id: int) -> void:
	%TabContainer.current_tab = id
