extends Area2D

export (Array) var dialogue 
onready var dialogue_box = get_parent().get_node("../Dialogue/Panel/RichTextLabel")
var sender = "Balance"
var can_interact : bool

func _ready():
	can_interact = false
	$Label.hide()
	connect("body_entered", self, "on_body_entered")

func _input(event):
	if event.is_action_pressed("x") and can_interact:
		stats.has_balance = true
		can_interact = false
		$Label.hide()
		dialogue_box._update(dialogue, sender)

func on_body_entered(body):
	if body.name == "Wumpus":
		can_interact = true
		$Label.show()

func fade():
	$AnimationPlayer.play("fade")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Other/Ending.tscn")