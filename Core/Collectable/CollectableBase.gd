@tool
class_name CollectableBase
extends Area2D

@export var collectable_icon: Texture2D:
	set(value):
		if value:
			collectable_icon = value

func _ready() -> void:
	$Sprite2D.texture = collectable_icon

func OnAreaEntered(area: Area2D) -> void:
	pass # Replace with function body.

func OnAreaExited(area: Area2D) -> void:
	pass # Replace with function body.
