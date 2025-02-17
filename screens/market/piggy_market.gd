extends Control

const ShopItemScene = preload("res://screens/market/shop_item.tscn")

@onready var items_container = $ScrollContainer/VBoxContainer

var shop_items = [
	{"name": "Cool Hat", "price": 100, "icon": preload("res://assets/jesterHat.png")},
	{"name": "Sunglasses", "price": 200, "icon": preload("res://assets/shades.png")},
	{"name": "Bowtie", "price": 150, "icon": preload("res://assets/bow.png")}
]

func _ready():
	_load_shop_items()

func _load_shop_items():
	for item in shop_items:
		var shop_item = ShopItemScene.instantiate() # Create an instance
		var hbox = shop_item.get_node("HBoxContainer")
		
		hbox.get_node("Name").text = item["name"] # Set name
		hbox.get_node("Price").text = str(item["price"]) # Set price
		hbox.get_node("Icon").texture = item["icon"] # Set icon

		shop_item.pressed.connect(func(): _on_item_selected(item)) # Connect button click event

		items_container.add_child(shop_item) # Add to list

func _on_item_selected(item):
	print("Selected item: " + item["name"])
