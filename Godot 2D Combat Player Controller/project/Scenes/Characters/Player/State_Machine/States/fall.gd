extends Node


func _on_fall_state_entered():
	get_parent().anim.play("Fall")
