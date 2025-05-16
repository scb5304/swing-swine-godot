extends Node

const SAVE_PATH = "user://savegame.json"

var last_score: int = 0
var high_score: int = 0
var money_total: int = 0
var setting_music_enabled: bool = true
var setting_sound_effects_enabled: bool = true

var items = []

func _ready():
	print("Loading...")
	AudioServer.add_bus()
	load_game()

func save_game():
	var data = {
		"high_score": high_score,
		"last_score": last_score,
		"money_total": money_total,
		"setting_sound_effects_enabled": setting_sound_effects_enabled,
		"setting_music_enabled": setting_music_enabled,
		"items": items
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var contents = JSON.stringify(data)
	#print(contents)
	file.store_string(contents)
	file.close()

func load_game():
	var data = load_json_file(SAVE_PATH)
	if (data.is_empty()):
		print("New game")
	high_score = data.get("high_score", 0)
	last_score = data.get("last_score", 0)
	money_total = data.get("money_total", 0)
	setting_sound_effects_enabled = data.get("setting_sound_effects_enabled", true)
	setting_music_enabled = data.get("setting_music_enabled", true)
	
	#TODO: Add ability to add new items from latest accessories JSON
	items = data.get("items", GameData.load_json_file("res://assets/images/accessories/piggyAccessories.json").get("accessories", []))
	init_audio_bus()

func clear_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string("")
	file.close()
	
func init_audio_bus():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !setting_sound_effects_enabled)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !setting_music_enabled)

func load_json_file(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		return {}
	
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var json = JSON.new()
	var parse_result = json.parse(content)
	if parse_result != OK:
		return {}

	return json.get_data() as Dictionary
