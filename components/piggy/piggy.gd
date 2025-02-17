extends CharacterBody2D

var color = "Silver"

func toggle_piggy_state(is_pressed):
	if is_pressed:
		$Sprite2D.texture = preload("res://assets/piggy_gold_double.png")
		color = "Gold"
	else:
		$Sprite2D.texture = preload("res://assets/piggy_silver_double.png")
		color = "Silver"

func is_clockwise():
	return scale.x > 0

func flip():
	scale.x *= -1
	$PiggyFlipSound.play()
