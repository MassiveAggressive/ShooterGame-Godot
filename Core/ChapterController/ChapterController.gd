class_name ChapterController
extends Node

@export var chapter: Chapter
var current_wave_count: int = -1
var current_wave: Wave
var current_unit_count: int = -1
var current_spawned_unit: PackedScene

var count: int = 0

func GetRandomPositionFromCircle() -> Vector2:
	var angle: float = randf() * TAU
	
	var offset: Vector2 = Vector2.RIGHT.rotated(angle) * 1000
	
	return offset
		
func GetRandomPositionInSight() -> Vector2:
	var viewport_size: Vector2 = get_viewport().size
	var top_left: Vector2 = GameManager.players[0].find_child("Camera").global_position - (viewport_size / 2)
	
	var rand_x: float = randf_range(0, viewport_size.x)
	var rand_y: float = randf_range(0, viewport_size.y)
	
	return Vector2(top_left.x + rand_x, top_left.y + rand_y)
	
func _ready() -> void:
	get_tree().create_timer(1).timeout.connect(StartChapter)

func StartChapter():
	StartWaves()
	
func StartWaves():
	IterateWaves()
	
func IterateWaves():
	current_wave_count += 1
	if current_wave_count < chapter.waves.size():
		current_wave = chapter.waves[current_wave_count]
		
		IterateUnitCount()

func IterateUnitCount():
	current_unit_count += 1
	if current_unit_count < current_wave.unit_count:
		current_spawned_unit = current_wave.spawned_unit
		
		SpawnUnit()
	else:
		current_unit_count = -1
		
		get_tree().create_timer(chapter.time_between_waves + \
		randf_range(chapter.time_offset * -1, chapter.time_offset)) \
		.timeout.connect(IterateWaves)

func SpawnUnit():
	var temp_unit: UnitBase = current_spawned_unit.instantiate()
	temp_unit.global_position = GetRandomPositionFromCircle()
	get_tree().current_scene.add_child(temp_unit)
	
	get_tree().create_timer(current_wave.time_between_spawn + \
		randf_range(current_wave.time_offset * -1, current_wave.time_offset)) \
		.timeout.connect(IterateUnitCount)
