extends Button

func _ready():
	_init_icon()

func _on_music_button_pressed():
	GameData.setting_music_enabled = !GameData.setting_music_enabled
	GameData.init_audio_bus()
	_init_icon()

func _init_icon():
	if (GameData.setting_music_enabled):
		icon = preload("res://assets/music-custom.png")
	else:
		icon = preload("res://assets/music-off-custom.png")
