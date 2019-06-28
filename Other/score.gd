extends Node

var score : int = 0
var deaths : int = 0
var has_balance : bool

func _ready() -> void:
	score = 0
	deaths = 0
	has_balance = false

func update_score() -> void :
	score += 1
	print(score)

func update_deaths() -> void:
	deaths += 1
	print(deaths)