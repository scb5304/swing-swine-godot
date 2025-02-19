extends Control

const ShopItemScene = preload("res://screens/market/shop_item.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

var shop_items = GameData.load_json_file("res://assets/images/accessories/piggyAccessories.json").get("accessories", [])

func _ready():
	_load_shop_items()

func _load_shop_items():
	for item in shop_items:
		var shop_item = ShopItemScene.instantiate() # Create an instance
		
		shop_item.get_node("Name").text = item["displayName"] # Set name
		shop_item.get_node("Price").text = str(item["price"]) # Set price
		shop_item.get_node("Icon").texture = load("res://assets/images/accessories/" + item["name"] + ".png")

		#shop_item.pressed.connect(func(): _on_item_selected(item)) # Connect button click event

		items_container.add_child(shop_item) # Add to list

func _on_item_selected(item):
	print("Selected item: " + item["name"])
