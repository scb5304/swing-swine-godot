extends Control

const ShopItemScene = preload("res://screens/market/shop_item.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

var pending_purchase_item
var pending_shop_item_scene

func _ready():
	_display_money_total()
	_load_shop_items()
	
func _display_money_total():
	$PiggyCoinCount/CoinCountText.text = str(GameData.money_total)

func _load_shop_items():
	for child in items_container.get_children():
		child.queue_free()
	for item in GameData.items:
		var shop_item_scene = ShopItemScene.instantiate()
		_update_item(shop_item_scene, item)
		shop_item_scene.pressed.connect(func(): _on_item_selected(shop_item_scene, item))
		items_container.add_child(shop_item_scene)
	
func _on_item_selected(shop_item_scene, item):
	var owned: bool = item.get("owned", false)
	var equipped: bool = item.get("equipped", false)
	if (owned):
		if (!equipped):
			_equip_item(shop_item_scene, item)
		else:
			_unequip_item(shop_item_scene, item)
		_load_shop_items()
	else:
		_confirm_buy_item(shop_item_scene, item)
	
func _confirm_buy_item(shop_item_scene, item):
	var price: int = item["price"]
	if (price <= GameData.money_total):
		$PurchaseDialog.dialog_text = "Purchase " + item.name + " for " + str(item.price) + " coins?"
		self.pending_purchase_item = item
		$PurchaseDialog.popup_centered()

func _on_purchase_dialog_confirmed():
	var item = pending_purchase_item
	var shop_item_scene = pending_shop_item_scene
	item["owned"] = true
	GameData.money_total -= item["price"]
	_display_money_total()
	_equip_item(shop_item_scene, item)
	_load_shop_items()
	$PurchaseSound.play()
	GameData.save_game()

func _equip_item(shop_item_scene, item):
	for game_data_item in GameData.items:
		if game_data_item.slot == item.slot:
			game_data_item["equipped"] = false
	item["equipped"] = true
	
func _unequip_item(shop_item_scene, item):
	item["equipped"] = false

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")

func _update_item(shop_item_scene, item):
	shop_item_scene.get_node("Name").text = item["displayName"]
	shop_item_scene.get_node("Price").text = str(item["price"])
	shop_item_scene.get_node("Icon").texture = load("res://assets/images/accessories/" + item["name"] + ".png")
	shop_item_scene.get_node("OwnedText").visible = false
	shop_item_scene.get_node("EquippedText").visible = false

	if item.get("equipped", false):
		shop_item_scene.get_node("EquippedText").visible = true
	elif item.get("owned", false):
		shop_item_scene.get_node("OwnedText").visible = true
