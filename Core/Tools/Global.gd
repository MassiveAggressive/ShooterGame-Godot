@tool
extends Node

var default_canvas_layer: CanvasLayer

func _enter_tree() -> void:
	default_canvas_layer = CanvasLayer.new()
	get_tree().current_scene.add_child(default_canvas_layer)

func GetCanvasLayer() -> CanvasLayer:
	return default_canvas_layer
	
func AddUIToScreen(ui: Control) -> void:
	default_canvas_layer.add_child(ui)
