extends CanvasLayer

@onready var water_label: PanelContainer = $WaterLabel
@onready var mud_label: PanelContainer = $MudLabel


func _ready() -> void:
	SignalBus.submerged_in_water.connect(water_label.show)
	SignalBus.exited_water.connect(water_label.hide)
	SignalBus.submerged_in_mud.connect(mud_label.show)
	SignalBus.exited_mud.connect(mud_label.hide)
