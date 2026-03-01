extends AudioStreamPlayer

@onready var background_audio: AudioStreamPlayer = %AudioStreamPlayer
func _ready() -> void:
	background_audio.band_db = -60.0;
