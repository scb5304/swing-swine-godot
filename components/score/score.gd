extends Label

var scoreVerticalPush = 2

func score(score):
	text = str(score)
	
	if score == 200:
		scoreVerticalPush = 13
	elif score == 100:
		scoreVerticalPush = 7
	elif score == 50:
		scoreVerticalPush = 5
	elif score == 25:
		scoreVerticalPush = 3

	global_position.y -= scoreVerticalPush
	$Timer.start()

func _on_score_timer_timeout():
	global_position.y += scoreVerticalPush
