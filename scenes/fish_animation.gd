extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func set_animation_speed_scale(speed_scale: float) -> void:
	animation_player.speed_scale = speed_scale
