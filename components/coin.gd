extends Area2D

const COIN_TYPE_STANDARD = "STANDARD"
const COIN_TYPE_FLIP = "FLIP"

const COIN_COLOR_GOLD = "GOLD"
const COIN_COLOR_SILVER = "SILVER"

var type
var color

func _ready():
	spawn()
	
func spawn():
	type = ""
	color = ""
	
	if (randi() % 12 == 1):
		type = COIN_TYPE_FLIP
		$Sprite2D.texture = preload("res://assets/coin_arrow.png")
	else:
		type = COIN_TYPE_STANDARD
		if (randi() % 2 == 1):
			color = "Gold"
			$Sprite2D.texture = preload("res://assets/coin_gold.png")
		else:
			color = "Silver"
			$Sprite2D.texture = preload("res://assets/coin_silver.png")

func _process(delta):
	rotation += delta
		
