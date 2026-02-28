extends Area2D

<<<<<<< Updated upstream
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
	
=======

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
>>>>>>> Stashed changes
