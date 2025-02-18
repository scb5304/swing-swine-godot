extends Label
const Coin = preload("res://components/coin/coin.gd")

var scoreVerticalPush = 2
var scoreHorizontalPush = 0

func score(coin: Coin, score):
	text = str(score)
	scoreHorizontalPush = 0
	
	if (coin.mod == Coin.COIN_MOD_ULTRA):
		scoreVerticalPush = 13
		scoreHorizontalPush = 5
	elif score >= 200:
		scoreVerticalPush = 13
	elif score >= 100:
		scoreVerticalPush = 7
	elif score >= 50:
		scoreVerticalPush = 5
	elif score >= 25:
		scoreVerticalPush = 3
	else:
		scoreVerticalPush = 2

	global_position.y -= scoreVerticalPush
	global_position.x -= scoreHorizontalPush
	$Timer.start()

func _on_score_timer_timeout():
	global_position.y += scoreVerticalPush
	global_position.x += scoreHorizontalPush
