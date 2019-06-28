extends KinematicBody2D

class_name physicsbody

var movedir = Vector2()
var wallclimb
const GRAVITY = Vector2(0, 800)
const WALLGRAV = Vector2(0, 250)
const FLOOR_NORMAL = Vector2(0, -1)
	
func _physics_process(delta):
	movedir += GRAVITY * delta
	
	movedir = move_and_slide(movedir, FLOOR_NORMAL)