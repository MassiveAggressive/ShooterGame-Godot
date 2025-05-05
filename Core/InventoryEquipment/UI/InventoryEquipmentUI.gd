@tool
extends Control

class_name InventoryEquipmentUI

var owner_inventory_equipment: InventoryEquipment

var inventory_ui_scene: PackedScene = preload("uid://cd26j4i83nx48")
var inventory_ui: InventoryUI

var equipment_ui_scene: PackedScene = preload("uid://dyy3p11jb8bj6")
var equipment_ui: EquipmentUI

func _enter_tree() -> void:
	equipment_ui = equipment_ui_scene.instantiate()
	equipment_ui.owner_inventory_equipment = owner_inventory_equipment
	
	inventory_ui = inventory_ui_scene.instantiate()
	inventory_ui.owner_inventory_equipment = owner_inventory_equipment
	
	$HBoxContainer.add_child(equipment_ui)
	$HBoxContainer.add_child(inventory_ui)
