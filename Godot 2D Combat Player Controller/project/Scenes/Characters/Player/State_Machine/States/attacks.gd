extends Node

@export var attack_cooldown_timer:Timer
@export var anim_speed:float = 1.0

var next_attack:bool = false

func _combo_attack_window():
	next_attack = true

func _attack_name(NAME:String):
	if attack_cooldown_timer.is_stopped():
		get_parent().anim.play(NAME,-1,anim_speed)
		attack_cooldown_timer.start()

func _next_attack():
	if Input.is_action_just_pressed("Attack") and next_attack == true:
		get_parent().state_chart.send_event("next")

func _end_of_attack():
	next_attack = false
	attack_cooldown_timer.stop()

func _on_combo_1_state_entered():
	_attack_name("Attack_1")

func _on_combo_2_state_entered():
	_attack_name("Attack_2")

func _on_combo_3_state_entered():
	_attack_name("Attack_3")

func _on_combo_state_physics_processing(delta):
	_next_attack()
	get_parent().parent.velocity = Vector2.ZERO

func _on_combo_state_exited():
	_end_of_attack()

func _on_attack_cool_down_timer_timeout():
	get_parent().parent.can_attack = true
	get_parent().parent.can_dash = true
