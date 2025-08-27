class_name GameInstanceBase
extends Node

@export var default_map_scene: PackedScene

var map_node: MapBase

func _ready() -> void:
	SceneManager.ChangeScene(default_map_scene)
