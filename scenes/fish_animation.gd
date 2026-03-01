extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprites: Node2D = $Sprites


func set_flip_v(is_flip_v: bool) -> void:
	sprites.scale.y = -1 if is_flip_v else 1

func set_animation_speed_scale(speed_scale: float) -> void:
	animation_player.speed_scale = speed_scale
