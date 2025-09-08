extends Node

const path: String = "user://Shooter"

@export var saves: Dictionary[String, String]
var loads: Dictionary[String, String]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		pass
		#SaveGame()

func _enter_tree() -> void:
	LoadGame()

func Save(save_name: String, data: String) -> void:
	var path: String = "user://Shooter/%s.json" % save_name
	var file = FileAccess.open(path, FileAccess.WRITE)
		
	file.store_string(data)

func SaveGame() -> void:
	get_tree().call_group("SaveGame", "Save")
	
	var dir = DirAccess.open("user://")
	if dir:
		dir.make_dir("Shooter")
	
	for key in saves.keys():
		Save(key, saves[key])

func LoadGame() -> void:
	var file_names: Array[String]
	
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		if file_name.get_extension() == "json":
			file_names.append(file_name)
	
	for name in file_names:
		var file = FileAccess.open("%s/%s" % [path, name], FileAccess.READ)
		loads[name.get_slice(".", 0)] = file.get_as_text()
