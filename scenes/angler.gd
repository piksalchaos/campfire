extends CharacterBody2D

var SPEED: float = randf_range(60, 70)

@export var Goal: Node2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	navigation_agent_2d.target_position = Goal.global_position
	
func _physics_process(delta: float) -> void:
	var nav_direction: Vector2 = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity += nav_direction * SPEED * delta
	
	move_and_slide()

func _on_timer_timeout() -> void:
	if navigation_agent_2d.target_position != Goal.global_position:
		navigation_agent_2d.target_position = Goal.global_position
	timer.start()


func _on_hit_box_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
