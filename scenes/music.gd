extends Node

@onready var bg_clean: AudioStreamPlayer = $Bg_Clean
@onready var bg_underwater: AudioStreamPlayer = $Bg_Underwater


func _ready() -> void:
	SignalBus.submerged_in_water.connect(play_underwater)
	SignalBus.exited_water.connect(play_clean)
	bg_clean.play()

func play_clean() -> void:
	bg_clean.play(bg_underwater.get_playback_position())
	bg_underwater.stop()

func play_underwater() -> void:
	bg_underwater.play(bg_clean.get_playback_position())
	bg_clean.stop()
