extends CanvasLayer

const ShopItemScene = preload("res://screens/market/shop_item.tscn")
const DialogScene = preload("res://components/dialog.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

func _ready():
	GameData.money_total = 10000
	_display_money_total()
	_load_shop_items()
	
func _display_money_total():
	$PiggyCoinCount/CoinCountText.text = str(GameData.money_total)

func _load_shop_items():
	for child in items_container.get_children():
		child.queue_free()
	for item in GameData.items:
		var shop_item_scene = ShopItemScene.instantiate()
		shop_item_scene.display_item(item)
		shop_item_scene.pressed.connect(func(): _on_item_selected(shop_item_scene, item))
		items_container.add_child(shop_item_scene)
	
func _on_item_selected(shop_item_scene, item):
	var owned: bool = item.get("owned", false)
	if owned:
		_on_owned_item_selected(item)
	else:
		_confirm_buy_item(shop_item_scene, item)

func _on_owned_item_selected(item):
	if not item.get("equipped", false):
		_equip_item(item)
	else:
		_unequip_item(item)
	_load_shop_items()

func _confirm_buy_item(shop_item_scene, item):
	var price: int = item["price"]
	if price <= GameData.money_total:
		_show_purchase_confirmation(item)

func _show_purchase_confirmation(item):
	var confirmation_dialog_scene = DialogScene.instantiate()
	confirmation_dialog_scene.positive_button_clicked.connect(_on_purchase_dialog_confirmed.bind(item))
	add_child(confirmation_dialog_scene)
	confirmation_dialog_scene.show_dialog("confirmation", 
		"purchase " + item.displayName + " for " + str(item.price) + " coins? ", 
		"res://assets/basic_gui_bundle/Icons/SVG/Icon_Small_Coin.svg", 
		"OK", 
		"CANCEL")
		
func _on_purchase_dialog_confirmed(item):
	item["owned"] = true
	GameData.money_total -= item["price"]
	_display_money_total()
	_equip_item(item)
	_load_shop_items()
	$PurchaseSound.play()
	GameData.save_game()

func _equip_item(item):
	_unequip_items_in_slot(item["slot"])
	item["equipped"] = true
	
func _unequip_item(item):
	item["equipped"] = false

func _unequip_items_in_slot(slot):
	for game_data_item in GameData.items:
		if game_data_item.slot == slot:
			game_data_item["equipped"] = false

func _on_unequip_all_pressed():
	for game_data_item in GameData.items:
		game_data_item["equipped"] = false
	_load_shop_items()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")
