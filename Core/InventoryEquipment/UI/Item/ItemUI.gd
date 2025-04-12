@tool
extends Control

class_name ItemUI

var item_info_ui_scene: PackedScene = preload("uid://d1rhc3yte2wcd")

var item: Item
var available: bool = true

signal ItemClicked(Item)

func SetItem(new_item: Item = null) -> void:
	if available:
		item = new_item
		var TempitemInfoUI: Control = item_info_ui_scene.instantiate()
		TempitemInfoUI.get_node("NameLabel").set_text(item.item_info.name)
		TempitemInfoUI.get_node("LevelLabel").set_text(str(item.item_info.level))
		add_child(TempitemInfoUI)
		available = false
	else:
		item = null
		get_child(0).queue_free()
		available = true

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and not available:
		ItemClicked.emit(self)
