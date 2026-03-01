extends RigidBody2D

const WATER_FRICTION: float = 300.0
const GROUND_FRICTION: float = 1000.0
const AIR_FRICTION: float = 100.0
const GRAVITY: float = 300.0

const MAX_CHARGE_MS: int = 800

var is_charging: bool = false
var msec_charging_started: float
var squish_tween: Tween

@onready var fish_animation: Node2D = $FishAnimation
@onready var surface_detector: Area2D = $SurfaceDetector
@onready var ground_detector: Area2D = $GroundDetector
@onready var charge_bar: ProgressBar = $ChargeBar


func _ready() -> void:
	gravity_scale = 0

func is_in_air() -> bool:
	return not (surface_detector.has_overlapping_areas() or ground_detector.has_overlapping_areas())


func boost(milliseconds_charging: float) -> void:
	var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	var speed: float = minf(milliseconds_charging, MAX_CHARGE_MS) * 0.5
	linear_velocity = direction * speed


func _physics_process(delta: float) -> void:
	var deltaRotion: float = (get_global_mouse_position() - global_position).angle() - rotation
	angular_velocity = 0.0 if (angular_velocity >= 8.0 || angular_velocity <= -8.0) else clampf(angular_velocity, -10.0, 10.0)
	apply_torque_impulse(50 * deltaRotion)
	#print(angular_velocity)
	fish_animation.set_flip_v(rotation > PI/2 or rotation < -PI/2)
	
	if is_charging:
		charge_bar.value = float(Time.get_ticks_msec() - msec_charging_started) / MAX_CHARGE_MS
	
	if surface_detector.has_overlapping_areas():
		gravity_scale = 0
		linear_velocity = linear_velocity.move_toward(Vector2.ZERO, WATER_FRICTION * delta)
	elif ground_detector.has_overlapping_areas():
		gravity_scale = 0
		linear_velocity = linear_velocity.move_toward(Vector2.ZERO, GROUND_FRICTION * delta)
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, AIR_FRICTION/3 * delta)
		gravity_scale = 0.5
	fish_animation.set_animation_speed_scale(linear_velocity.length()/250)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("charge") and not is_in_air():
		print('sdfsf')
		is_charging = true
		charge_bar.show()
		msec_charging_started = Time.get_ticks_msec()
		squish_tween = get_tree().create_tween()
		squish_tween.tween_property(fish_animation, "scale", Vector2(0.8, 1.2), float(MAX_CHARGE_MS)/1000) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	if event.is_action_released("charge") and is_charging:
		SignalBus.boosted.emit()
		is_charging = false
		charge_bar.hide()
		boost(Time.get_ticks_msec() - msec_charging_started)
		squish_tween.stop()
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(fish_animation, "scale", Vector2(1.1, 0.85), 0.2) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(fish_animation, "scale", Vector2(1, 1), 0.2) \
				.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)


func _on_surface_detector_area_entered(_area: Area2D) -> void:
	linear_velocity.y = 200.0 
	SignalBus.water_splashed.emit(position)
	SignalBus.submerged_in_water.emit()


func _on_surface_detector_area_exited(_area: Area2D) -> void:
	linear_velocity.y -= 120.0
	SignalBus.water_splashed.emit(position)
	SignalBus.exited_water.emit()


func _on_ground_detector_area_entered(_area: Area2D) -> void:
	linear_velocity.y = 150.0 
	SignalBus.submerged_in_mud.emit()


func _on_ground_detector_area_exited(_area: Area2D) -> void:
	linear_velocity.y -= 120.0
	SignalBus.exited_mud.emit()
