extends Node


func _on_double_jump_state_entered():
	get_parent().anim.play("Double_Jump")
