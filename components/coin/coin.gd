extends Area2D

const COIN_TYPE_STANDARD = "STANDARD"
const COIN_TYPE_FLIP = "FLIP"

const COIN_COLOR_GOLD = "GOLD"
const COIN_COLOR_SILVER = "SILVER"

const COIN_MOD_ULTRA = "ULTRA"

const COIN_ODDS_FLIP = 14

# Disable for now, needs to be a "bonus" score or something, too cheesy
const COIN_ODDS_ULTRA = 500

var type: String
var color : String
var mod: String

func _ready():
	spawn(0)

func spawn(score: int):
	type = ""
	color = ""
	
	if (score > 4 and randi() % COIN_ODDS_FLIP == 1):
		type = COIN_TYPE_FLIP
		$Sprite2D.texture = preload("res://assets/images/game/coin_arrow.png")
		$CoinArrowSpawnSound.play()
		return
	else:
		type = COIN_TYPE_STANDARD
		if (randi() % COIN_ODDS_ULTRA == 1):
			mod = COIN_MOD_ULTRA
		else:
			mod = ""

		if (randi() % 2 == 1):
			color = "Gold"
			if (mod == COIN_MOD_ULTRA):
				$Sprite2D.texture = preload("res://assets/images/game/coin_gold_ultra_2.png")
			else:
				$Sprite2D.texture = preload("res://assets/images/game/coin_gold.png")
		else:
			color = "Silver"
			if (mod == COIN_MOD_ULTRA):
				$Sprite2D.texture = preload("res://assets/images/game/coin_silver_ultra.png")
			else:
				$Sprite2D.texture = preload("res://assets/images/game/coin_silver.png")

func _process(delta):
	var mult_factor: float = 2
	if type == COIN_TYPE_FLIP:
		mult_factor = 4.5
	elif mod == COIN_MOD_ULTRA:
		mult_factor = 8.0
		
	rotation += delta * mult_factor
		
func collect():
	$CoinCollectSound.play()

func clash():
	$CoinClashSound.play()
