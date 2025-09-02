@tool
class_name InventoryUI extends VBoxContainer

var owner_inventory_equipment: InventoryEquipmentBase

var inventory_panel_ui_scene: PackedScene = preload("uid://8qvx1213p1kd")
var inventory_panels: Dictionary[Util.EItemSecondaryType, InventoryPanelUI]
var item_uis: Dictionary[Util.EItemSecondaryType, Array]

var item_locations: Dictionary[int, ItemUI]

var inventory_navigate_button_scene: PackedScene = preload("uid://c4ghi0vyalffk")

func _enter_tree() -> void:
	CreateNavigateButtons()

func CreatePanel() -> Dictionary[Util.EItemSecondaryType, Array]:
	for key in range(Util.EItemSecondaryType.keys().size()):
		var inventory_panel_ui_temp: InventoryPanelUI = inventory_panel_ui_scene.instantiate()
		inventory_panel_ui_temp.panel_type = key
		inventory_panel_ui_temp.CreatePanel()
		item_uis[key] = inventory_panel_ui_temp.CreatePanel()
		
		for item_ui in item_uis[key]:
			item_ui = item_ui as ItemUI
			item_ui.owner_inventory_equipment = owner_inventory_equipment
		
		inventory_panels[key] = inventory_panel_ui_temp
		%InventoryPanels.add_child(inventory_panel_ui_temp)
		
	return item_uis

func CreateNavigateButtons() -> void:
	for child in %NavigateButtonsPanel.get_children():
		child.queue_free()
		
	for key in range(Util.EItemSecondaryType.keys().size()):
		var navigate_button_temp: InventoryNavigateButton = inventory_navigate_button_scene.instantiate()
		navigate_button_temp.button_type = key
		
		%NavigateButtonsPanel.add_child(navigate_button_temp)
		
		navigate_button_temp.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND
		
		navigate_button_temp.Navigate.connect(OnNavigate)

func OnNavigate(panel_type: Util.EItemSecondaryType) -> void:
	%InventoryPanels.current_tab = panel_type

func GetItemUIs() -> Dictionary[Util.EItemSecondaryType, Array]:
	return item_uis

func OnItemAddedToInventory(item: Item) -> void:
	var added: bool = false
	for item_ref in item_uis[item.item_info.secondary_type]:
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
