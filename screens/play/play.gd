extends Node2D

var score = 0
var speed = 1

var touched = false

func onAnyCoinHit(coin):
	print("Hit " + coin.color)
	score += 1
	speed += 0.04
	$Score.text = str(score)
	if $Piggy.color != coin.color:
		print("Game over!")
		speed = 0
		$Coins/RightCoin.visible = false
		$Coins/BottomCoin.visible = false
		$Coins/LeftCoin.visible = false
		$Coins/TopCoin.visible = false
		print("You got " + str(score))
		get_tree().reload_current_scene()
	return

func _unhandled_input(event):
	if event is InputEventScreenTouch || event is InputEventMouseButton:
		if event.pressed:
			touched = true
			$Piggy/Sprite2D.texture = preload("res://assets/piggy_gold_double.png")
			$Piggy.color = "Gold"
		else:
			touched = false
			$Piggy/Sprite2D.texture = preload("res://assets/piggy_silver_double.png")
			$Piggy.color = "Silver"
			
func _ready():
	$Coins/RightCoin.visible = true
	$Coins/RightCoin/CollisionShape2D.set_deferred("disabled", false)
	
	$Coins/BottomCoin.visible = true
	$Coins/BottomCoin/CollisionShape2D.set_deferred("disabled", false)

	$Coins/LeftCoin.visible = true
	$Coins/LeftCoin/CollisionShape2D.set_deferred("disabled", false)

	$Coins/TopCoin.visible = false
	pass

func _process(delta):
	$Piggy.rotation += speed * delta

func _on_right_coin_body_entered(body):
	onAnyCoinHit($Coins/RightCoin)
	
	$Coins/RightCoin.visible = false
	$Coins/TopCoin.randomize_color()
	$Coins/TopCoin/CollisionShape2D.set_deferred("disabled", false)
	$Coins/TopCoin.visible = true

func _on_bottom_coin_body_entered(body):
	onAnyCoinHit($Coins/BottomCoin)
	$Coins/BottomCoin.visible = false
	$Coins/RightCoin.randomize_color()
	$Coins/RightCoin.visible = true

func _on_left_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	onAnyCoinHit($Coins/LeftCoin)
	$Coins/LeftCoin.randomize_color()
	$Coins/LeftCoin.visible = false
	$Coins/BottomCoin.visible = true

func _on_top_coin_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	onAnyCoinHit($Coins/TopCoin)
	$Coins/TopCoin.randomize_color()
	$Coins/TopCoin.visible = false
	$Coins/LeftCoin.visible = true
