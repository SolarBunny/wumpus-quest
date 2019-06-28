extends RichTextLabel

var dialogue = []
var page = 0
var has_dialogue
var sender : String
onready var player = get_parent().get_parent().get_node("../Wumpus")

func _ready():
	get_parent().hide()
	has_dialogue = false
	sender = ""
	visible_characters = 0
	$".."/Clyde.hide()

func _update(new_dialogue, new_sender):
	player.can_move = false
	dialogue = new_dialogue
	page = 0
	sender = new_sender
	if sender == "Clyde" or sender == "Balance" or sender == "Bravery" or sender == "Brilliance":
		$".."/Clyde.show()
	set_bbcode(dialogue[page])
	visible_characters = -1
	has_dialogue = true
	$"../"/chartimer.start()
	get_parent().show()

func _input(event):
	if has_dialogue:
		if event.is_action_pressed("ui_accept") or event.is_action_pressed("x"):
			if visible_characters >= get_total_character_count():
				if page < dialogue.size()-1:
					page += 1
					set_bbcode(dialogue[page])
					visible_characters = 0
				elif page == dialogue.size() - 1:
					get_parent().hide()
					has_dialogue = false
					dialogue = []
					player.can_move = true
					$".."/Clyde.hide()
					if sender == "King":
						get_tree().change_scene("res://Levels/Balance/Balance.tscn")
					elif sender == "Balance":
						stats.has_balance = true
						var balance_rune = get_parent().get_parent().get_node("../Props/BalanceRune")
						balance_rune.fade()
			else:
				visible_characters = get_total_character_count() - 1
	else:
		pass

func _on_chartimer_timeout():
	if has_dialogue and visible_characters != get_total_character_count():
		visible_characters += 1
		$"../"/blip.play()
