@tool
class_name EquipmentUI
extends VBoxContainer

var owner_inventory_equipment: InventoryEquipment

var item_ui_scene: PackedScene = preload("uid://dva8aop20v0ie")
var space_scene: PackedScene = preload("uid://pdsmrkga7far")

var grid_theme: Theme = preload("uid://buufd48x0pmbc")

var slot_sizes: Dictionary[Enums.EItemPrimaryType, int] = {0:1, 1:1, 2:5}

var grids: Dictionary[Enums.EItemPrimaryType, GridContainer]
var spaces: Array[Control]

var item_uis: Dictionary[Enums.EItemPrimaryType, Array]
var item_locations: Dictionary[int, ItemUI]

@export_tool_button("Create Panel")
var create_panel_button = CreatePanel

@export_tool_button("Destroy Panel")
var destroy_panel_button = DestroyPanel

func _enter_tree() -> void:
	if owner_inventory_equipment:
		owner_inventory_equipment.ItemAddedToEquipment.connect(OnItemAddedToEquipment)
		owner_inventory_equipment.ItemRemovedFromEquipment.connect(OnItemRemovedFromEquipment)
		
		slot_sizes = owner_inventory_equipment.equipment_slot_sizes
		
	CreatePanel(slot_sizes)

func CreatePanel(new_slot_sizes: Dictionary[Enums.EItemPrimaryType, int] = {0: 1, 1: 1, 2:5}) -> Dictionary[Enums.EItemPrimaryType, Array]:
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
			
			new_item_ui.ItemClicked.connect(OnItemClicked)
			new_item_ui.owner_inventory_equipment = owner_inventory_equipment
			
			grid_temp.add_child(new_item_ui)
		
		item_uis[item_type] = item_uis_temp
		
		grids[item_type] = grid_temp
		add_child(grid_temp)
		
	return item_uis

func OnItemClicked(item_ui: ItemUI) -> void:
	match owner_inventory_equipment.FindItem(item_ui.item.item_id):
		Enums.EItemLocation.ININVENTORY:
			owner_inventory_equipment.SendItemToEquipment(item_ui.item.item_id)
		Enums.EItemLocation.INEQUIPMENT:
			owner_inventory_equipment.SendItemToInventory(item_ui.item.item_id)

func DestroyPanel() -> void:
	for key in item_uis.keys():
		for item_ui in item_uis[key]:
			item_ui.queue_free()
		item_uis[key].clear()
	item_uis.clear()
	
	for key in grids.keys():
		grids[key].queue_free()
	grids.clear()
	
	for space in spaces:
		space.queue_free()
	spaces.clear()

func GetItemUIs() -> Dictionary[Enums.EItemPrimaryType, Array]:
	return item_uis
	
func OnItemAddedToEquipment(item: Item) -> void:
	var added: bool = false
	for item_ref in item_uis[item.item_info.item_primary_type]:
		if item_ref.available:
			item_ref.SetItem(item)
			item_locations[item.item_id] = item_ref
			added = true
			break
			
	if !added:
		pass

func OnItemRemovedFromEquipment(item_id: int) -> void:
	item_locations[item_id].SetItem()
	item_locations.erase(item_id)
