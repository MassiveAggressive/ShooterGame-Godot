class_name MenuInventoryEquipment extends Node

@export var owner_unit: Node

var inventory: Dictionary[int, Item]

@export var equipment_slot_sizes: Dictionary[Enums.EItemPrimaryType, int]:
	set(value):
		equipment_slot_sizes = value
		for key in equipment_slot_sizes.keys():
			equipment.set(key, {})
		
@export var equipment: Dictionary[Enums.EItemPrimaryType, Dictionary]

@export var owners_attribute_container: AttributeContainer
var attributes: Dictionary[String, float]

var item_locations: Dictionary[int, ItemLocation]

signal ItemAddedToInventory(Item)
signal ItemRemovedFromInventory(int)
signal ItemAddedToEquipment(Item)
signal ItemRemovedFromEquipment(int)

var inventory_equipment_ui_scene: PackedScene = preload("uid://byffou1ig3ymq")
var inventory_equipment_ui: InventoryEquipmentUI

var item1: ItemInfo = preload("uid://c70j54wftetyk")
var item2: ItemInfo = preload("uid://cpgfmbc5snce7")

func _ready() -> void:
	owner_unit = get_parent()
	owners_attribute_container = owner_unit.get_node("AttributeContainer")
	
	inventory_equipment_ui = inventory_equipment_ui_scene.instantiate()
	inventory_equipment_ui.owner_inventory_equipment = self
	
	Global.AddUIToScreen(inventory_equipment_ui)
	
	var new_item = Item.new()
	new_item.item_info = item1
	new_item.item_id = CreateNewItemID()
	AddItemToInventory(new_item)
	
	WindowsManager.AddWindow("Inventory Eqpuipment", inventory_equipment_ui)

func FindItem(item_id: int) -> Enums.EItemLocation:
	return item_locations[item_id].item_location

func CreateNewItemID() -> int:
	if inventory.is_empty():
		return 1
	else:
		return (inventory.keys().max() + 1)

func AddNewItemToInventory(new_item_info: ItemInfo) -> void:
	var new_item = Item.new()
	new_item.item_info = new_item_info
	new_item.item_id = CreateNewItemID()
	AddItemToInventory(new_item)
	
func AddItemToInventory(new_item: Item) -> bool:
	inventory[new_item.item_id] = new_item
	item_locations[new_item.item_id] = ItemLocation.new(Enums.EItemLocation.ININVENTORY, new_item.item_info.item_primary_type)
	
	ItemAddedToInventory.emit(new_item)
	
	return true

func SendItemToEquipment(item_id: int) -> void:
	var item_location: ItemLocation = item_locations[item_id]
	
	if item_location.item_location == Enums.EItemLocation.ININVENTORY:
		if AddItemToEquipment(inventory[item_id]):
			inventory.erase(item_id)
			ItemRemovedFromInventory.emit(item_id)

func AddItemToEquipment(new_item: Item) -> bool:
	var item_type = new_item.item_info.item_primary_type
	if equipment[item_type].keys().size() < equipment_slot_sizes[item_type]:
		var items: Dictionary = equipment[item_type]
		items[new_item.item_id] = new_item
		item_locations[new_item.item_id] = ItemLocation.new(Enums.EItemLocation.INEQUIPMENT, new_item.item_info.item_primary_type)
		
		equipment[item_type] = items
		
		CalculateAttributes()
		
		ItemAddedToEquipment.emit(new_item)
		
		return true
		
	return false

func SendItemToInventory(item_id: int) -> void:
	var item_location: ItemLocation = item_locations[item_id]
	
	if item_location.item_location == Enums.EItemLocation.INEQUIPMENT:
		if AddItemToInventory(equipment[item_location.item_primary_type][item_id]):
			equipment[item_location.item_primary_type].erase(item_id)
			
			CalculateAttributes()
			
			ItemRemovedFromEquipment.emit(item_id)

func CalculateAttributes() -> void:
	var temp_attributes: Dictionary[String, float]

	for item_type in equipment.keys():
		for item_id in equipment[item_type].keys():
			var item = equipment[item_type][item_id] as Item
			var attributes_temp: Dictionary[String, float] = item.item_info.attributes
			for attribute_name in item.item_info.attributes.keys():
				temp_attributes[attribute_name] = temp_attributes.get(attribute_name, 0) + attributes_temp[attribute_name]
	
	attributes = temp_attributes
	
	owners_attribute_container.AddAttributesRaw("InventoryEquipment", attributes)
