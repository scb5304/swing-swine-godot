extends CanvasLayer

func _on_clear_app_data_button_pressed():
	GameData.clear_data()
	GameData.load_game()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")
