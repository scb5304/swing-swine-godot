extends CharacterBody2D

var color = "Silver"

var hat_slot_item
var eyes_slot_item
var mustache_slot_item
var chest_award_slot_item

func _ready():
	$EquipmentSlots/HatSlot.visible = false
	$EquipmentSlots/EyesSlot.visible = false
	$EquipmentSlots/MustacheSlot.visible = false
	$EquipmentSlots/ChestAwardSlot.visible = false
	for item in GameData.items:
		if item.get("equipped", false):
			if item.slot == "hat":
				hat_slot_item = item
				_equip(hat_slot_item)
			if (item.slot == "eyes"):
				eyes_slot_item = item
				_equip(eyes_slot_item)
			if (item.slot == "mustache"):
				mustache_slot_item = item
				_equip(mustache_slot_item)
			if (item.slot == "chestAward"):
				chest_award_slot_item = item
				_equip(chest_award_slot_item)
			
func _equip(item):
	var texture = load("res://assets/images/accessories/" + item.name + ".png")
	if item.slot == "hat":
		$EquipmentSlots/HatSlot.texture = texture
		$EquipmentSlots/HatSlot.visible = true
	if item.slot == "eyes":
		$EquipmentSlots/EyesSlot.texture = texture
		$EquipmentSlots/EyesSlot.visible = true
	if item.slot == "mustache":
		$EquipmentSlots/MustacheSlot.texture = texture
		$EquipmentSlots/MustacheSlot.visible = true
	if item.slot == "chestAward":
		$EquipmentSlots/ChestAwardSlot.texture = texture
		$EquipmentSlots/ChestAwardSlot.visible = true

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
