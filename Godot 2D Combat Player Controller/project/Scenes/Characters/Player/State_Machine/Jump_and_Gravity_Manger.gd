extends Node

@onready var parent = get_parent()

@export var air_speed:float = 50
@export var air_accel:float = 65

@export var fall_gravity: float = 350.0
@export var gravity: float = 290.0
@export var double_jump_velocity: float = -125.0
@export var jump_velocity: float = -135.0
@export var coyote_time :float = 0.1
@export var jump_buffer_time:float =  0.2
@export var var_jump_multiplier:float = 0.5

var jump_buffer:float = 0.0
var coyote_timer :float = 0.0

func _ready():
	parent.can_double_jump = false
	coyote_timer = 0.0
	jump_buffer = 0.0

func _on_ground_state_state_physics_processing(delta):
	
	parent.can_double_jump = true
	coyote_timer = coyote_time
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer = jump_buffer_time
	
	if jump_buffer > 0.0:
		jump_buffer = 0.0
		coyote_timer = 0.0
		parent.velocity.y = jump_velocity

func _on_air_state_state_physics_processing(delta):
	if !parent.can_dash:
		return
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer = jump_buffer_time
	
	_gravity_and_jump_mechanic(delta)

func _gravity_and_jump_mechanic(delta):
	var GRAVITY = gravity if parent.velocity.y < 0.0 else fall_gravity
	parent.velocity.y += GRAVITY * delta
	
	coyote_timer -= delta
	coyote_timer = clamp(coyote_timer, 0,coyote_time)
	
	jump_buffer -= delta
	jump_buffer = max(jump_buffer, 0)
	
	if jump_buffer > 0.0 and coyote_timer > 0.0:
		parent.velocity.y = jump_velocity
		coyote_timer = 0.0
		jump_buffer = 0.0
		return
	
	if parent.can_double_jump and jump_buffer > 0.0:
		parent.velocity.y = double_jump_velocity
		parent.can_double_jump = false
		jump_buffer = 0.0
	
	if Input.is_action_just_released("jump") and parent.velocity.y < 0.0:
		parent.velocity.y *= var_jump_multiplier
	
	_air_movement(air_speed,air_accel,delta)

func _air_movement(speed, accel,delta):
	if parent._set_direction().x != 0:
		parent.velocity.x = lerp(parent.velocity.x, speed *parent._set_direction().x, accel * delta)
	else:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, accel * delta)
