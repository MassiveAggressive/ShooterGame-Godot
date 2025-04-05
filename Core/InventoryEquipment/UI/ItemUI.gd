@tool
extends Control

class_name ItemUI

var item_info_ui_scene: PackedScene = preload("uid://d1rhc3yte2wcd")

var item: Item
var Available: bool = true

func SetItem(new_item: Item = null) -> void:
	if Available:
		item = new_item
		var TempitemInfoUI: Control = item_info_ui_scene.instantiate()
		TempitemInfoUI.get_node("NameLabel").set_text(item.item.Name)
		TempitemInfoUI.get_node("LevelLabel").set_text(str(item.item.Level))
		add_child(TempitemInfoUI)
		Available = false
	else:
		item = null
		get_child(0).queue_free()
		Available = true
