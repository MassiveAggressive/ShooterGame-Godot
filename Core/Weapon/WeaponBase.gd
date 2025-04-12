extends Node2D

class_name WeaponBase

@export var BulletScene : PackedScene

@export var FireRate : float = 1:
	set(value):
		FireRate = value
		FireDuration = 1 / value
@export var BarrelCount : int = 1

var FireDuration : float
var TimePool : float
var CountThisFrame : bool = false
var IsShooting : bool = false
@export var IsShootAvailable : bool = true

@onready var CurrentScene : Node

var OwnerAttribute: AttributeContainer

func _ready():
	OwnerAttribute = get_parent().get_node("AttributeContainer")
	if OwnerAttribute:
		OwnerAttribute.AttributeChanged.connect(OnAttributeChange)
		
	CurrentScene = get_tree().current_scene
	
	set_process(false)
	FireDuration = 1 / FireRate

func OnAttributeChange(Name: String, Value: float):
	if Name == "FireRate":
		FireRate = Value
	elif Name == "BarrelCount":
		BarrelCount = Value
	
func StartShooting():
	IsShooting = true
	if IsShootAvailable:
		Shoot(0.0)
	set_process(true)
	
func StopShooting():
	IsShooting = false
	
func _process(delta):
	if CountThisFrame:
		TimePool += delta
		if TimePool >= FireDuration:
			if IsShooting:
				HandleTimePool()
			else:
				IsShootAvailable = true
				CountThisFrame = false
				TimePool = 0
				set_process(false)
	else:
		CountThisFrame = true

func HandleTimePool():
	while TimePool >= FireDuration:
		TimePool -= FireDuration
		Shoot(TimePool)

func Shoot(Delta : float):
	IsShootAvailable = false
	var Bullet = BulletScene.instantiate()
	CurrentScene.add_child(Bullet)
	
	queue_redraw()
	Bullet.global_position = global_position + Vector2.RIGHT.rotated(global_rotation) * Delta * 1500
	Bullet.global_rotation = global_rotation
	
