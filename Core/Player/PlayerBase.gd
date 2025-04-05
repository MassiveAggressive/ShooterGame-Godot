class_name PlayerBase
extends UnitBase

@export var speed: float = 500
var direction: Vector2 = Vector2.ZERO

@export var angular_speed: float = deg_to_rad(360)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		$WeaponBase.StartShooting()
	elif event.is_action_released("LeftClick"):
		$WeaponBase.StopShooting()

func _process(delta: float) -> void:	
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("MoveRight"):
		direction.x += 1
	if Input.is_action_pressed("MoveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("MoveDown"):
		direction.y += 1
	if Input.is_action_pressed("MoveUp"):
		direction.y -= 1
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	var mouse_position: Vector2 = get_global_mouse_position()
	var target_angle: float = (mouse_position - global_position).angle()
	var angle_diff: float = wrapf(target_angle - rotation, -PI, PI)
	
	if abs(angle_diff) < angular_speed * delta:
		rotation = target_angle
	else:
		rotation += sign(angle_diff) * angular_speed * delta
		
	position += direction * speed * delta
