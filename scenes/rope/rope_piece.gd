class_name Rope
extends RigidBody2D

@export var connection: NodePath
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var pin_joint_2d: PinJoint2D = $PinJoint2D
