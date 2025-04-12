@tool

extends Node

var DefaultCanvasLayer: CanvasLayer

func _enter_tree() -> void:
	DefaultCanvasLayer = CanvasLayer.new()
	get_tree().current_scene.add_child(DefaultCanvasLayer)

func GetCanvasLayer() -> CanvasLayer:
	return DefaultCanvasLayer
	
func AddUIToScreen(UI: Control) -> void:
	DefaultCanvasLayer.add_child(UI)
