class_name CustomWindowUI
extends Control

func OnChildEnteredTree(node: Node) -> void:
	remove_child(node)
	%ContentContainer.add_child(node)
	
func OnCloseRequested() -> void:
	visible = false
