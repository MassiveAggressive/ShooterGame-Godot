class_name MenuInventoryEquipment extends InventoryEquipmentBase

@export var item1: DataTableRow
	
func _ready() -> void:
	super._ready()
	
	SceneManager.SceneAboutToChange.connect(OnSceneAboutToChange)

func AddItemToInventory(item_id: int) -> bool:
	super.AddItemToInventory(item_id)
	
	Save()
	
	return true

func AddItemToEquipment(item_id: int) -> bool:
	if super.AddItemToEquipment(item_id):
		CalculateAttributes()
		Save()
		return true
	return false

func RemoveItemFromEquipment(item_id) -> void:
	super.RemoveItemFromEquipment(item_id)
	CalculateAttributes()
