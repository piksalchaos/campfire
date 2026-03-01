extends Control

var captions: Array = [
	"Goldfish can actually learn and retain information 
	that spans over years.",
	"The ocean cover 70% of our planet, and yet ",
	"Why can’t blind people eat ocean? 
	Because it’s see-food.",
	"What kind of music sinks to the bottom of 
	the ocean? Heavy rock.",
	"Last night, I dreamed I was swimming in 
	an ocean of orange soda. But it was just a Fanta sea.",
	"What do you find in the middle of 
	the ocean? The letter “e”.",
	"Which are the strongest creatures 
	in the ocean? Mussels.",
	"Why did the manta ray want to talk to the diver? 
	He wanted to have a manta-man conversation.",
	"Why don’t scuba divers get good grades at school? 
	Because they are always below C level."
]

func _ready():
	$Timer.start()

func _on_timer_timeout() -> void:
	get_node("caption").text = (captions.pick_random())
