extends Node

@export var state_chart:StateChart
@export var anim: AnimationPlayer
@export var parent:CharacterBody2D

func _transition():
	
	if parent.is_dead:
		state_chart.send_event("dead")
		return
	
	if parent.is_hurt:
		state_chart.send_event("hurt")
		return
	
	if parent.is_on_floor():
		state_chart.send_event("ground")
	else:
		state_chart.send_event("air")

func _on_ground_state_state_physics_processing(delta):
	if !parent.can_attack:
		state_chart.send_event("attack")
		return
	
	if Input.is_action_just_pressed("Attack"):
		parent.can_attack = false
	
	if !parent.can_dash:
		state_chart.send_event("dash")
		return
	
	if Input.is_action_just_pressed("dash"):
		parent.can_dash = false
	
	if parent._set_direction().x != 0:
		state_chart.send_event("run")
	else:
		state_chart.send_event("idle")

func _on_air_state_state_physics_processing(delta):
	if !parent.can_attack:
		state_chart.send_event("attack")
		return
	
	if Input.is_action_just_pressed("Attack"):
		parent.can_attack = false
	
	if !parent.can_dash:
		state_chart.send_event("dash")
		return
	
	if Input.is_action_just_pressed("dash"):
		parent.can_dash = false
	
	if parent.velocity.y >= 0.0:
		state_chart.send_event("fall")
	else:
		if parent.can_double_jump == false:
			state_chart.send_event("double_jump")
		else:
			state_chart.send_event("jump")
