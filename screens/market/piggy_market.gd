extends Control

const ShopItemScene = preload("res://screens/market/shop_item.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

func _ready():
	_display_money_total()
	_load_shop_items()
	
func _display_money_total():
	$PiggyCoinCount/CoinCountText.text = str(GameData.money_total)

func _load_shop_items():
	for item in GameData.items:
		var shop_item_scene = ShopItemScene.instantiate()
		update_item(shop_item_scene, item)
		shop_item_scene.pressed.connect(func(): _on_item_selected(shop_item_scene, item))
		items_container.add_child(shop_item_scene)
	
func _on_item_selected(shop_item_scene, item):
	print("Selected item: " + item["name"])
	var owned: bool = item.get("owned", false)
	if (owned):
		print("Already own")
	else:
		_buy_item(shop_item_scene, item)
	
func _buy_item(shop_item_scene, item):
	var price: int = item["price"]
	if (price <= GameData.money_total):
		print("I can afford this")
		item["owned"] = true
		GameData.money_total -= price
		_display_money_total()
		update_item(shop_item_scene, item)
		GameData.save_game()
	else:
		print("I can't do it")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func update_item(shop_item_scene, item):
	shop_item_scene.get_node("Name").text = item["displayName"]
	shop_item_scene.get_node("Price").text = str(item["price"])
	shop_item_scene.get_node("Icon").texture = load("res://assets/images/accessories/" + item["name"] + ".png")
	shop_item_scene.get_node("OwnedText").visible = item.get("owned", false)
