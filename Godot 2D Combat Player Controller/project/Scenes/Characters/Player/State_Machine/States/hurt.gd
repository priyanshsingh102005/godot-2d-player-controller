extends Node

@export var hurt_box:Area2D

func _on_hurt_box_area_entered(area: Area2D) -> void:
	get_parent().parent.is_hurt = true
	get_parent().parent.can_attack = true
	get_parent().parent.can_dash = true
	hurt_box._damage(area.damage)

func _on_hurt_state_entered() -> void:
	get_parent().parent.velocity = Vector2.ZERO
	get_parent().anim.play("Hurt")
	await get_parent().anim.animation_finished
	get_parent().parent.is_hurt = false
