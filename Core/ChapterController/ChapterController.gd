class_name ChapterController
extends Node

@export var chapter: Chapter

func StartSpawn():
	for wave in chapter.waves:
		for i in range(wave.unit_count):
			get_tree().create_timer(wave.time_between_spawn + randf_range(wave.time_offset * -1, wave.time_offset)).timeout.connect(SpawnUnit)

func SpawnUnit():
	pass
