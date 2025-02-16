extends Node2D

var score = 0
var speed = 0.9

var touched = false

func doScore():
	score += 1
	increaseSpeed()
	$Score.score(score)
	
func onAnyCoinHit(coin):
	print($Piggy.color + " piggy hit " + coin.color + " coin " + coin.tag)
	if (coin.special_flip):
		doScore()
		$Piggy.scale.x *= -1
	elif $Piggy.color != coin.color:
		endGame()
		return
	else:
		doScore()

func isClockwise():
	return $Piggy.scale.x > 0
	
func increaseSpeed():
	if score < 10:
		speed += 0.08
	elif score < 25:
		speed += 0.05
	elif score < 50:
		speed += 0.03
	elif score < 100:
		speed += 0.015
	elif score < 150:
		speed += 0.005
	elif score < 300:
		speed += 0.0025
	else:
		speed += 0.0001

func endGame():
	print("Game over!")
	speed = 0
	$EndGameTimer.start()

func _on_end_game_timer_timeout():
	get_tree().reload_current_scene()

func _unhandled_input(event):
	if event is InputEventScreenTouch || event is InputEventMouseButton:
		if event.pressed:
			touched = true
			$Piggy/Sprite2D.texture = preload("res://assets/piggy_gold_double.png")
			$Piggy.color = "Gold"
		else:
			touched = false
			$Piggy/Sprite2D.texture = preload("res://assets/piggy_silver_double.png")
			$Piggy.color = "Silver"
			
func _ready():
	$Coins/RightCoin.visible = true	
	$Coins/RightCoin.tag = "right"
	$Coins/BottomCoin.visible = true
	$Coins/BottomCoin.tag = "bottom"
	$Coins/LeftCoin.visible = true
	$Coins/LeftCoin.tag = "left"
	$Coins/TopCoin.visible = false
	$Coins/TopCoin.tag = "top"
	$Coins/TopCoin/CollisionShape2D.set_deferred("disabled", true)
	pass

func _process(delta):
	if isClockwise():
		$Piggy.rotation += speed * delta
	else:
		$Piggy.rotation -= speed * delta

func showCoin(coin):
	coin.visible = true
	coin.get_node('CollisionShape2D').set_deferred("disabled", false)
	coin.randomize_color()

func hideCoin(coin):
	coin.visible = false
	coin.get_node('CollisionShape2D').set_deferred("disabled", true)

func _on_right_coin_body_entered(body):
	onAnyCoinHit($Coins/RightCoin)

	if $Coins/RightCoin.special_flip:
		showCoin($Coins/RightCoin)
	else:
		hideCoin($Coins/RightCoin)
		if isClockwise():
			showCoin($Coins/TopCoin)
		else:
			showCoin($Coins/BottomCoin)

func _on_bottom_coin_body_entered(body):
	onAnyCoinHit($Coins/BottomCoin)

	if $Coins/BottomCoin.special_flip:
		showCoin($Coins/BottomCoin)
	else:
		hideCoin($Coins/BottomCoin)
		if isClockwise():
			showCoin($Coins/RightCoin)
		else:
			showCoin($Coins/LeftCoin)

func _on_left_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	onAnyCoinHit($Coins/LeftCoin)

	if $Coins/LeftCoin.special_flip:
		showCoin($Coins/LeftCoin)
	else:
		hideCoin($Coins/LeftCoin)
		if isClockwise():
			showCoin($Coins/BottomCoin)
		else:
			showCoin($Coins/TopCoin)

func _on_top_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	onAnyCoinHit($Coins/TopCoin)

	if $Coins/TopCoin.special_flip:
		showCoin($Coins/TopCoin)
	else:
		hideCoin($Coins/TopCoin)
		if isClockwise():
			showCoin($Coins/LeftCoin)
		else:
			showCoin($Coins/RightCoin)
