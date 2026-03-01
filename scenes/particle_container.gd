extends Node2D

const WATER_SPLASH_PARTICLES: Resource = preload("uid://bk8bgx2x8tr3v")


func _ready() -> void:
	SignalBus.water_splashed.connect(new_water_splash_particles)


func new_water_splash_particles(position: Vector2) -> void:
	var particles: CPUParticles2D = WATER_SPLASH_PARTICLES.instantiate()
	particles.position = position
	add_child(particles)
