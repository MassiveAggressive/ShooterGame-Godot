class_name ProjectileBase
extends Node2D

@export var bullet_speed: float = 1500
@export var collision_mask: int = 1  # NPC'lerin ait olduğu collision layer mask'ını buraya girin

func _process(delta: float) -> void:
	position += Vector2(1, 0).rotated(global_rotation) * bullet_speed * delta

	# Physics2DDirectSpaceState üzerinden nokta sorgusu için query parametrelerini oluştur.
	var query = PhysicsPointQueryParameters2D.new()
	query.position = position
	query.collision_mask = collision_mask
	query.exclude = [self]
	query.collide_with_areas = true
	query.collide_with_bodies = false  # İhtiyaca göre true yapabilirsiniz.

	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(query, 1) 
	
	if result.size() > 0:
		var collider = result[0].collider
		var Attributes: AttributeContainer = collider.get_node("AttributeContainer")
		
		Attributes.SetAttribute("Health", Attributes.GetAttribute("Health") - 10)
		
		queue_free()
