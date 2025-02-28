extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clear_app_data_button_pressed():
	GameData.clear_data()
	GameData.load_game()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func _on_debug_money_pressed():
	GameData.money_total += 1000
	GameData.save_game()
