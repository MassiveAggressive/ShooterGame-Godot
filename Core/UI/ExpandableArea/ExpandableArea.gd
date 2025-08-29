class_name ExpandableArea extends Control

@export var clipping_unit_per_sec: float = 1000

func OnMouseEntered() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "size:x", get_child(0).size.x, (get_child(0).size.x - 100) / clipping_unit_per_sec)

func OnMouseExited() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "size:x", 100, (get_child(0).size.x - 100) / clipping_unit_per_sec)
