class_name CollectableItem
extends CollectableBase

@export var item_info: ItemInfo
@onready var key_ui: Label = $CollectableKeyUI

var interacting_node: Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interacting") and interacting_node:
		var interacting_inventory_equipment: MenuInventoryEquipment = interacting_node.find_child("InventoryEquipment")
		if interacting_inventory_equipment:
			interacting_inventory_equipment.AddNewItemToInventory(item_info)

func OnAreaEntered(area: Area2D) -> void:
	key_ui.visible = true
	interacting_node = area

func OnAreaExited(area: Area2D) -> void:
	key_ui.visible = false
