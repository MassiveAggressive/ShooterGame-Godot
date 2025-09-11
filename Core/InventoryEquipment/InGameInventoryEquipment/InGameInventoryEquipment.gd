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
	
	GameManager.PlayerReady.connect(CreateItemScenes)

func AddItemToEquipment(item_id: int) -> bool:
	if IsEquipmentAvailableForItemType(items[item_id].item_info.primary_type):
		if GameManager.GetPlayer():
			CreateItemScene(item_id)
		super.AddItemToEquipment(item_id)
	return false

func MoveItem(item_id: int, new_item_location: Util.EItemLocation) -> bool:
	return false

func RemoveItem(item_id) -> void:
	pass

func CreateItemScene(item_id: int) -> void:
	var item_info: ItemInfo = items[item_id].item_info
	
	if item_info.item_scene:
		var item_node: ItemBase = item_info.item_scene.instantiate()
		item_node.owner_node = GameManager.GetPlayerState()
		items[item_id].item_node = item_node
		
		GameManager.player_node.find_child("Weapon").add_child(item_node)

func CreateItemScenes(player_node: Node) -> void:
	for item_type in equipment:
		for item_id in equipment[item_type]:
			CreateItemScene(item_id)
