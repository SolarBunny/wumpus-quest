extends Control

func _ready():
	$Button.grab_focus()
	if stats.deaths > 1:
		$Score2/Label.text = (
		"""You perished """
		+ str(stats.deaths) + """ times!""")
	elif stats.deaths == 1:
		$Score2/Label.text = ("You perished once.")
	elif stats.deaths < 1:
		$Score2/Label.text = ("You didn't die once!")
	
	if stats.score < 1:
		$Score/Label.text = (
		"""You didn't 
		get any coins!""")
	elif stats.score == 1:
		$Score/Label.text = ("You only got one coin!")
	elif stats.score > 1:
		$Score/Label.text = ("You got " + str(stats.score) + " coins!")

func _on_Button_pressed():
	get_tree().quit()
