extends Node2D

@export_category("Water Line")
@export var ropePieces: PackedScene
@export var attachedPoint: Node2D
@export var amountRopeNode: int = 5
@onready var path_2d: Path2D = $Path2D

@onready var fix: StaticBody2D = $Fix

func addRope(amount: int) -> void:
	var offset: Vector2 = (attachedPoint.global_position - global_position) / amountRopeNode
	var currentOffset: Vector2 = Vector2(0, 0)
	var previous: Node2D = fix
	var rope: RigidBody2D
	while (amount):
		rope = ropePieces.instantiate()
		rope.position += currentOffset
		path_2d.curve.add_point(rope.global_position)
		add_child(rope)
		rope.pin_joint_2d.node_b = previous.get_path()
		previous = rope
		@warning_ignore("narrowing_conversion")
		currentOffset += offset
		amount -= 1
	var finalJoint: PinJoint2D = PinJoint2D.new()
	finalJoint.global_position = finalJoint.global_position
	rope.add_child(finalJoint)
	finalJoint.node_a = rope.get_path()
	finalJoint.node_b = attachedPoint.get_path()

func _ready() -> void:
	addRope(amountRopeNode)
