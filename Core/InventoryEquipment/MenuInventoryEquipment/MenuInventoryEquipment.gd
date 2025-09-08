class_name MenuInventoryEquipment extends InventoryEquipmentBase

var inventory_equipment_ui_scene: PackedScene = preload("uid://cma6hfh4v44w3")
var inventory_equipment_ui: InventoryEquipmentUI

@export var item1: DataTableRow
	
func _ready() -> void:
	super._ready()
	inventory_equipment_ui = inventory_equipment_ui_scene.instantiate()
	inventory_equipment_ui.owner_inventory_equipment = self
	WindowsManager.AddWindow("Inventory Equipment", inventory_equipment_ui)
	
	SceneManager.SceneAboutToChange.connect(OnSceneAboutToChange)
	
	Load()

func AddItemToInventory(item_id: int) -> void:
	super.AddItemToInventory(item_id)
	Save()

func AddItemToEquipment(item_id: int) -> bool:
	if super.AddItemToEquipment(item_id):
		Save()
		return true
	return false
