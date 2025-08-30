@tool
class_name ExpandableArea extends Control

@export var shrink_duration: float = 1

@export var expand_to_content: bool = true

var parent_default_size: Vector2

@export var default_size: Vector2
@export var expanded_size_without_content: Vector2

var is_expanded: bool = false

@export_tool_button("Expand")
var expand = Expand

@export_tool_button("Shrink")
var shrink = Shrink

func _ready() -> void:
	if get_parent():
		parent_default_size = get_parent().size
	default_size = custom_minimum_size

func Expand() -> void:
	is_expanded = true
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
	var expanded_size: Vector2
	if expand_to_content and get_child_count() > 0:
		expanded_size = get_child(0).size
	else:
		expanded_size = expanded_size_without_content
		
	tween.tween_property(self, "custom_minimum_size", expanded_size, shrink_duration)
	tween.finished.connect(OnExpandFinished)

func Shrink() -> void:
	is_expanded = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "custom_minimum_size", default_size, shrink_duration)

func OnExpandFinished() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
