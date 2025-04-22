class_name CustomWindow
extends Window

@export var window_name: String
@export var content: Node

func InitializeWindow(_window_name: String, _content: Node):
	window_name = _window_name
	content = _content
	title = window_name
	size = content.size
	add_child(content)


func OnCloseRequested() -> void:
	visible = false
