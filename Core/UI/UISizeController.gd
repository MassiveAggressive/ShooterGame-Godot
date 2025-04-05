@tool
extends Control

func _enter_tree() -> void:
	self.connect("resized", _on_resized)

func _on_resized():
	size.y = clamp(size.y, 0, 270)
