@tool
class_name InventoryUI
extends VBoxContainer

var owner_inventory_equipment: InventoryEquipment

var inventory_panel_ui_scene: PackedScene = preload("uid://2xwyli2wd2uv")
var inventory_panels: Dictionary[Enums.EItemSecondaryType, InventoryPanelUI]
var item_uis: Dictionary[Enums.EItemSecondaryType, Array]

var item_locations: Dictionary[int, ItemUI]

func _enter_tree() -> void:
	if owner_inventory_equipment:
		owner_inventory_equipment.ItemAddedToInventory.connect(OnItemAddedToInventory)
		owner_inventory_equipment.ItemRemovedFromInventory.connect(OnItemRemovedFromInventory)
		
	var popup: PopupMenu = %MenuButton.get_popup()
	popup.clear()
	
	for i in range(Enums.EItemSecondaryType.keys().size()):
		var inventory_panel_ui_temp: InventoryPanelUI = inventory_panel_ui_scene.instantiate()
		inventory_panel_ui_temp.panel_type = i as Enums.EItemSecondaryType
		inventory_panel_ui_temp.CreatePanel()
		item_uis[i] = inventory_panel_ui_temp.CreatePanel()
		
		for item_ui in item_uis[i]:
			item_ui = item_ui as ItemUI
			item_ui.ItemClicked.connect(OnItemClicked)
			item_ui.owner_inventory_equipment = owner_inventory_equipment
		
		inventory_panels[i] = inventory_panel_ui_temp
		%InventoryPanels.add_child(inventory_panel_ui_temp)
		
		popup.add_item(Enums.ItemSecondaryTypeData[i], i)
	
	popup.id_pressed.connect(OnMenuItemSelected)

func GetItemUIs() -> Dictionary[Enums.EItemSecondaryType, Array]:
	return item_uis

func OnItemClicked(item_ui: ItemUI) -> void:
	match owner_inventory_equipment.FindItem(item_ui.item.item_id):
		Enums.EItemLocation.ININVENTORY:
			owner_inventory_equipment.SendItemToEquipment(item_ui.item.item_id)
		Enums.EItemLocation.INEQUIPMENT:
			owner_inventory_equipment.SendItemToInventory(item_ui.item.item_id)

func OnItemAddedToInventory(item: Item) -> void:
	var added: bool = false
	for item_ref in item_uis[item.item_info.item_secondary_type]:
		if item_ref.available:
			item_ref.SetItem(item)
			item_locations[item.item_id] = item_ref
			added = true
			break
			
	if !added:
		pass

func OnItemRemovedFromInventory(item_id: int) -> void:
	item_locations[item_id].SetItem()
	item_locations.erase(item_id)

	
func OnMenuItemSelected(id: int) -> void:
	%InventoryPanels.current_tab = id
