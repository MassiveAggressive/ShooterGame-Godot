class_name GameManagerBase extends Node

@export var default_player_state_scene: PackedScene
@export var default_player_scene: PackedScene

var player_state_node: PlayerStateBase
var player_node: Node

func _enter_tree() -> void:
	player_state_node = default_player_state_scene.instantiate()
	GameManager.SetPlayerState(player_state_node) 
	get_tree().current_scene.add_child(player_state_node)
	
	player_node = default_player_scene.instantiate()
	GameManager.SetPlayer(player_node) 
	get_tree().current_scene.add_child(player_node)
	if !SpawnPoints.spawn_points.is_empty():
		player_node.global_position = SpawnPoints.spawn_points[0].global_position
	
	player_state_node.SetPlayerNode(player_node)

func GetPlayerState() -> PlayerStateBase:
	return player_state_node
