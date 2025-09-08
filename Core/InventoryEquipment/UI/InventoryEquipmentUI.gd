class_name InventoryEquipmentUI extends HBoxContainer

var owner_inventory_equipment: MenuInventoryEquipment

@onready var equipment_ui: EquipmentUI = %EquipmentUI
@onready var inventory_ui: InventoryUI = %InventoryUI

var inventory_item_uis: Dictionary[Util.EItemSecondaryType, Array]
var equipment_item_uis: Dictionary[Util.EItemPrimaryType, Array]

var inventory_item_locations: Dictionary[int, ItemUI]
var equipment_item_locations: Dictionary[int, ItemUI]

func _ready() -> void:
	equipment_item_uis = equipment_ui.CreatePanel(owner_inventory_equipment.equipment_slot_sizes)
	for key in equipment_item_uis.keys():
		for item_ui in equipment_item_uis[key]:
			item_ui = item_ui as ItemUI
			item_ui.ItemClicked.connect(OnItemClicked)
	
	inventory_item_uis = inventory_ui.CreatePanel()
	for key in inventory_item_uis.keys():
		for item_ui in inventory_item_uis[key]:
			item_ui = item_ui as ItemUI
			item_ui.ItemClicked.connect(OnItemClicked)
			
	owner_inventory_equipment.ItemAddedToInventory.connect(OnItemAddedToInventory)
	owner_inventory_equipment.ItemRemovedFromInventory.connect(OnItemRemovedFromInventory)
	owner_inventory_equipment.ItemAddedToEquipment.connect(OnItemAddedToEquipment)
	owner_inventory_equipment.ItemRemovedFromEquipment.connect(OnItemRemovedFromEquipment)

func OnItemClicked(item: Item) -> void:
	match owner_inventory_equipment.FindItem(item.item_id):
		Util.EItemLocation.ININVENTORY:
			owner_inventory_equipment.MoveItem(item.item_id, Util.EItemLocation.INEQUIPMENT)
		Util.EItemLocation.INEQUIPMENT:
			owner_inventory_equipment.MoveItem(item.item_id, Util.EItemLocation.ININVENTORY)

func OnItemAddedToInventory(item: Item) -> void:
	var added: bool = false
	for item_ref in inventory_item_uis[item.item_info.secondary_type]:
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
	var item_uis: Array = equipment_item_uis[item.item_info.primary_type]
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
