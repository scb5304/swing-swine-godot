extends Control

const ShopItemScene = preload("res://screens/market/shop_item.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

func _ready():
	_load_shop_items()

func _load_shop_items():
	for item in GameData.items:
		var shop_item_scene = ShopItemScene.instantiate() # Create an instance
		update_item(shop_item_scene, item)
		shop_item_scene.pressed.connect(func(): _on_item_selected(shop_item_scene, item)) # Connect button click event
		items_container.add_child(shop_item_scene) # Add to list

func _on_item_selected(shop_item_scene, item):
	print("Selected item: " + item["name"])
	item["owned"] = true
	update_item(shop_item_scene, item)
	GameData.save_game()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func update_item(shop_item_scene, item):
	shop_item_scene.get_node("Name").text = item["displayName"] # Set name
	shop_item_scene.get_node("Price").text = str(item["price"]) # Set price
	shop_item_scene.get_node("Icon").texture = load("res://assets/images/accessories/" + item["name"] + ".png")
	shop_item_scene.get_node("OwnedText").visible = item.get("owned", false)
