extends Area2D

export var value = 1

func _ready():
	if get_owner() != null:
		get_owner().coin_total += value

func _on_Coin_body_entered(body):
	if get_owner() != null:
		get_owner().coin_collected += value
		get_owner().get_node("CanvasLayer/GUI/CoinCounter").set_text(str(get_owner().coin_collected))
	$AnimationPlayer.play("Coin_collected")
	queue_free()
