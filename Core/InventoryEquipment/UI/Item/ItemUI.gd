@tool
class_name ItemUI
extends PanelContainer

var owner_inventory_equipment: InventoryEquipmentBase

var item_info_ui_scene: PackedScene = preload("uid://dp7u4bls52ny0")

var item: Item
var available: bool = true

signal ItemClicked(Item)

func SetItem(new_item: Item = null) -> void:
	if available:
		item = new_item
		var TempitemInfoUI: Control = item_info_ui_scene.instantiate()
		TempitemInfoUI.get_node("%NameLabel").set_text(item.item_info.name)
		TempitemInfoUI.get_node("%LevelLabel").set_text(str(item.item_info.level))
		add_child(TempitemInfoUI)
		available = false
	else:
		item = null
		get_child(0).queue_free()
		available = true

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and not available:
		ItemClicked.emit(self)

func _get_drag_data(at_position: Vector2) -> Variant:
	var preview: Control = load("uid://d1rhc3yte2wcd").instantiate()
	var control: Control = Control.new()
	control.add_child(preview)
	preview.position = Vector2(0, 0)
	set_drag_preview(control)
	return item

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return available

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data = data as Item
	match owner_inventory_equipment.FindItem(data.item_id):
		Util.EItemLocation.ININVENTORY:
			owner_inventory_equipment.SendItemToEquipment(data.item_id)
		Util.EItemLocation.INEQUIPMENT:
			owner_inventory_equipment.SendItemToInventory(data.item_id)
