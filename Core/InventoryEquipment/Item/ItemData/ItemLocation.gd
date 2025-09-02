class_name ItemLocation extends Resource

func _init(new_item_location: Util.EItemLocation, new_primary_type: Util.EItemPrimaryType) -> void:
	item_location = new_item_location
	primary_type = new_primary_type

var item_location: Util.EItemLocation
var primary_type: Util.EItemPrimaryType
