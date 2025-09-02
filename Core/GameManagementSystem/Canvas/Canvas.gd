extends Node

var canvas: CanvasLayer

func _enter_tree() -> void:
	CreateCanvas()
	
	SceneManager.SceneChanged.connect(OnSceneChanged)
	
func CreateCanvas() -> void:
	canvas = CanvasLayer.new()
	canvas.name = "DefaultCanvasLayer"
	
	print(get_tree().current_scene)
	
	get_tree().current_scene.add_child(canvas)

func OnSceneChanged() -> void:
	CreateCanvas()
