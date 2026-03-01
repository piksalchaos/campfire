extends CanvasLayer

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_play_pressed() -> void:
	animated_sprite_2d.show()
	animated_sprite_2d.play("default")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
