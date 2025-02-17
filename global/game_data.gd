extends Node

const SAVE_PATH = "user://savegame.json"

var last_score: int = 0
var high_score: int = 0
var money_total: int = 0

func _ready():
	print("Loading...")
	if (GameData.load_game()):
		print("Success")
	else:
		print("Failed to load game")

func save_game():
	var data = {
		"high_score": high_score,
		"last_score": last_score,
		"money_total": money_total
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file exists")
		return false
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(content)
	if error != OK:
		print("Failed to parse save file")
		return false
	
	var data = json.get_data()
	print("Loading: " + str(data))
	high_score = data.get("high_score", 0)
	last_score = data.get("last_score", 0)
	money_total = data.get("money_total", 0)
	return true

func clear_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string("")
	file.close()
