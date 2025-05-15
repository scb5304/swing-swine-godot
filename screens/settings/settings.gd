extends CanvasLayer
const DialogScene = preload("res://components/dialog.tscn")

func _on_clear_app_data_button_pressed():
	var confirmation_dialog_scene = DialogScene.instantiate()
	confirmation_dialog_scene.positive_button_clicked.connect(_on_clear_app_data_confirmed.bind())
	add_child(confirmation_dialog_scene)
	confirmation_dialog_scene.show_dialog("confirmation", 
		"THIS WILL DELETE ALL SAVE DATA. This cannot be undone.", 
		"res://assets/basic_gui_bundle/Icons/SVG/Icon_Small_WhiteOutline_Check.svg", 
		"OK", 
		"CANCEL")
	
func _on_clear_app_data_confirmed():
	print("Cleared app data")
	GameData.clear_data()
	GameData.load_game()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func _on_about_button_pressed():
	get_tree().change_scene_to_file("res://screens/settings/about/about.tscn")
