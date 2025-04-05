extends Node

class_name NPCSpawner
@export var NPCScene: PackedScene = preload("uid://lsul7y4yw26")

func OnTimerTimeout() -> void:
	var TempNPC: UnitBase = NPCScene.instantiate()
	get_tree().current_scene.add_child(TempNPC)
