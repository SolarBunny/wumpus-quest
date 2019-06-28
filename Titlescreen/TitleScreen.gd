extends Control

var mute : bool

func _ready():
	mute = false
	$Fade.play("fadein")
	$Buttons/VBoxContainer/Start.disabled = true
	$Buttons/VBoxContainer/Mute.disabled = true
	$Buttons/VBoxContainer/Quit.disabled = true

func _on_Start_pressed():
	$Fade.play("fadeout")
	$StartNoise.play()
	$Buttons/VBoxContainer/Start.disabled = true
	$Buttons/VBoxContainer/Mute.disabled = true
	$Buttons/VBoxContainer/Quit.disabled = true

func _on_Quit_pressed():
	$QuitNoise.play()

func _on_Fade_animation_finished(anim_name):
	if anim_name == "fadein":
		$Buttons/VBoxContainer/Start.grab_focus()
		$Buttons/VBoxContainer/Start.disabled = false
		$Buttons/VBoxContainer/Mute.disabled = false
		$Buttons/VBoxContainer/Quit.disabled = false
	elif anim_name == "fadeout":
		get_tree().change_scene("res://Other/Test.tscn")

func _on_Mute_pressed():
	if mute == false:
		AudioServer.set_bus_mute(0, true)
		$Buttons/VBoxContainer/Mute.text = "SOUND: OFF"
		mute = true
	elif mute == true:
		AudioServer.set_bus_mute(0, false)
		$Buttons/VBoxContainer/Mute.text = "SOUND: ON"
		mute = false
		$UnmuteNoise.play()

func _on_QuitNoise_finished():
	get_tree().quit()
