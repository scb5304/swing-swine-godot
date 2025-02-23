extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://screens/play/play.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://screens/settings/settings.tscn")

func _on_piggy_market_button_pressed():
	get_tree().change_scene_to_file("res://screens/market/piggy_market.tscn")
