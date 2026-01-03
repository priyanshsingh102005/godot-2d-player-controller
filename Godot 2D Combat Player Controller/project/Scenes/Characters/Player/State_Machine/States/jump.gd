extends Node

func _on_jump_state_entered():
	get_parent().anim.play("Jump")
