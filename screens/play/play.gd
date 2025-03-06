extends CanvasLayer

const Coin = preload("res://components/coin/coin.gd")
const DEBUG_DISABLE_COIN_CLASH: bool = false

var score: int = 0
var speed: float = 0.9

var music_pitch_scale = 1.0

var game_inactive: bool = true

var coins: Array[Node2D] = []

func _ready():
	_initialize_coins()
	if GameData.high_score < 3:
		game_inactive = true
		$TutorialPanel.visible = true
	else:
		$TutorialPanel.visible = false
		$StartGameTimer.start()

func _on_tutorial_panel_gui_input(event):
	if (event is InputEventScreenTouch) and not event.pressed:
		$TutorialPanel.visible = false
		$StartGameTimer.start()

func _on_start_game_timer_timeout():
	game_inactive = false

func _process(delta: float):
	if game_inactive:
		return

	if $Piggy.is_clockwise():
		$Piggy.rotation += speed * delta
	else:
		$Piggy.rotation -= speed * delta

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if !game_inactive:
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
	coins = [
		$Coins/TopCoin,
		$Coins/RightCoin,
		$Coins/BottomCoin,
		$Coins/LeftCoin
	]
	for coin in coins:
		coin.visible = true
		coin.get_node("CollisionShape2D").set_deferred("disabled", false)

	$Coins/TopCoin.visible = false
	$Coins/TopCoin.get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_any_coin_hit(hit_coin: Node2D):
	if (hit_coin.type == Coin.COIN_TYPE_STANDARD 
		and $Piggy.color != hit_coin.color 
		and !DEBUG_DISABLE_COIN_CLASH):
		hit_coin.clash()
		_end_game()
		return
	
	hit_coin.collect()
	_on_coin_collected(hit_coin)

	if hit_coin.type == Coin.COIN_TYPE_FLIP:
		_show_coin(hit_coin)
		$Piggy.flip()
	else:
		_show_coin(_get_next_coin(hit_coin))
		_hide_coin(hit_coin)

func _on_coin_collected(hit_coin):
	var prior_score = score
	if (hit_coin.mod == Coin.COIN_MOD_ULTRA):
		score += 3
	else:
		score += 1
	$Score.score(hit_coin, score)
	_increase_speed()
	_increase_pitch()
	
	print("Speed: " + str(speed), " Score: " + str(score))
	if (prior_score == 0):
		$Sounds/Music1.play()

func _increase_speed():
	var max_speed: float = 8.0
	var base_speed_increase: float = 0.10
	var decay_factor: float = 0.04

	var speed_before: float = speed
	speed += base_speed_increase / (1 + decay_factor * score)
	speed = min(speed, max_speed)
	print("Speed increased by " + str(speed - speed_before))

func _increase_pitch():
	if (music_pitch_scale < 1.25):
		music_pitch_scale += 0.0005
	print("music_pitch_scale: " + str(music_pitch_scale))
	$Sounds/Music1.pitch_scale = music_pitch_scale

func _show_coin(coin: Node2D):
	coin.visible = true
	coin.get_node("CollisionShape2D").set_deferred("disabled", false)
	coin.spawn(score)

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
	game_inactive = true
	speed = 0
	GameData.last_score = score
	$Sounds/Music1.stop()
	$EndGameTimer.start()

func _on_end_game_timer_timeout():
	get_tree().change_scene_to_file("res://screens/gameover/game_over.tscn")

func _on_music_1_finished():
	$Sounds/Music1.play()
