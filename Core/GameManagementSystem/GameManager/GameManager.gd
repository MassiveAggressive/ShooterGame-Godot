extends Node

signal PlayerStateReady(PlayerStateBase)
signal PlayerReady(Node)

var player_state_node: PlayerStateBase
var player_node: Node

func SetPlayerState(new_player_state_node: PlayerStateBase) -> void:
	player_state_node = new_player_state_node
	PlayerStateReady.emit(player_state_node)

func GetPlayerState() -> PlayerStateBase:
	return player_state_node

func SetPlayer(new_player_node: Node) -> void:
	player_node = new_player_node
	PlayerReady.emit(player_node)
	
func GetPlayer() -> Node:
	return player_node
