extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Piggy.rotation += 0.02
	pass



func _on_right_coin_coin_hit():
	print("ouch")
	# $RightCoin.visible = false
	$RightCoin.collision_mask = 5
	$RightCoin.set_deferred("disabled", true)
	$RightCoin.set_deferred("freeze", true)
	$RightCoin.set_freeze_mode(RigidBody2D.FREEZE_MODE_STATIC)
	# Reset position?

	pass # Replace with function body.
