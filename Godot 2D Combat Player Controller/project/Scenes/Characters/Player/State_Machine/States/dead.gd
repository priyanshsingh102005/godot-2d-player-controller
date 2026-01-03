extends Node


func _on_dead_state_entered() -> void:
	get_parent().parent.velocity = Vector2.ZERO
	get_parent().anim.play("Dead")

func _on_hurt_box_health_depleted() -> void:
	get_parent().parent.is_dead = true
