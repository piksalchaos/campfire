extends Area2D

@export var targetHeight: float
@export var springConst: float = 0.0015
@export var dampConst: float = 0.03

var velocity: float
var force: float
var parent: Node2D

func HookesLaw(springConstant: float, dampling: float) -> void:
	var loss: float = -dampling * velocity
	force = -springConstant * (position.y - targetHeight) + loss
	velocity += force
	position.y += velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	HookesLaw(springConst, dampConst)

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		velocity =+ body.linear_velocity.y / 100
