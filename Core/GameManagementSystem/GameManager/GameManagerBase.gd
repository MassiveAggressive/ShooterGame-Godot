class_name GameManagerBase
extends Node

@export var default_player_state_scene: PackedScene
@export var default_player_scene: PackedScene

var player_state_node: PlayerStateBase
var player_node: Node

func _ready() -> void:
	var player_state_node: PlayerStateBase = default_player_state_scene.instantiate()
	get_tree().current_scene.add_child(player_state_node)
	
	var player_node_temp: Node2D = default_player_scene.instantiate()
	player_node = player_node_temp
	player_state_node.add_child(player_node_temp)
	player_node_temp.global_position = SpawnPoints.spawn_points[0].global_position
	
	player_state_node.SetPlayerNode(player_node)
