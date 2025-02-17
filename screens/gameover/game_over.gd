extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var moneyStr = str(GameData.money_total)
	$PiggyCoinCount/CoinCountText.text = moneyStr

	var scoreStr = str(GameData.last_score)
	if (GameData.last_score < 1):
		$NiceText.text = "uh oh..."
		$YouGotText.text = "You didn't get any coins :("
	elif (GameData.last_score == 1):
		$NiceText.text = "that counts"
		$YouGotText.text = "You got a coin!"
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://screens/play/play.tscn")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")
