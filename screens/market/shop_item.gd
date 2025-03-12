extends Button

func display_item(item):
	$Name.text = item["displayName"]
	$Name2.text = $Name.text
	$Price.text = str(item["price"])
	$IconWrapper/Icon.texture = load("res://assets/images/accessories/" + item["name"] + ".png")
	$OwnedText.visible = false
	$EquippedText.visible = false

	if item.get("equipped", false):
		$EquippedText.visible = true
		$Price.visible = false
		$BackgroundEquipped.visible = true
	elif item.get("owned", false):
		$OwnedText.visible = true
		$Price.visible = false
		$BackgroundOwned.visible = true
