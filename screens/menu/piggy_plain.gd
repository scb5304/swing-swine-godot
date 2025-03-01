extends Node2D
#
#var amplitude: float = deg_to_rad(5)  # Swing angle in radians (5 degrees)
#var period: float = 5.0            # Time for a full oscillation (seconds)
#var time_passed: float = 0.0
#
#func _process(delta: float) -> void:
	#time_passed += delta
	#rotation = amplitude * sin(2 * PI * time_passed / period)

@export var max_angle: float = 7.0  # Maximum swing angle in degrees
@export var swing_speed: float = 1.1  # Adjust speed of swinging

var time_elapsed: float = 0.0

func _process(delta):
	time_elapsed += delta
	rotation_degrees = max_angle * sin(time_elapsed * swing_speed)
