class_name InventoryEquipmentBase extends Node

signal ItemAddedToInventory(Item)
signal ItemRemovedFromInventory(int)
signal ItemAddedToEquipment(Item)
signal ItemRemovedFromEquipment(int)

var items: Dictionary[int, Item]

@export var inventory: Array[int]

@export var equipment: Dictionary[Util.EItemPrimaryType, Array]

@export var equipment_slot_sizes: Dictionary[Util.EItemPrimaryType, int]:
	set(value):
		equipment_slot_sizes = value
		for key in equipment_slot_sizes.keys():
			equipment.set(key, {})

@export var attributes: Dictionary[String, float]

func _ready() -> void:
	for key in Util.EItemPrimaryType.values():
		equipment[key] = []

func FindItem(item_id: int) -> Util.EItemLocation:
	return items[item_id].item_location

func CreateNewItemID() -> int:
	if items.is_empty():
		return 0
	else:
		return (items.keys().max() + 1)

func CreateNewItem(new_item_info: ItemInfo) -> int:
	var new_item = Item.new()
	var new_item_id = CreateNewItemID()
	
	new_item.item_id = new_item_id
	new_item.item_info = new_item_info
	items[new_item_id] = new_item
	
	Save()
	
	return new_item_id

func AddNewItem(new_item: Item) -> int:
	var new_item_id = CreateNewItemID()
	
	new_item.item_id = new_item_id
	items[new_item_id] = new_item
	
	return new_item_id

func IsInventoryAvailable() -> bool:
	return true

func AddItemToInventory(item_id: int) -> void:
	inventory.append(item_id)
	items[item_id].item_location = Util.EItemLocation.ININVENTORY
	
	ItemAddedToInventory.emit(items[item_id])

func IsEquipmentAvailableForItemType(item_type: Util.EItemPrimaryType) -> bool:
	return equipment[item_type].size() < equipment_slot_sizes[item_type]

func AddItemToEquipment(item_id: int) -> bool:
	var item_type = items[item_id].item_info.primary_type
	
	if IsEquipmentAvailableForItemType(item_type):
		var equipment_items: Array = equipment[item_type]
		equipment_items.append(item_id)
		equipment[item_type] = equipment_items
		items[item_id].item_location = Util.EItemLocation.INEQUIPMENT
		
		ItemAddedToEquipment.emit(items[item_id])

		return true
		
	return false

func MoveItem(item_id: int, new_item_location: Util.EItemLocation) -> bool:
	var item: Item = items[item_id]
	var item_location: Util.EItemLocation = item.item_location
	
	if  item_location == new_item_location:
		return false
	
	match new_item_location:
		Util.EItemLocation.INEQUIPMENT:
			if IsEquipmentAvailableForItemType(item.item_info.primary_type):
				RemoveItem(item_id)
				AddItemToEquipment(item_id)
		Util.EItemLocation.ININVENTORY:
			if IsInventoryAvailable():
				RemoveItem(item_id)
				AddItemToInventory(item_id)
	return true

func RemoveItem(item_id) -> void:
	var item_location: Util.EItemLocation = items[item_id].item_location
	
	match item_location:
		Util.EItemLocation.ININVENTORY:
			RemoveItemFromInventory(item_id)
		Util.EItemLocation.INEQUIPMENT:
			RemoveItemFromEquipment(item_id)

func RemoveItemFromEquipment(item_id) -> void:
	equipment[items[item_id].item_info.primary_type].erase(item_id)
	ItemRemovedFromEquipment.emit(item_id)

func RemoveItemFromInventory(item_id) -> void:
	inventory.erase(item_id)
	ItemRemovedFromInventory.emit(item_id)

func CalculateAttributes() -> void:
	var temp_attributes: Dictionary[String, float]
	
	for item_type in equipment:
		for item_id in equipment[item_type]:
			var item_info: ItemInfo = items[item_id].item_info
			
			for attribute_name in item_info.attributes:
				temp_attributes[attribute_name] = temp_attributes.get(attribute_name, 0) + item_info.attributes[attribute_name]
				
	attributes = temp_attributes
	
	print(attributes)
	
	var attribute_container: AttributeManagerBase = GameManager.GetPlayerState().find_children("", "AttributeManagerBase")[0]
	attribute_container.AddAttributesRaw("InventoryEquipment", attributes)

func Save() -> void:
	var data: Array[Dictionary]
	
	for item in items.values():
		item = item as Item
		data.append(item.ToDict())
	
	SaveManager.Save("InventoryEquipment", JSON.stringify(data, "\t"))

func Load() -> void:
	if SaveManager.loads.has("InventoryEquipment"):
		var data: Array = JSON.parse_string(SaveManager.loads["InventoryEquipment"])
		
		for item_data in data:
			var item_info: ItemInfo = load(item_data["item"])
			var new_item_id = CreateNewItem(item_info)
			
			items[new_item_id].level = item_data["level"]
			items[new_item_id].stack_count = item_data["stack_count"]
			
			MoveItem(new_item_id, Util.EItemLocation.keys().find(item_data["item_location"]))

func OnSceneAboutToChange() -> void:
	DataCarrier.data["items"] = items.values()
	DataCarrier.data["equipment_slot_sizes"] = equipment_slot_sizes
