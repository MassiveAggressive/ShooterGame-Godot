class_name InventoryEquipment
extends Node

var inventory: Dictionary[int, Item]

@export var equipment_slot_sizes: Dictionary[Enums.EItemPrimaryType, int]
@export var equipment: Dictionary[Enums.EItemPrimaryType, Dictionary]

var item_locations: Dictionary[int, ItemLocation]

signal ItemAddedToInventory(Item: Item)
signal ItemAddedToEquipment(Item: Item)

var inventory_equipment_ui_scene: PackedScene = preload("uid://byffou1ig3ymq")
var item: ItemInfo = preload("uid://cpgfmbc5snce7")

func _enter_tree() -> void:
	var inventory_equipment_ui: InventoryEquipmentUI = inventory_equipment_ui_scene.instantiate()
	inventory_equipment_ui.OwnerIE = self
	
	#Global.GetCanvasLayer().add_child(inventoryEquipmentUIRef)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		SendItemToEquipment(1)
	if event.is_action_pressed("RightClick"):
		SendItemToInventory(1)
		
func _ready() -> void:
	AddNewItemToInventory(item)

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

func AddItemToEquipment(new_item: Item) -> bool:
	var item_type = new_item.item_info.item_primary_type
	if equipment[item_type].keys().size() < equipment_slot_sizes[item_type]:
		var items: Dictionary = equipment[item_type]
		items[new_item.item_id] = new_item
		item_locations[new_item.item_id] = ItemLocation.new(Enums.EItemLocation.INEQUIPMENT, new_item.item_info.item_primary_type)

		ItemAddedToEquipment.emit(new_item)
		
		return true
		
	return false

func SendItemToInventory(item_id: int) -> void:
	var item_location: ItemLocation = item_locations[item_id]
	
	if item_location.item_location == Enums.EItemLocation.INEQUIPMENT:
		if AddItemToInventory(equipment[item_location.item_primary_type][item_id]):
			equipment[item_location.item_primary_type].erase(item_id)
