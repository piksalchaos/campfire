extends Node2D

@export_category("Water Line")
@export var ropePieces: PackedScene
@export var attachedPoint: Node2D
@export var amountRopeNode: int = 5

@onready var line_2d: Line2D = $Line2D
@onready var fix: StaticBody2D = $Fix
var ropes: Array

func addRope(amount: int) -> void:
	var offset: Vector2 = (attachedPoint.global_position - global_position) / amountRopeNode
	var currentOffset: Vector2 = Vector2(0, 0)
	var previous: Node2D = fix
	var rope: RigidBody2D
	
	
	while (amount):
		rope = ropePieces.instantiate()
		rope.position += currentOffset
		
		ropes.append(rope)
		line_2d.add_point(rope.position)
		
		add_child(rope)
		rope.pin_joint_2d.node_b = previous.get_path()
		previous = rope
		@warning_ignore("narrowing_conversion")
		currentOffset += offset
		amount -= 1
	var finalJoint: PinJoint2D = PinJoint2D.new()
	finalJoint.global_position = finalJoint.global_position
	rope.add_child(finalJoint)
	
	ropes.append(attachedPoint)
	line_2d.add_point(attachedPoint.position)
	
	finalJoint.node_a = rope.get_path()
	finalJoint.node_b = attachedPoint.get_path()
	
func _physics_process(_delta: float) -> void:
	drawRope()

func _ready() -> void:
	addRope(amountRopeNode)

func drawRope() -> void:
	var surfacePoint: Array
	for rope: Node2D in ropes:
		if rope is Rope:
			surfacePoint.append(rope.position)
		else:
			surfacePoint.append(to_local(rope.global_position))
	line_2d.points = surfacePoint
