extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.money_total += GameData.last_score
	var money_str: String = str(GameData.money_total)
	$PiggyCoinCount/CoinCountText.text = money_str
	
	var is_high_score: bool = false
	if (GameData.last_score > GameData.high_score):
		GameData.high_score = GameData.last_score
		is_high_score = true
		
	GameData.save_game()
	
	if (GameData.money_total <= 0 or GameData.items.any(func(item): return item.get("owned"))):
		$PiggyAd.visible = false
		
	var scoreStr: String = str(GameData.last_score)
	if (GameData.last_score < 1):
		$NiceText.text = "uh oh..."
		$YouGotText.text = "You didn't get any coins :("
	elif (GameData.last_score == 1):
		$NiceText.text = "that counts"
		$YouGotText.text = "You got a coin!"
	elif (is_high_score):
		$NiceText.text = "HIGH SCORE!!"
		$YouGotText.text = "You got " + scoreStr + " coins!"
		$HighScoreSound.play()
	elif (GameData.last_score < 5):
		$NiceText.text = "okay"
		$YouGotText.text = "You got " + scoreStr + " coins."
	elif (GameData.last_score < 25):
		$NiceText.text = "nice"
		$YouGotText.text = "You got " + scoreStr + " coins!"
	elif (GameData.last_score < 50):
		$NiceText.text = "whoa"
		$YouGotText.text = "You got " + scoreStr + " coins!"
	elif (GameData.last_score < 75):
		$NiceText.text = "wow"
		$YouGotText.text = "You got " + scoreStr + " coins!!"
	else:
		$NiceText.text = "wow!"
		$YouGotText.text = "You got " + scoreStr + " coins!!"

func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://screens/play/play.tscn")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func _on_piggy_coin_count_pressed():
	get_tree().change_scene_to_file("res://screens/market/piggy_market.tscn")
