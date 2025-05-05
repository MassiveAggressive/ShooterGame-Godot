extends Resource

class_name ItemInfo

@export var name: String = "Name"
@export var description: String = "Description"
@export var item_icon: Texture2D
@export var item_primary_type:= Enums.EItemPrimaryType.WEAPON
@export var item_secondary_type:= Enums.EItemSecondaryType.PRIMARYWEAPON
@export var level: int = 1
@export var stackable: bool = false
@export var max_stack_count: int = 1
@export var attributes: Dictionary[String, float]
@export var item_scene: PackedScene
