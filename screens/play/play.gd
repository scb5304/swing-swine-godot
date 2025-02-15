extends Node2D

var score = 0
var speed = 1

func onAnyCoinHit():
	score += 1
	speed += 0.08
	return

# Called when the node enters the scene tree for the first time.
func _ready():
	$Coins/RightCoin.visible = true
	$Coins/BottomCoin.visible = true
	$Coins/LeftCoin.visible = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Piggy.rotation += speed * delta
	pass

func _on_right_coin_body_entered(body):
	print("Right")
	onAnyCoinHit()
	$Coins/RightCoin.visible = false
	$Coins/TopCoin.visible =true

func _on_bottom_coin_body_entered(body):
	print("Bottom")
	onAnyCoinHit()
	$Coins/BottomCoin.visible = false
	$Coins/RightCoin.visible = true

func _on_left_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Left")
	onAnyCoinHit()
	$Coins/LeftCoin.visible = false
	$Coins/BottomCoin.visible = true

func _on_top_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Top")
	onAnyCoinHit()
	$Coins/TopCoin.visible = false
	$Coins/LeftCoin.visible = true
