class_name WeaponBase extends ItemBase

@export var bullet_scene: PackedScene

@export var fire_rate: float = 0:
	set(value):
		fire_rate = value
		fire_duration = 1 / value
		
var barrels: Array[Node2D]

@export var barrel_count: int = 1:
	set(value):
		barrel_count = value
		CreateBarrels()

@export var barrel_angle: float = 0.0:
	set(value):
		barrel_angle = value
		CreateBarrels()

@export var barrel_space: float = 10:
	set(value):
		barrel_space = value
		CreateBarrels()

var fire_duration: float
var time_pool: float
var count_this_frame: bool = false
var is_shooting: bool = false
@export var is_shoot_available: bool = true

@onready var current_scene: Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		StartShooting()
	elif event.is_action_released("LeftClick"):
		StopShooting()

func _ready():
	super._ready()
	
	current_scene = get_tree().current_scene
	
	set_process(false)
	fire_duration = 1 / fire_rate
	
	CreateBarrels()

func CreateBarrels() -> void:
	if !barrels.is_empty():
		for barrel in barrels:
			barrel.queue_free()
		barrels.clear()	
		
	for i in range(barrel_count):
		var new_barrel: Node2D = Node2D.new()
		new_barrel.position.y = i * barrel_space - ((barrel_count - 1) * barrel_space / 2)
		new_barrel.rotation_degrees = i * barrel_angle - ((barrel_count - 1) * barrel_angle / 2)
		
		barrels.append(new_barrel)
		add_child(new_barrel)

func OnAttributeChanged(attribute_name: String, value: float):
	if attribute_name == "FireRate":
		fire_rate = value
	elif attribute_name == "BarrelCount":
		barrel_count = value

func StartShooting():
	if fire_rate > 0.0:
		is_shooting = true
		if is_shoot_available:
			Shoot(0.0)
		set_process(true)
	
func StopShooting():
	is_shooting = false

func _process(delta):
	if count_this_frame:
		time_pool += delta
		if time_pool >= fire_duration:
			if is_shooting:
				HandleTimePool()
			else:
				is_shoot_available = true
				count_this_frame = false
				time_pool = 0
				set_process(false)
	else:
		count_this_frame = true

func HandleTimePool():
	while time_pool >= fire_duration:
		time_pool -= fire_duration
		Shoot(time_pool)

func Shoot(Delta : float):
	is_shoot_available = false
	for barrel in barrels:
		var new_bullet: ProjectileBase = bullet_scene.instantiate()
		new_bullet.instigator_node = owner_node
		current_scene.add_child(new_bullet)
		new_bullet.global_position = barrel.global_position + Vector2.RIGHT.rotated(barrel.global_rotation) * Delta * 1500
		new_bullet.global_rotation = barrel.global_rotation
