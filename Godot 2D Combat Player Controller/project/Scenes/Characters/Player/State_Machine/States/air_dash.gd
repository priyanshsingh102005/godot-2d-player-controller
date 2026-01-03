extends Node

@export var dash_time:float = 0.2
@export var accel:float = 60.0
@export var de_accel:float = 300.0
@export var dash_force:float = 550.0

var dash_timer:float

func _ready() -> void:
	dash_timer = dash_time

func _on_air_dash_state_entered() -> void:
	get_parent().parent.velocity = Vector2.ZERO
	get_parent().anim.play("Air_Dash",-1,1.3)
	await get_tree().create_timer(0.1).timeout
	get_parent().parent.velocity.x = dash_force * get_parent().parent.body.scale.x

func _on_air_dash_state_physics_processing(delta: float) -> void:
	dash_timer -= delta
	dash_timer = clamp(dash_timer, 0, dash_time)
	
	if dash_timer <= 0.0:
		get_parent().parent.velocity.x = 0.0
		get_parent().anim.play("Air_Dash_End", -1, 2)
		await get_parent().anim.animation_finished
		get_parent().parent.can_dash = true


func _on_air_dash_state_exited() -> void:
	dash_timer = dash_time
