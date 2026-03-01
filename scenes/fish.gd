extends CharacterBody2D

const MAX_SPEED: float = 200.0
const WATER_FRICTION: float = 300.0
const GROUND_FRICTION: float = 1000.0
const AIR_FRICTION: float = 100.0
const GRAVITY: float = 300.0

const MAX_CHARGE_MS: int = 800

var is_charging: bool = false
var msec_charging_started: float

@onready var temp_sprite_2d: Sprite2D = $TempSprite2D
@onready var surface_detector: Area2D = $SurfaceDetector
@onready var ground_detector: Area2D = $GroundDetector
@onready var charge_bar: ProgressBar = $ChargeBar


func is_in_air() -> bool:
	return not (surface_detector.has_overlapping_areas() or ground_detector.has_overlapping_areas())


func boost(milliseconds_charging: float) -> void:
	var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	var speed: float = minf(milliseconds_charging, MAX_CHARGE_MS) * 0.5
	velocity = direction * speed


func _physics_process(delta: float) -> void:
	rotation = (get_global_mouse_position() - global_position).angle()
	print(rotation)
	temp_sprite_2d.flip_v = rotation > PI/2 or rotation < -PI/2
	
	if is_charging:
		charge_bar.value = float(Time.get_ticks_msec() - msec_charging_started) / MAX_CHARGE_MS
	
	if surface_detector.has_overlapping_areas():
		velocity = velocity.move_toward(Vector2.ZERO, WATER_FRICTION * delta)
	elif ground_detector.has_overlapping_areas():
		velocity = velocity.move_toward(Vector2.ZERO, GROUND_FRICTION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, AIR_FRICTION/3 * delta)
		velocity.y += GRAVITY * 2 * delta
	
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("charge") and not is_in_air():
		is_charging = true
		charge_bar.show()
		msec_charging_started = Time.get_ticks_msec()
	if event.is_action_released("charge") and is_charging:
		is_charging = false
		charge_bar.hide()
		boost(Time.get_ticks_msec() - msec_charging_started)


func _on_surface_detector_area_entered(_area: Area2D) -> void:
	velocity.y = 200.0 


func _on_surface_detector_area_exited(_area: Area2D) -> void:
	velocity.y -= 120.0


func _on_ground_detector_area_entered(_area: Area2D) -> void:
	velocity.y = 100.0 


func _on_ground_detector_area_exited(_area: Area2D) -> void:
	velocity.y -= 120.0
