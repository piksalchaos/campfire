extends CharacterBody2D

const MAX_SPEED: float = 200.0
const SURFACE_ACCELERATION: float = 800.0
const AIR_ACCELERATION: float = 1200.0
const GRAVITY: float = 300.0


@onready var temp_sprite_2d: Sprite2D = $TempSprite2D
@onready var surface_detector: Area2D = $SurfaceDetector
@onready var ground_detector: Area2D = $GroundDetector


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if surface_detector.has_overlapping_areas():
		velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, SURFACE_ACCELERATION * delta)
		velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED, SURFACE_ACCELERATION * delta)
	elif ground_detector.has_overlapping_areas():
		velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED / 3, SURFACE_ACCELERATION * delta)
		velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED / 3, SURFACE_ACCELERATION * delta)
		velocity.y += GRAVITY * delta
	else:
		velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, SURFACE_ACCELERATION * delta)
		velocity.y += (AIR_ACCELERATION if direction.y > 0 else GRAVITY) * delta
	
	if velocity.x != 0:
		temp_sprite_2d.flip_h = velocity.x < 0
	#
	#var target_rotation: float = direction.angle()
	#print(target_rotation)
	#rotation = move_toward(rotation, target_rotation, 3.0 * delta)
	
	move_and_slide()


func _on_surface_detector_area_entered(_area: Area2D) -> void:
	velocity.y = 200.0 


func _on_surface_detector_area_exited(_area: Area2D) -> void:
	velocity.y -= 120.0


func _on_ground_detector_area_entered(_area: Area2D) -> void:
	velocity.y = 100.0 
	
func _on_ground_detector_area_exited(_area: Area2D) -> void:
	velocity.y -= 120.0
