class_name InGameInventoryEquipment extends InventoryEquipmentBase

var inventory_equipment_effect: EffectBase

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
	
	await get_tree().create_timer(7.5).timeout
	super.MoveItem(1, Util.EItemLocation.ININVENTORY)

func AddItemToEquipment(item_id: int) -> bool:
	if IsEquipmentAvailableForItemType(items[item_id].item_info.primary_type):
		if GameManager.GetPlayer():
			CreateItemScene(item_id)
		super.AddItemToEquipment(item_id)
		CalculateAttributes()
		
		return true
	return false

func RemoveItemFromEquipment(item_id: int) -> void:
	super.RemoveItemFromEquipment(item_id)
	
	CalculateAttributes()

func MoveItem(item_id: int, new_item_location: Util.EItemLocation) -> bool:
	return false

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

func CalculateAttributes() -> void:
	super.CalculateAttributes()
	
	if inventory_equipment_effect == null:
		inventory_equipment_effect = EffectBase.new()
		inventory_equipment_effect.duration_policy = Util.EDurationPolicy.INFINITE
	
	inventory_equipment_effect.ClearModifiers()
	
	for attribute_name in attributes:
		var attribute_modifier_info: AttributeModifierInfo = AttributeModifierInfo.new(Util.EOperator.ADD, attributes[attribute_name])
		
		inventory_equipment_effect.AddModifier(attribute_name, attribute_modifier_info)
		
	var owner_ability_system: AbilitySystemBase = get_parent().find_children("", "AbilitySystemBase")[0]
	owner_ability_system.ApplyEffectToSelf(inventory_equipment_effect)
