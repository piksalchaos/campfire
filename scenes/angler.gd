extends CharacterBody2D

var SPEED: float = randf_range(200, 300)
const WATER_FRICTION: float = 300.0
const GRAVITY: float = 300.0

@export var Goal: Node2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var water_detector: Area2D = $WaterDetector

func _ready() -> void:
	navigation_agent_2d.target_position = Goal.global_position
	var start_timer: SceneTreeTimer = get_tree().create_timer(randf()*3.0)
	start_timer.timeout.connect(timer.start)
	
func _physics_process(delta: float) -> void:
	#var nav_direction: Vector2 = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	#velocity += nav_direction * SPEED * delta
	if water_detector.has_overlapping_areas():
		velocity = velocity.move_toward(Vector2.ZERO, WATER_FRICTION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, WATER_FRICTION * delta)
		velocity.y += GRAVITY * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	if navigation_agent_2d.target_position != Goal.global_position:
		navigation_agent_2d.target_position = Goal.global_position
	timer.start()
	animation_player.play("boost_start")
	sprite_2d.flip_h = Goal.global_position.x - position.x > 0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boost_start":
		animation_player.play("boost_end")
		velocity = (navigation_agent_2d.target_position - global_position).normalized() * SPEED
		#var tween: Tween = get_tree().create_tween()
		#tween.tween_property(self, "position", navigation_agent_2d.target_position, 1.0) \
				#.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func _on_hit_box_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_water_detector_area_exited(_area: Area2D) -> void:
	timer.stop()


func _on_water_detector_area_entered(_area: Area2D) -> void:
	timer.start()
