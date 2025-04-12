@tool
extends Control

class_name InventoryEquipmentUI

var owner_inventory_equipment: InventoryEquipment

var inventory_panel_ui_scene: PackedScene = preload("uid://2xwyli2wd2uv")
var inventory_panels: Dictionary[int, InventoryPanelUI]
var inventory_item_uis: Dictionary[Enums.EItemSecondaryType, Array]

var equipment_panel_ui_scene: PackedScene = preload("uid://dyy3p11jb8bj6")
var equipment_panel_ui: EquipmentPanelUI
var equipment_item_uis: Dictionary[Enums.EItemPrimaryType, Array]
var equipment_slot_sizes: Dictionary[Enums.EItemPrimaryType, int] = {Enums.EItemPrimaryType.WEAPON: 10, Enums.EItemPrimaryType.GENERATOR: 5, Enums.EItemPrimaryType.EXTRA: 5}

var inventory_item_locations: Dictionary[int, ItemUI]
var equipment_item_locations: Dictionary[int, ItemUI]

func _enter_tree() -> void:
	if owner_inventory_equipment:
		owner_inventory_equipment.ItemAddedToInventory.connect(OnItemAddedToInventory)
		owner_inventory_equipment.ItemRemovedFromInventory.connect(OnItemRemovedFromInventory)
		owner_inventory_equipment.ItemAddedToEquipment.connect(OnItemAddedToEquipment)
		owner_inventory_equipment.ItemRemovedFromEquipment.connect(OnItemRemovedFromEquipment)
		
		equipment_slot_sizes = owner_inventory_equipment.equipment_slot_sizes
		
	var popup: PopupMenu = %MenuButton.get_popup()
	popup.clear()
	
	for i in range(Enums.EItemSecondaryType.keys().size()):
		var inventory_panel_ui_temp: InventoryPanelUI = inventory_panel_ui_scene.instantiate()
		inventory_panel_ui_temp.panel_type = i as Enums.EItemSecondaryType
		inventory_panel_ui_temp.CreatePanel()
		inventory_item_uis[i] = inventory_panel_ui_temp.CreatePanel()
		
		for item_ui in inventory_item_uis[i]:
			item_ui = item_ui as ItemUI
			item_ui.ItemClicked.connect(OnItemClicked)
		
		inventory_panels[i] = inventory_panel_ui_temp
		%InventoryPanels.add_child(inventory_panel_ui_temp)
		
		popup.add_item(Enums.ItemSecondaryTypeData[i], i)
		
	equipment_panel_ui = equipment_panel_ui_scene.instantiate()
	equipment_item_uis = equipment_panel_ui.CreatePanel(equipment_slot_sizes)
	
	for item_type in equipment_item_uis.keys():
		for item_ui in equipment_item_uis[item_type]:
			item_ui = item_ui as ItemUI
			item_ui.ItemClicked.connect(OnItemClicked)
	
	%EquipmentPanel.add_child(equipment_panel_ui)
	
	popup.id_pressed.connect(OnMenuItemSelected)

func OnItemClicked(item_ui: ItemUI) -> void:
	match owner_inventory_equipment.FindItem(item_ui.item.item_id):
		Enums.EItemLocation.ININVENTORY:
			owner_inventory_equipment.SendItemToEquipment(item_ui.item.item_id)
		Enums.EItemLocation.INEQUIPMENT:
			owner_inventory_equipment.SendItemToInventory(item_ui.item.item_id)

func OnItemAddedToInventory(item: Item) -> void:
	var added: bool = false
	for item_ref in inventory_item_uis[item.item_info.item_secondary_type]:
		if item_ref.available:
			item_ref.SetItem(item)
			inventory_item_locations[item.item_id] = item_ref
			added = true
			break
			
	if !added:
		pass

func OnItemRemovedFromInventory(item_id: int) -> void:
	inventory_item_locations[item_id].SetItem()
	inventory_item_locations.erase(item_id)

func OnItemAddedToEquipment(item: Item) -> void:
	var added: bool = false
	var item_uis: Array = equipment_item_uis[item.item_info.item_primary_type]
	for item_ref in item_uis:
		if item_ref.available:
			item_ref.SetItem(item)
			equipment_item_locations[item.item_id] = item_ref
			added = true
			break
			
	if !added:
		pass

func OnItemRemovedFromEquipment(item_id: int) -> void:
	pass
	equipment_item_locations[item_id].SetItem()
	equipment_item_locations.erase(item_id)
	
func OnMenuItemSelected(id: int) -> void:
	%InventoryPanels.current_tab = id
