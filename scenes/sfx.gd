extends Node


func _ready() -> void:
	SignalBus.submerged_in_water.connect($Submerged.play)
	SignalBus.exited_water.connect($Air_Land.play)
	SignalBus.boosted.connect($Click.play)
