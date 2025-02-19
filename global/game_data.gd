extends Node

const SAVE_PATH = "user://savegame.json"

var last_score: int = 0
var high_score: int = 0
var money_total: int = 0
var setting_music_enabled: bool = true
var setting_sound_effects_enabled: bool = true

func _ready():
	print("Loading...")
	AudioServer.add_bus()
	if (GameData.load_game()):
		print("Success")
	else:
		print("Failed to load game")

func save_game():
	var data = {
		"high_score": high_score,
		"last_score": last_score,
		"money_total": money_total,
		"setting_sound_effects_enabled": setting_sound_effects_enabled,
		"setting_music_enabled": setting_music_enabled
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game() -> bool:
	var data = load_json_file(SAVE_PATH)
	print("Loading: " + str(data))
	high_score = data.get("high_score", 0)
	last_score = data.get("last_score", 0)
	money_total = data.get("money_total", 0)
	setting_sound_effects_enabled = data.get("setting_sound_effects_enabled", true)
	setting_music_enabled = data.get("setting_music_enabled", true)
	init_audio_bus()
	
	return true

func clear_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string("")
	file.close()
	
func init_audio_bus():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !setting_sound_effects_enabled)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !setting_music_enabled)

func load_json_file(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		print("Error: File not found - " + path)
		return {}
	
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var json = JSON.new()
	var parse_result = json.parse(content)
	if parse_result != OK:
		print("Error: Failed to parse JSON - " + path)
		return {}

	return json.get_data() as Dictionary
