class_name CollectableEffect extends CollectableBase

@export var effect_scene: PackedScene

func OnAreaEntered(area: Area2D) -> void:
	var effect: EffectBase = effect_scene.instantiate()
	effect.InitializeEffect(area, area)
	effect.ApplyEffect()
