extends Node

@export var de_accel:float = 80.0

func _on_idle_state_entered():
	get_parent().anim.play("Idle")

func _on_idle_state_physics_processing(delta):
	get_parent().parent.velocity.x = lerp(get_parent().parent.velocity.x,0.0, de_accel * delta)
