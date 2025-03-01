extends Area2D

@export var max_angle: float = 7.0  # Maximum swing angle in degrees
@export var swing_speed: float = 1.1  # Adjust speed of swinging

@onready var piggy_sprite = $Sprite2D

var time_elapsed: float = 0.0

func _ready():
	self.input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			$OinkSound.play()

func _process(delta):
	time_elapsed += delta
	rotation_degrees = max_angle * sin(time_elapsed * swing_speed)
