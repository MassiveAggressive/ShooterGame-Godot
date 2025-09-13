class_name AbilitySystemBase extends Node

var owner_node: Node

var active_effects: Array[EffectBase]

func _ready() -> void:
	owner_node = get_parent()

func ApplyEffectSceneToSelf(effect_scene: PackedScene) -> void:
	var new_effect: EffectBase = effect_scene.instantiate()
	
	ApplyEffectToSelf(new_effect)

func ApplyEffectToSelf(effect: EffectBase) -> void:
	effect.effect_owner = owner_node
	effect.effect_target = owner_node
	
	match effect.duration_policy:
		Util.EDurationPolicy.DURATION:
			active_effects.append(effect)
		Util.EDurationPolicy.INFINITE:
			active_effects.append(effect)
	
	effect.ApplyEffect()

func ApplyEffectToTarget() -> void:
	pass

func RemoveActiveEffect(effect: EffectBase) -> void:
	pass
