extends Label
const Coin = preload("res://components/coin/coin.gd")

var scoreVerticalPush = 2
var scoreHorizontalPush = 0

func score(coin: Coin, score):
	text = str(score)
	scoreHorizontalPush = 0
	
	if (coin.mod == Coin.COIN_MOD_ULTRA):
		scoreVerticalPush = 30
		scoreHorizontalPush = 21
	elif score >= 200:
		scoreVerticalPush = 30
	elif score >= 100:
		scoreVerticalPush = 23
	elif score >= 50:
		scoreVerticalPush = 18
	elif score >= 25:
		scoreVerticalPush = 15
	else:
		scoreVerticalPush = 10

	print(scoreVerticalPush)
	global_position.y -= scoreVerticalPush
	global_position.x -= scoreHorizontalPush
	$Timer.start()

func _on_score_timer_timeout():
	global_position.y += scoreVerticalPush
	global_position.x += scoreHorizontalPush
