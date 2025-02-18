extends Button

func _ready():
	_init_icon()

func _on_sound_button_pressed():
	GameData.setting_sound_effects_enabled = !GameData.setting_sound_effects_enabled
	GameData.init_audio_bus()
	_init_icon()

func _init_icon():
	if (GameData.setting_sound_effects_enabled):
		icon = preload("res://assets/images/icons/volume-high-custom.png")
	else:
		icon = preload("res://assets/images/icons/volume-off-custom.png")
