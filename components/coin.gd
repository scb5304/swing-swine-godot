extends Area2D

var color = ""
var tag = ""

func _ready():
	randomize_color()
	
func randomize_color():
	var coin_flip = randi() % 2
	if coin_flip == 0:
		$Sprite2D.texture = preload("res://assets/coin_gold.png")
		color = "Gold"
	else:
		$Sprite2D.texture = preload("res://assets/coin_silver.png")
		color = "Silver"
