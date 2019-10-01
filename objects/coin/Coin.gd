extends Area2D

export var value = 1

func _ready():
	pass

func _on_Coin_body_entered(body):
	if get_owner() != null:
		if body.get_name() == "Player":
			body.coin_collected += value
			get_owner().get_node("CanvasLayer/GUI/Coin/CoinCounter").set_text(str(body.coin_collected))
		$AnimationPlayer.play("Coin_collected")
		queue_free()
