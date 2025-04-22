extends Node

var windows_manager_ui_scene: PackedScene = preload("uid://04datns7xrqt")
var windows_manager_ui: WindowsManagerUI

var windows: Dictionary[String, CustomWindow]
var windows_parent: Node

var custom_window_scene: PackedScene = preload("uid://d11dh6cc2j7b2")

func _ready() -> void:
	windows_manager_ui = windows_manager_ui_scene.instantiate()
	Global.AddUIToScreen(windows_manager_ui)
	
	windows_parent = Node.new()
	get_tree().current_scene.add_child(windows_parent)

func AddWindow(window_name: String, node: Node) -> void:
	var new_window_icon_ui: WindowIconUI = windows_manager_ui.AddWindowIcon(window_name)
	new_window_icon_ui.IconClicked.connect(OnWindowIconClicked)
	
	var new_custom_window: CustomWindow = custom_window_scene.instantiate()
	new_custom_window.InitializeWindow(window_name, node)
	new_custom_window.visible = false
	windows_parent.add_child(new_custom_window)
	
	windows[window_name] = new_custom_window

func OnWindowIconClicked(window_name: String) -> void:
	windows[window_name].visible = !windows[window_name].visible
