extends Node2D

const Coin = preload("res://components/coin/coin.gd")

var score: int = 0
var speed: float = 0.9
var game_over: bool = false

var coins: Array[Node2D] = []

func _ready():
	coins = [
		$Coins/TopCoin,
		$Coins/RightCoin,
		$Coins/BottomCoin,
		$Coins/LeftCoin
	]

	_initialize_coins()

func _process(delta: float):
	if $Piggy.is_clockwise():
		$Piggy.rotation += speed * delta
	else:
		$Piggy.rotation -= speed * delta

func _unhandled_input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if !game_over:
			$Piggy.toggle_piggy_state(event.pressed)

func _on_right_coin_body_entered(body):
	_on_any_coin_hit($Coins/RightCoin)

func _on_bottom_coin_body_entered(body):
	_on_any_coin_hit($Coins/BottomCoin)

func _on_left_coin_body_entered(body):
	_on_any_coin_hit($Coins/LeftCoin)

func _on_top_coin_body_entered(body):
	_on_any_coin_hit($Coins/TopCoin)

func _initialize_coins():
	for coin in coins:
		coin.visible = true
		coin.get_node("CollisionShape2D").set_deferred("disabled", false)

	$Coins/TopCoin.visible = false
	$Coins/TopCoin.get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_any_coin_hit(hit_coin: Node2D):
	if hit_coin.type == Coin.COIN_TYPE_FLIP:
		hit_coin.collect()
		_do_score()
		_show_coin(hit_coin)
		$Piggy.flip()
	elif $Piggy.color != hit_coin.color:
		hit_coin.clash()
		_end_game()
	else:
		hit_coin.collect()
		_do_score()
		_hide_coin(hit_coin)
		
		var next_coin: Node2D = _get_next_coin(hit_coin)
		_show_coin(next_coin)

func _do_score():
	score += 1
	_increase_speed()
	$Score.score(score)
	print("Speed: " + str(speed), " Score: " + str(score))

func _increase_speed():
	var max_speed: float = 5.5
	var base_speed_increase: float = 0.11
	var decay_factor: float = 0.05

	var speed_before: float = speed
	speed += base_speed_increase / (1 + decay_factor * score)
	speed = min(speed, max_speed)
	print("Speed increased by " + str(speed - speed_before))

func _show_coin(coin: Node2D):
	coin.visible = true
	coin.get_node("CollisionShape2D").set_deferred("disabled", false)
	coin.spawn()

func _hide_coin(coin: Node2D):
	coin.visible = false
	coin.get_node("CollisionShape2D").set_deferred("disabled", true)
	
func _get_next_coin(hit_coin: Node2D) -> Node2D:
	var current_index: int = coins.find(hit_coin)
	var next_index: int = 0

	if $Piggy.is_clockwise():
		next_index = (current_index - 1 + coins.size()) % coins.size()
	else:
		next_index = (current_index + 1) % coins.size()

	return coins[next_index]

func _end_game():
	game_over = true
	speed = 0
	GameData.last_score = score

	$EndGameTimer.start()

func _on_end_game_timer_timeout():
	get_tree().change_scene_to_file("res://screens/gameover/game_over.tscn")
