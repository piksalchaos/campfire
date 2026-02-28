extends Node2D

@export_category("Water Line")
@export var water_point: PackedScene
@export var spread: float = 0.0002
@export var waterDepth: float = 1000
@export_category("Water Spring")
@export var amountWaterNode: int = 5
@export var springOffset: float = 50
@export var targetHeight: float
@export var springConst: float = 0.0015
@export var dampConst: float = 0.03

@onready var waterPoly: Polygon2D = $Water


var springs: Array = []
var passes: int = 7


func addWater(amount: int, offset: float) -> void:
	var offsetX: float = 0
	while (amount):
		var water: Area2D = water_point.instantiate()
		water.targetHeight = targetHeight
		water.springConst = springConst
		water.dampConst = dampConst
		water.parent = self
		water.position.x += offsetX
		add_child(water)
		@warning_ignore("narrowing_conversion")
		offsetX += offset
		amount -= 1

func _ready() -> void:
	addWater(amountWaterNode, springOffset)
	
	for child: Variant in get_children():
		if child is Area2D:
			springs.append(child)
	
func _physics_process(_delta: float) -> void:
	var lDelta: Array
	var rDelta: Array
	
	for i: int in range(springs.size()):
		lDelta.append(0)
		rDelta.append(0)
	
	for j: int in range(passes):
		for i: int in range(springs.size()):
			if i > 0:
				lDelta[i] = spread * (springs[i].position.y - springs[i - 1].position.y)
				springs[i - 1].velocity += lDelta[i] 
			if i < springs.size() - 1:
				rDelta[i] = spread * (springs[i].position.y - springs[i + 1].position.y)
				springs[i + 1].velocity += rDelta[i]
	drawWater()

func splash(index: int, speed: float) -> void:
	if index >= 0 && index < springs.size():
		springs[index].velocity += speed
		
func drawWater() -> void:
	var surfacePoint: Array
	for spring: Area2D in springs:
		surfacePoint.append(spring.position)
	
	var waterPolyPoints: Array = surfacePoint
	
	waterPolyPoints.append(Vector2(surfacePoint[surfacePoint.size() - 1].x, targetHeight + waterDepth))
	waterPolyPoints.append(Vector2(surfacePoint[0].x, targetHeight + waterDepth))
	
	waterPoly.set_polygon(waterPolyPoints)
