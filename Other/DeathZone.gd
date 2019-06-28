extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Wumpus":
			body.die()