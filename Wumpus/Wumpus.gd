extends "res://physicsobject.gd"

const SPEED = 200
export (Vector2) var spawnpos 
var jumpheight = -400
var anim : String = ""
var ducking
var can_move
var sender = "Clyde"
var balance_dialogue : Array = [
"(Beep Boop!)",
"Wumpus!",
"This is the Trial of Balance.",
"You'll be tested on your ability to gracefully jump from platform to platform.",
"Good luck! (Beep boop!)"
]
onready var score_count = $HUD/Score/Label
onready var dialogue_box = get_parent().get_node("Dialogue/Panel/RichTextLabel")
onready var shake = $Shake

func _ready():
	can_move = true
	ducking = false
 
	if get_parent().name == "Balance":
		dialogue_box._update(balance_dialogue, sender)
			
	
func _physics_process(delta):
	
	score_count.text = ("SCORE:" + (String(stats.score)))
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Titlescreen/TitleScreen.tscn")
	
	if can_move:
	
		if Input.is_action_pressed("ui_right") and not  Input.is_action_pressed("ui_left"):
			movedir.x = SPEED
		elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			movedir.x = -SPEED
		else:
			movedir.x = 0
	
		if Input.is_action_pressed("ui_down") and is_on_floor():
			ducking = true
		else:
			ducking = false
			
		if is_on_floor():
			if Input.is_action_just_pressed("ui_accept"):
				movedir.y = jumpheight
				$Jump.play()
		elif Input.is_action_just_released("ui_accept"):
			if movedir.y < -50:
				movedir.y = jumpheight * 0.3

	else:
		movedir.x = 0
		
		
			
	if ducking == true:
		movedir.x = 0
		
	
	var new_anim = "Idle"
	
	if movedir.x != 0:
		new_anim = "Walk"
	if movedir.y != 0:
		new_anim = "Jump"
	if ducking == true:
		new_anim = "Sit"
	
	if movedir.x > 0:
		$Sprite.scale.x = 1
	if movedir.x < 0:
		$Sprite.scale.x = -1
	
	if anim != new_anim:
		anim = new_anim
		$Anim.play(anim)

func die():
	hide()
	$CollisionShape2D.disabled = true
	$CollisionShape2D2.disabled = true
	$Die.play()
	can_move = false
	stats.update_deaths()
	shake.play('Shake')

func _on_Shake_animation_finished(anim_name):
	if anim_name == "Shake":
		position = spawnpos
		can_move = true
		$CollisionShape2D.disabled = false
		$CollisionShape2D2.disabled = false
		show()