class_name PlayerBase
extends UnitBase

var direction: Vector2 = Vector2.ZERO
var left_clicked: bool

@export var angular_speed: float = deg_to_rad(360)

func _ready() -> void:
	print(DataCarrier.data["items"])

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		left_clicked = true
		
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
	
	movement_component.AddMovementInput(direction, true)
	movement_component.RotateToPosition(get_global_mouse_position())
