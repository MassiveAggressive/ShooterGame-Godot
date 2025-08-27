extends Node

signal scene_changed(new_scene: Node)

func _enter_tree() -> void:
	get_tree().node_added.connect(OnNodeAdded)

func ChangeScene(packed_scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(packed_scene)

func OnNodeAdded(node: Node) -> void:
	if node == get_tree().current_scene:
		scene_changed.emit(node)
