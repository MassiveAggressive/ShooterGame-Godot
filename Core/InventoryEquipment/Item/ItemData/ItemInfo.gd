class_name ItemInfo
extends Resource

@export var name: String = "Name"
@export var description: String = "Description"
@export var icon: Texture2D
@export var primary_type:= Util.EItemPrimaryType.WEAPON
@export var secondary_type:= Util.EItemSecondaryType.PRIMARYWEAPON
@export var stackable: bool = false
@export var max_stack_count: int = 1
@export var attributes: Dictionary[String, float]
@export var item_scene: PackedScene
@export var item_socket_name: String
