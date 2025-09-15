class_name AbilitySystemBase extends Node

var owner_node: Node

@export var attribute_sets: Dictionary[String, AttributeSetBase]

var active_effects: Array[EffectBase]

func _ready() -> void:
	owner_node = get_parent()

func ApplyEffectSceneToSelf(effect_scene: PackedScene) -> void:
	var new_effect: EffectBase = effect_scene.instantiate()
	
	new_effect.effect_owner = owner_node
	new_effect.effect_target = owner_node
	
	new_effect.ApplyEffect()

func ApplyEffectToSelf(effect: EffectBase) -> void:
	effect.effect_owner = owner_node
	effect.effect_target = owner_node
	
	effect.ApplyEffect()

func ApplyEffectToTarget() -> void:
	pass
