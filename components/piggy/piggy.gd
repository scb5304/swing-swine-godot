extends CharacterBody2D

var color = "Silver"

var equipment_slots = {}

func _ready():
	for slot in $EquipmentSlots.get_children():
		var key = slot.name.replace("Slot", "").to_lower()
		equipment_slots[key] = slot
		slot.visible = false

	for item in GameData.items:
		if item.get("equipped", false):
			_equip(item)

func _equip(item):
	var texture_path = "res://assets/images/accessories/" + item.name + ".png"
	var texture = load(texture_path)

	if equipment_slots.has(item.slot):
		var slot_node = equipment_slots[item.slot]
		slot_node.texture = texture
		slot_node.visible = true
	else:
		push_warning("No equipment slot found for: " + item.slot)

func toggle_piggy_state(is_pressed):
	if is_pressed:
		$PiggySprite.texture = preload("res://assets/images/game/piggy_gold_double.png")
		color = "Gold"
	else:
		$PiggySprite.texture = preload("res://assets/images/game/piggy_silver_double.png")
		color = "Silver"

func is_clockwise():
	return scale.x > 0

func flip():
	scale.x *= -1
	$PiggyFlipSound.play()
