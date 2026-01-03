extends CharacterBody2D

@export var body:Node2D
@export var state_manager:Node

var can_double_jump:bool = false
var can_attack:bool = true
var can_dash:bool  = true

var input_dir: Vector2

var is_hurt:bool = false
var is_dead:bool = false

func _ready():
	Global.player = self

func _physics_process(delta):
	state_manager._transition()
	
	if is_dead:
		return
	
	_flip_face()
	move_and_slide()

func _flip_face():
	if _set_direction().x != 0:
		body.scale.x = _set_direction().x

func _set_direction():
	# checking input of player
	input_dir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 0).normalized()
	return input_dir


func _on_hurt_box_health_updated(health: Variant) -> void:
	print(health)
