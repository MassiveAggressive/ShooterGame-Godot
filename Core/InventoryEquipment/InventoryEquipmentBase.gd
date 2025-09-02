class_name InventoryEquipmentBase extends Node

signal ItemAddedToInventory(Item)
signal ItemRemovedFromInventory(int)
signal ItemAddedToEquipment(Item)
signal ItemRemovedFromEquipment(int)

@export var inventory: Dictionary[int, Item]

@export var equipment: Dictionary[Util.EItemPrimaryType, Dictionary]

@export var equipment_slot_sizes: Dictionary[Util.EItemPrimaryType, int]:
	set(value):
		equipment_slot_sizes = value
		for key in equipment_slot_sizes.keys():
			equipment.set(key, {})

var item_locations: Dictionary[int, ItemLocation]

var inventory_equipment_ui_scene: PackedScene = preload("uid://cma6hfh4v44w3")
var inventory_equipment_ui: InventoryEquipmentUI

@export var item1: ItemInfo

func _ready() -> void:
	inventory_equipment_ui = inventory_equipment_ui_scene.instantiate()
	inventory_equipment_ui.owner_inventory_equipment = self
	WindowsManager.AddWindow("Inventory Equipment", inventory_equipment_ui)
	
	AddNewItemToInventory(item1)
	AddNewItemToInventory(item1)
	AddNewItemToInventory(item1)

func FindItem(item_id: int) -> Util.EItemLocation:
	return item_locations[item_id].item_location

func CreateNewItemID() -> int:
	if inventory.is_empty():
		return 0
	else:
		return (inventory.keys().max() + 1)
		
func AddNewItemToInventory(new_item_info: ItemInfo) -> void:
	var new_item = Item.new()
	new_item.item_info = new_item_info
	new_item.item_id = CreateNewItemID()
	AddItemToInventory(new_item)
	
func AddItemToInventory(new_item: Item) -> bool:
	inventory[new_item.item_id] = new_item
	item_locations[new_item.item_id] = ItemLocation.new(Util.EItemLocation.ININVENTORY, new_item.item_info.primary_type)
	
	ItemAddedToInventory.emit(new_item)
	
	return true
	
func SendItemToEquipment(item_id: int) -> void:
	var item_location: ItemLocation = item_locations[item_id]
	
	if item_location.item_location == Util.EItemLocation.ININVENTORY:
		if AddItemToEquipment(inventory[item_id]):
			inventory.erase(item_id)
			ItemRemovedFromInventory.emit(item_id)

func AddItemToEquipment(new_item: Item) -> bool:
	var item_type = new_item.item_info.primary_type
	if equipment[item_type].keys().size() < equipment_slot_sizes[item_type]:
		var items: Dictionary = equipment[item_type]
		items[new_item.item_id] = new_item
		item_locations[new_item.item_id] = ItemLocation.new(Util.EItemLocation.INEQUIPMENT, new_item.item_info.primary_type)
		
		equipment[item_type] = items
		
		ItemAddedToEquipment.emit(new_item)
		
		return true
		
	return false

func SendItemToInventory(item_id: int) -> void:
	var item_location: ItemLocation = item_locations[item_id]
	
	if item_location.item_location == Util.EItemLocation.INEQUIPMENT:
		if AddItemToInventory(equipment[item_location.primary_type][item_id]):
			equipment[item_location.primary_type].erase(item_id)
			
			ItemRemovedFromEquipment.emit(item_id)
