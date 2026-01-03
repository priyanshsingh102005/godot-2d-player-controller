extends Node

@export var speed:float = 100.0
@export var accel:float = 80.0

func _on_run_state_entered():
	get_parent().anim.play("Run")

func _on_run_state_physics_processing(delta):
	get_parent().parent.velocity.x = lerp(get_parent().parent.velocity.x,
	 speed * get_parent().parent._set_direction().x,
	 accel * delta)
