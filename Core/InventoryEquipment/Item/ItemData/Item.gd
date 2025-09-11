class_name Item extends Resource

var item_id: int
@export var item_info: ItemInfo
var item_location: Util.EItemLocation
@export var level: int = 1
@export var stack_count: int = 1
var item_node: ItemBase

func ToDict() -> Dictionary:
	var data: Dictionary[String, Variant]
	
	data = {
		"item": item_info.resource_path,
		"item_location": Util.EItemLocation.keys()[item_location],
		"level": level,
		"stack_count": stack_count
	}
	
	return data
