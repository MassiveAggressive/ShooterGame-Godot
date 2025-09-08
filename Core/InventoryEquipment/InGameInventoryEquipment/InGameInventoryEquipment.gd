class_name InGameInventoryEquipment extends InventoryEquipmentBase

func _ready() -> void:
	super._ready()
	var item_array: Array[Item] = DataCarrier.data["items"]
	equipment_slot_sizes = DataCarrier.data["equipment_slot_sizes"]
	
	for item in item_array:
		var new_item_id: int = AddNewItem(item)
		
		match item.item_location:
			Util.EItemLocation.ININVENTORY:
				AddItemToInventory(new_item_id)
			Util.EItemLocation.INEQUIPMENT:
				AddItemToEquipment(new_item_id)

func AddItemToEquipment(item_id: int) -> bool:
	if super.AddItemToEquipment(item_id):
		return true
	return false

func MoveItem(item_id: int, new_item_location: Util.EItemLocation) -> bool:
	return false

func RemoveItem(item_id) -> void:
	pass
