extends CanvasLayer

@onready var water_label: PanelContainer = $WaterLabel
@onready var mud_label: PanelContainer = $MudLabel
@onready var climbing_label: PanelContainer = $ClimbingLabel


func _ready() -> void:
	SignalBus.submerged_in_water.connect(water_label.show)
	SignalBus.exited_water.connect(water_label.hide)
	SignalBus.submerged_in_mud.connect(mud_label.show)
	SignalBus.exited_mud.connect(mud_label.hide)
	SignalBus.climbable_entered.connect(climbing_label.show)
	SignalBus.climbable_exited.connect(climbing_label.hide)
