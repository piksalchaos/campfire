extends Area2D

const MAX_SPEED: float = 200.0
const SURFACE_ACCELERATION: float = 800.0
const AIR_ACCELERATION: float = 1200.0
const GRAVITY: float = 300.0

@export var boundaries: Rect2 = Rect2(0.0, 0.0, 576.0, 324.0)
var velocity: Vector2

@onready var temp_sprite_2d: Sprite2D = $TempSprite2D


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, SURFACE_ACCELERATION * delta)
	if has_overlapping_areas():
		velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED, SURFACE_ACCELERATION * delta)
	else:
		velocity.y += (AIR_ACCELERATION if direction.y > 0 else GRAVITY) * delta
	
	
	var target_rotation: float = velocity.y * 0.0025
	rotation = move_toward(rotation, target_rotation, 5.0 * delta)
	
	position += velocity * delta
	position.x = clampf(position.x, boundaries.position.x, boundaries.end.x)
	position.y = clampf(position.y, boundaries.position.y, boundaries.end.y)


func _on_area_exited(_area: Area2D) -> void:
	velocity.y -= 120.0


func _on_area_entered(_area: Area2D) -> void:
	velocity.y = 200.0 
