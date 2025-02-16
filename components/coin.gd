extends Area2D

var color = ""
var tag = ""
var coin_flip_color = randi() % 2
var special_flip = randi() % 3 == 1

func _ready():
	randomize_color()
	
func randomize_color():
	special_flip = randi() % 8 == 1
	if special_flip:
		$Sprite2D.texture = preload("res://assets/coin_arrow.png")
		color = "Flip"
	elif coin_flip_color == 0:
		$Sprite2D.texture = preload("res://assets/coin_gold.png")
		color = "Gold"
	else:
		$Sprite2D.texture = preload("res://assets/coin_silver.png")
		color = "Silver"

func _process(delta):
	rotation += delta
		
