extends Node2D 
@export var speed: float = 300.0
@export var x_to_destroy_at: float = -100

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	if position.x <= x_to_destroy_at:
		queue_free()
