extends Node2D

export (Array) var dialogue
onready var dialoguebox = get_parent().get_node("../Dialogue/Panel/RichTextLabel")
var can_talk
var sender = "King"

func _on_Area2D_body_entered(body):
	if body.name == "Wumpus":
		can_talk = true
		$Speak.show()

func _input(event):
	if event.is_action_pressed("x") and can_talk:
		dialoguebox._update(dialogue, sender)
		can_talk = false

func _on_Area2D_body_exited(body):
	if body.name == "Wumpus":
		can_talk = false
		$Speak.hide()
