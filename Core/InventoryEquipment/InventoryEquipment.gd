class_name InventoryEquipment
extends Node

@export var owner_unit: UnitBase

var inventory: Dictionary[int, Item]

@export var equipment_slot_sizes: Dictionary[Enums.EItemPrimaryType, int]
@export var equipment: Dictionary[Enums.EItemPrimaryType, Dictionary]
var created_items: Dictionary[int, ItemBase]

@export var owners_attribute_container: AttributeContainer
var attributes: Dictionary[String, float]

var item_locations: Dictionary[int, ItemLocation]

signal ItemAddedToInventory(Item)
signal ItemRemovedFromInventory(int)
signal ItemAddedToEquipment(Item)
signal ItemRemovedFromEquipment(int)

var inventory_equipment_ui_scene: PackedScene = preload("uid://byffou1ig3ymq")

var item1: ItemInfo = preload("uid://c70j54wftetyk")
var item2: ItemInfo = preload("uid://cpgfmbc5snce7")

func _enter_tree() -> void:
	owner_unit = get_parent() as UnitBase
	owners_attribute_container = owner_unit.get_node("%AttributeContainer")
	
	var inventory_equipment_ui: InventoryEquipmentUI = inventory_equipment_ui_scene.instantiate()
	inventory_equipment_ui.owner_inventory_equipment = self
	
	Global.GetCanvasLayer().add_child(inventory_equipment_ui)

func _ready() -> void:
	for i in range(10):
		AddNewItemToInventory(item1)
	
	for i in range(10):
		AddNewItemToInventory(item2)

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
		
		if new_item.item_info.item_scene != null:
			var new_item_base: ItemBase = new_item.item_info.item_scene.instantiate()
			new_item_base.owner_unit = owner_unit
			new_item_base.item = new_item
			
			owner_unit.get_node("Weapon").add_child(new_item_base)
		
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
