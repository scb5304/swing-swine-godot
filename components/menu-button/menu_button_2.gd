extends TextureButton

@export var text: String
@export var icon: Texture2D

func _ready():
	$TextBack.text = text
	$TextFore.text = text
	$IconWrapper/Icon.texture = icon
