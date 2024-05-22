extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Piggy/Sprite2D.rotation += 1 * delta
	$Piggy.rotation = 1 * $Piggy/Sprite2D.rotation
	pass


func _on_piggy_body_entered(body):
	print("here")
	pass # Replace with function body.


func _on_piggy_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("here again")
	pass # Replace with function body.
