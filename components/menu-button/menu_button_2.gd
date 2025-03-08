extends TextureButton

@export var text: String
@export var icon: Texture2D

func _ready():
	$ButtonText/TextBack.text = text
	$ButtonText/TextFore.text = text
	$IconWrapper/Icon.texture = icon
