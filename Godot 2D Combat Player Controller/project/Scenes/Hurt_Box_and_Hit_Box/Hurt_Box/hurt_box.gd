extends Area2D

signal health_depleted
signal health_updated(health)

@export var max_health:float = 100.0

var current_health:float

func _ready() -> void:
	current_health = max_health

func _damage(amount):
	current_health -= amount

func _process(_delta: float) -> void:
	_set_health()

func _set_health():
	current_health = clamp(current_health, 0, max_health)
	if current_health != max_health:
		emit_signal("health_updated", current_health)
		if current_health <= 0:
			emit_signal("health_depleted")
